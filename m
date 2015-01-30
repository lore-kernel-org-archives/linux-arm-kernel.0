From: fkan@apm.com (Feng Kan)
Date: Thu, 29 Jan 2015 17:07:11 -0800
Subject: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
In-Reply-To: <1894616.4yY7dajl4R@wuerfel>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
 <1412726809-7525-5-git-send-email-fkan@apm.com>
 <1894616.4yY7dajl4R@wuerfel>
Message-ID: <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 1:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 07 October 2014 17:06:47 Feng Kan wrote:
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 2e45ae3..a03042c 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -1009,6 +1009,15 @@ config I2C_CROS_EC_TUNNEL
>>         connected there. This will work whatever the interface used to
>>         talk to the EC (SPI, I2C or LPC).
>>
>> +config I2C_XGENE_SLIMPRO
>> +     tristate "APM X-Gene SoC I2C SLIMpro devices support"
>> +     depends on ARCH_XGENE && XGENE_SLIMPRO_MBOX
>
> Why this dependency on XGENE_SLIMPRO_MBOX?

>> +static int slimpro_i2c_blkrd(struct slimpro_i2c_dev *ctx, u32 chip, u32 addr,
>> +                             u32 addrlen, u32 protocol, u32 readlen,
>> +                             u32 with_data_len, void *data)
>> +{
>> +     dma_addr_t paddr;
>> +     u32 msg[3];
>> +     int rc;
>> +
>> +     paddr = dma_map_single(ctx->dev, ctx->dma_buffer, readlen,
>> +                            DMA_FROM_DEVICE);
>
> ctx->dev is probably the wrong device here. The i2c controller is not
> DMA capable itself, you need to have a pointer to the device that actually
> performs the DMA here.

Arnd, I do agree this may not be the best identification. There is no
representation for this on the Linux side. I could put it as NULL. However,
there are other i2c bus drivers that seem to do the same thing. Please
let me know what you think.

>
>
>> +     /* Request mailbox channel */
>> +     cl->dev = &pdev->dev;
>> +     cl->rx_callback = slimpro_i2c_rx_cb;
>> +     cl->tx_done = slimpro_i2c_tx_done;
>> +     cl->tx_block = true;
>> +     cl->tx_tout = SLIMPRO_OP_TO_MS;
>> +     cl->knows_txdone = false;
>> +     cl->chan_name = "i2c-slimpro";
>> +     ctx->mbox_chan = mbox_request_channel(cl);
>
> This is not the correct interface.
>
>> +     rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +     if (rc)
>> +             dev_warn(&pdev->dev, "Unable to set dma mask\n");
>
> Are you sure that this is the correct device to perform the DMA?
>
> Moreover, the mask doesn't match the usage: the slimpro_i2c_blkrd
> function passes in only the lower 32 bit of the address, which would
> be DMA_BIT_MASK(32).
The upper part of the address is passed in as part of the msg[1]

From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 17 May 2016 07:44:36 +0200
Subject: [linux-sunxi] Re: [PATCH 4/9] spi: sun4i: add DMA support
In-Reply-To: <20150820185850.GQ12027@sirena.org.uk>
References: <cover.1440080122.git.hramrach@gmail.com>
 <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach@gmail.com>
 <20150820185850.GQ12027@sirena.org.uk>
Message-ID: <CAOMqctQPUDm3XDf_YAVubzq2op=j6Qs6R4hjjCaa=ELoeHzjhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2015 at 16:56, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>> +             /* Enable Dedicated DMA requests */
>> +             reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>> +             reg |= SUN4I_CTL_DMAMC_DEDICATED;
>> +             sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
>> +             sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, trigger);
>> +     } else {
>> +             dev_dbg(&sspi->master->dev, "Using PIO mode for transfer\n");
>> +
>> +             /* Disable DMA requests */
>> +             reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>> +             sun4i_spi_write(sspi, SUN4I_CTL_REG,
>> +                             reg & ~SUN4I_CTL_DMAMC_DEDICATED);
>> +             sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
>> +
>> +             /* Fill the TX FIFO */
>> +             /* Filling the fifo fully causes timeout for some reason
>> +              * at least on spi2 on a10s */
>> +             sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
>> +     }
>> +
>>       /* Start the transfer */
>>       reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>>       sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
>> @@ -303,7 +363,12 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>>               goto out;
>>       }
>>
>> -     sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +     if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
>> +             /* The receive transfer should be the last one to finish */
>> +             dma_wait_for_async_tx(desc_rx);
>
> Nope, this is only meant for async_tx. You should register a callback
> in your transfer that will mark the completion structure as completed,
> and then drain the FIFO only if not using DMA.

What exactly is wrong with this?

I did not observe data corruption. Passing desc_rx to
dma_wait_for_async_tx looks odd on closer inspection, though. Will
look through some other spi driver code.

>> -     init_completion(&sspi->done);
>> +     master->dma_tx = dma_request_slave_channel_reason(&pdev->dev, "tx");
>> +     if (IS_ERR(master->dma_tx)) {
>> +             dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
>> +             ret = PTR_ERR(master->dma_tx);
>> +             goto err_free_master;
>> +     }
>> +
>> +     dma_sconfig.direction = DMA_MEM_TO_DEV;
>> +     dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.dst_addr = res->start + SUN4I_TXDATA_REG;
>> +     dma_sconfig.src_maxburst = 1;
>> +     dma_sconfig.dst_maxburst = 1;
>> +
>> +     ret = dmaengine_slave_config(master->dma_tx, &dma_sconfig);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
>> +             goto err_tx_dma_release;
>> +     }
>> +
>> +     master->dma_rx = dma_request_slave_channel_reason(&pdev->dev, "rx");
>> +     if (IS_ERR(master->dma_rx)) {
>> +             dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
>> +             ret = PTR_ERR(master->dma_rx);
>> +             goto err_tx_dma_release;
>> +     }
>> +
>> +     dma_sconfig.direction = DMA_DEV_TO_MEM;
>> +     dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.src_addr = res->start + SUN4I_RXDATA_REG;
>> +     dma_sconfig.src_maxburst = 1;
>> +     dma_sconfig.dst_maxburst = 1;
>
> We can't use a higher bust size?

Who actually does?

It accomplishes the transfer with burst size of 1 so that's good enough.

Researching alignment requirements and other oddities of Chinese
controllers when larger burst size is used can be topic for another
patch.


On 20 August 2015 at 20:58, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 20, 2015 at 02:19:46PM -0000, Emilio L?pez wrote:
>
>> -     sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +     if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
>> +             /* The receive transfer should be the last one to finish */
>> +             dma_wait_for_async_tx(desc_rx);
>
> What if it's a transmit only transfer?  We'll fall over to this...
>
>> +     } else {
>> +             sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +     }
>
> ...which manually reads data from the FIFO which doesn't seem like what
... which should be empty since RX is not enabled.
> we want, won't it conflict with the DMA?
It does not seem to conflict in practice.


Thanks

Michal

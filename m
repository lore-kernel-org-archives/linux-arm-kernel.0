From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 27 Jun 2010 00:08:02 -0600
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each SPI
	transfer
In-Reply-To: <4C249BA1.8010808@gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD83846FB@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C249BA1.8010808@gmail.com>
Message-ID: <AANLkTinO3kndb9bIAGlz4-h2TW64NGthHBRcVlE3gqun@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 6:05 AM, jason <jason77.wang@gmail.com> wrote:
> roman.tereshonkov at nokia.com wrote:
>>
>>
>>
>
> [snip]
>>>
>>> -----Original Message-----
>>>
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?}
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?c = 0;
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? } else if (c == 0 && tx == NULL) {
>>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? omap2_mcspi_set_enable(spi, 0);
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?}
>>>
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?*rx++ = __raw_readl(rx_reg);
>>>
>>
>> Why do you do this?
>> Reading the last word from the shift register buffer leads to the
>> receiving new data to the buffer.
>> The channel needs to be disabled before the last word reading.
>>
>>
>>
>
> Yes, you are right. If this patch can be accepted, i will remove those
> changes in the V2 patch.
> Please see my email replying grant likely's questions.

Hi Jason.

I'm assuming I can ignore this patch and wait for your V2.  I'll still
want an ack from other omap spi users before I apply it though.

g.

>
> Thanks,
> Jason.
>>
>>
>>>
>>> @@ -646,7 +641,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>>> spi_transfer *xfer)
>>> ? ? ? ? ? ? ? ? ? ? ? ?dev_err(&spi->dev, "EOT timed out\n");
>>> ? ? ? ?}
>>> out:
>>> - ? ? ? omap2_mcspi_set_enable(spi, 1);
>>> + ? ? ? omap2_mcspi_set_enable(spi, 0);
>>> ? ? ? ?return count - c;
>>> }
>>>
>>> @@ -894,7 +889,6 @@ static void omap2_mcspi_work(struct work_struct
>>> *work)
>>> ? ? ? ? ? ? ? ?cs = spi->controller_state;
>>> ? ? ? ? ? ? ? ?cd = spi->controller_data;
>>>
>>> - ? ? ? ? ? ? ? omap2_mcspi_set_enable(spi, 1);
>>> ? ? ? ? ? ? ? ?list_for_each_entry(t, &m->transfers, transfer_list) {
>>> ? ? ? ? ? ? ? ? ? ? ? ?if (t->tx_buf == NULL && t->rx_buf == NULL &&
>>> t->len) {
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?status = -EINVAL;
>>> @@ -931,6 +925,8 @@ static void omap2_mcspi_work(struct work_struct
>>> *work)
>>>
>>> ? ? ? ? ? ? ? ? ? ? ? ?mcspi_write_chconf0(spi, chconf);
>>>
>>> + ? ? ? ? ? ? ? ? ? ? ? omap2_mcspi_set_enable(spi, 1);
>>> +
>>> ? ? ? ? ? ? ? ? ? ? ? ?if (t->len) {
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned ? ? ? ?count;
>>>
>>> --
>>> 1.5.6.5
>>>
>>>
>>>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

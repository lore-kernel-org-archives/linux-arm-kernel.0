From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 5 Jul 2013 14:25:15 +0530
Subject: SPI: DUAL/QUAD support
In-Reply-To: <CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>	<20130704130017.GA25997@sig21.net>	<OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>	<20130704154927.GE27646@sirena.org.uk>	<OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>	<CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>	<51D67851.8020402@ti.com>
 <CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
Message-ID: <51D689F3.3070605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013 02:18 PM, yuhang wang wrote:
>> To add to all the discussion going on,
>> I am using a qspi controller with a spansion flash device.
>> I tried using quad read mode bit, and what is required to change in
>> my case is the following:
>>
>> 1. enable quad mode in flash configuration register.
>> 2. change my read opcode to QUAD READ opcode according to flash datasheet.
>> 3. Configure my qspi controller cmd reg to use 6 PIN whenever quad mode is
>> used.
>>
> Sorry, to the third point I am still not very clear. The first time,
> spi controller should send
> QUAD READ opcode to your spansion flash with 1 line, then receive datas from
> flash with 4 lines. So how does your controller master this process
> automatically.
>
> Please give me some details.
>
Its like, you pass txbuf and rxbuf from the spi core to your controller
driver. So, if your txbuf is not null then configure the controller
cmd register with WRITE_SINGLE and if rxbuf is not null then
configure the controller cmd register with READ_QUAD.

Something like this,
                 if (txbuf) {
                         dra7xxx_writel_data(qspi, *txbuf++,
                                 QSPI_SPI_DATA_REG, wlen);
                         dra7xxx_writel(qspi, qspi->dc, QSPI_SPI_DC_REG);
                         dra7xxx_writel(qspi, qspi->cmd | QSPI_WR_SNGL,
                                         QSPI_SPI_CMD_REG);
                         wait_for_completion(&qspi->word_complete);
                 }
                 if (rxbuf) {
                         printk("rx cmd %08x dc %08x\n",
                                 qspi->cmd | QSPI_RD_QUAD, qspi->dc);
                         dra7xxx_writel(qspi, INT_EN, 
QSPI_INTR_ENABLE_SET_REG);
                         dra7xxx_writel(qspi, qspi->dc, QSPI_SPI_DC_REG);
                     if (!quad_mode)
                             dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
                                             QSPI_SPI_CMD_REG);
                     else
                             dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_QUAD,
                                             QSPI_SPI_CMD_REG);
                  .......
                 }
> Thanks

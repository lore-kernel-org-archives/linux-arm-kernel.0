From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Feb 2012 11:32:15 +0800
Subject: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
 <20120209152340.GB11249@ponder.secretlab.ca>
 <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
Message-ID: <CAGsJ_4x2aKpwkgUrM06Stjq-U2z+0Zo4uWM_22NLYfJhxnPDyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > +static void spi_sirfsoc_tasklet_tx(unsigned long arg)
>> > +{
>> > + ? struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
>> > +
>> > + ? /* Fill Tx FIFO while there are left words to be transmitted */
>> > + ? while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS) &
>> > + ? ? ? ? ? ? ? ? ? SIRFSOC_SPI_FIFO_FULL)) &&
>> > + ? ? ? ? ? ? ? ? ? sspi->left_tx_cnt)
>> > + ? ? ? ? ? sspi->tx_word(sspi);
>>
>> Potential problem: if for any reason the device stalls and the FULL bit
>> doesn't get cleared, then this function will be stuck in a tight loop. ?This
>> may not be an issue, but it should be considered.
>
> Might timeout check.

after checking again, the original codes are right.
this function will not be in a tight loop actually because it doesn't
do any loop waiting. if SIRFSOC_SPI_FIFO_FULL is not cleared for some
hardware reason, this loop doesn't wait the FIFO_FULL to be cleared,
but just goes outside directly.
Only when the FIFO is not full, it sends a word by sspi->tx_word(sspi);
if FIFO_FULL doesn't get cleared for some reasons, finally,
wait_for_completion_timeout()  timeout will happen for the whole spi
transfer.

on the other hand, if SIRFSOC_SPI_FIFO_FULL is alway not set,
sspi->tx_word(sspi) will decrease sspi->left_tx_cnt and finnally make
the loop dead.

-barry

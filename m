From: jason77.wang@gmail.com (jason)
Date: Tue, 13 Jul 2010 21:26:09 +0800
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each
	SPI 	transfer
In-Reply-To: <E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C289CCB.7010409@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD84963BC@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C2C82E9.2010103@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
Message-ID: <4C3C6971.5010004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi roman,

How about my test case, does it expose the real problem?

I know my original patch was a big change both for PIO mode and for
DMA mode, because there is no DMA mode device on my platform and
i can't validate whether DMA mode works fine with that patch, it is a bit
risky to apply that patch to upstream.

This time i limit my patch to PIO mode, In theory, it is safe for all 
PIO transfers.
The side effect is to add a little bit overhead for a sequence of 
TX_ONLY transfers.
But it really can solve my touch panel issue.

Is the following patch acceptable?

 From 7b310e690fcccff400233a4c3340f42168016c92 Mon Sep 17 00:00:00 2001
From: Jason Wang <jason77.wang@gmail.com>
Date: Tue, 13 Jul 2010 18:05:59 +0800
Subject: [PATCH] spi/omap2_mcspi: disable channel after TX_ONLY transfer 
in PIO mode

In TX_ONLY transfer, the spi controller will receive datas
simultaneously and hold them in the rx register, these datas will
affect the direct following RX_ONLY transfer. So add disable channel
to purge those rx datas.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
drivers/spi/omap2_mcspi.c | 6 ++++++
1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..43fab41 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -644,6 +644,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct 
spi_transfer *xfer)
} else if (mcspi_wait_for_reg_bit(chstat_reg,
OMAP2_MCSPI_CHSTAT_EOT) < 0)
dev_err(&spi->dev, "EOT timed out\n");
+
+ /* disable chan to purge rx datas received in TX_ONLY transfer,
+ * otherwise these rx datas will affect the direct following
+ * RX_ONLY transfer.
+ */
+ omap2_mcspi_set_enable(spi, 0);
}
out:
omap2_mcspi_set_enable(spi, 1);
-- 
1.5.6.5



roman.tereshonkov at nokia.com wrote:
> Hi Jason,
>
> Your logs do not show what I wanted to see.
> But what I can see now at least is the case when TX is full and RX is full at the same time.
>
> 1.  Put 
> 	dev_dbg(&spi->dev, "status reg: %08x\n", __raw_readl(chstat_reg));
> 	after "do" and before "while (c)" in omap2_mcspi_txrx_pio function.
> 	I want to see how status is changed before and after TX or RX transaction.
> 2. Also try to make fake reading 
> 	__raw_readl(tx_reg)
> 	 after TX write in omap2_mcspi_txrx_pio.
> 	and 
> 	__raw_readl(cs->base + OMAP2_MCSPI_TX0);
> 	in mcspi_work function.
> 	This should exclude the posted write effect if such present.
>
> If you put more logging info from other spi registers it might be also usefull in problem analyzing.
> And it is better to concentrate on your test case 1. 
> So as it is the test which gives the bug with unknown yet nature.
>
>
>
> Regards
> Roman Tereshonkov
>
>   
>> -----Original Message-----
>> From: ext jason [mailto:jason77.wang at gmail.com] 
>> Sent: 01 July, 2010 14:59
>> To: Tereshonkov Roman (Nokia-MS/Helsinki)
>> Cc: grant.likely at secretlab.ca; david-b at pacbell.net; 
>> spi-devel-general at lists.sourceforge.net; 
>> linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan 
>> between each SPI transfer
>>
>> roman.tereshonkov at nokia.com wrote:
>>     
>>> Hi Jason,
>>>
>>> It is a little bit hard to analyze your logs.
>>> 1. You showed the bytes read in your own way but there is 
>>>       
>> the data reading in omap2_mcspi_txrx_pio function also.
>>     
>>> 2. For your third test case. You try to read data after 
>>>       
>> TX_ONLY, before triggering RX_ONLY, and get the right word.
>>     
>>> Looks like there is something wrong.
>>>
>>> Try to log MCSPI_CHxSTAT register to follow when RXS bit 
>>>       
>> (register RX is full) is set.
>>     
>>> And do not use the RX register reading in you own way. If 
>>>       
>> you need RX logging do it from omap2_mcspi_txrx_pio function.
>>     
>>>       
<snip>

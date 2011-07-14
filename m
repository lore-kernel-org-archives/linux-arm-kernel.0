From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 14 Jul 2011 04:34:29 +0000
Subject: [alsa-devel] [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <20110714030633.GA11559@opensource.wolfsonmicro.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-3-git-send-email-b29396@freescale.com>
	<20110713010346.GA18959@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721CD902@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110714030633.GA11559@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CE4BB@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Thursday, July 14, 2011 11:07 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de; lrg at ti.com;
> linux-arm-kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
>
> > We will just return an error if MCLK is not correct (not 32x or 48x).
> >         /* SAIF MCLK should be either 32*fs or 48*fs */
> >         if (saif->mclk_in_use && (mclk % 32 != 0) && (mclk % 48 != 0))
> >                 return -EINVAL;
> > Machine driver should guarantee to set a correct value since it's HW
> limitation.
> > Is that ok?
> 
> Please fix the code so you only check if the ratio is valid in one place,
> the code currently is too hard to read.
Sorry, here the comment is wrong:
        /* SAIF MCLK should be either 32*fs or 48*fs */
        if (saif->mclk_in_use && (mclk % 32 != 0) && (mclk % 48 != 0))
                return -EINVAL;
should be changed to:
/* SAIF MCLK should be either 32x or 48x */

BTW, do you mean the duplicate ratio checking is the following line?
        /* select the multiple of the base frequency rate of MCLK */
        switch (mclk / rate) {
.....
This is used to calculate the real ratio for mclk.
(The range is from 32x to 512x)

Yes, the code is a little confuse.
Since the mxs_saif_set_clk sets both saif clk ratio and saif mclk ratio,
I placed the mclk ratio checking in mxs_saif_set_clk rather than in
mxs_saif_get_mclk to avoid duplication.
And saif clk ratio needs to meet mclk ratio.
Maybe I need to add more comments in code as follows.
        /*
         * The SAIF clock should be either 384*fs or 512*fs
         *
         * For 32x mclk, set saif clk as 512x.
         * For 48x mclk, set saif clk as 384x.
         */

Do you have any suggestion to make it more easy to read?

> > So it seems, as you said, we may need to set symmetric_rates in the DAI.
> 
> Not if there are two separate SAIFs used for each direction - this is
> only relevant if one interface provides both playback and capture.
OK. But how to treat our case that although there are two separate SAIFs used
for each direction, they cannot work on different sample rate?
Is there any parameter like symmetric_rates to tell ASoc core that 
do not play a different rate stream While another SAIF is already working?

> 
> Because you return IRQ_HANDLED you're telling the IRQ infrastructure that
> you handled the interrupt but you didn't.  If you didn't handle an
> interrupt you should return IRQ_NONE instead.
Ok, understand. Thanks.
How about adding handle IRQ_NONE as follows:
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index bb32ee9..fefab24 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -475,6 +475,10 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
        unsigned int stat;

        stat = __raw_readl(saif->base + SAIF_STAT);
+       if (stat & (BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
+               BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ))
+               return IRQ_NONE;
+
        if (stat & BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ)
                dev_dbg(saif->dev, "underrun!!! %d\n", ++saif->fifo_underrun);

Regards
Dong Aisheng

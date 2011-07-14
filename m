From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 14 Jul 2011 10:39:13 +0000
Subject: [alsa-devel] [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <20110714030633.GA11559@opensource.wolfsonmicro.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-3-git-send-email-b29396@freescale.com>
	<20110713010346.GA18959@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721CD902@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110714030633.GA11559@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CE875@039-SN1MPN1-002.039d.mgd.msft.net>
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
> On Wed, Jul 13, 2011 at 08:14:09AM +0000, Dong Aisheng-B29396 wrote:
> 
> > > What if MCLK is not set corectly for some reason?  We'll just
> > > silently do nothing.
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

Hi Mark,

So far, thanks a lot for your kindly review.
I removed the duplicated checking as you indicated and changed the clk setting
flow a bit(also adding more comments) to try to make it more easy to read.

The code is as follows.
Is it ok for you?
Or you have any better suggestions?

/*
 * Set SAIF clock and MCLK
 */
static int mxs_saif_set_clk(struct mxs_saif *saif,
                                  unsigned int mclk,
                                  unsigned int rate)
{
        u32 scr;
        int ret;

        scr = __raw_readl(saif->base + SAIF_CTRL);
        scr &= ~BM_SAIF_CTRL_BITCLK_MULT_RATE;
        scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;

        /*
         * Set SAIF clock
         *
         * The SAIF clock should be either 384*fs or 512*fs.
         * If MCLK is used, the SAIF clk ratio needs to match mclk ratio.
         *  For 32x mclk, set saif clk as 512*fs.
         *  For 48x mclk, set saif clk as 384*fs.
         *
         * If MCLK is not used, we just set saif clk to 512*fs.
         */
        if (saif->mclk_in_use) {
                if (mclk % 32 == 0) {
                        scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
                        ret = clk_set_rate(saif->clk, 512 * rate);
                } else if (mclk % 48 == 0) {
                        scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
                        ret = clk_set_rate(saif->clk, 384 * rate);
                } else {
                        /* SAIF MCLK should be either 32x or 48x */
                        return -EINVAL;
                }
        } else {
                ret = clk_set_rate(saif->clk, 512 * rate);
                scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
        }

        if (ret)
                return ret;

        if (!saif->mclk_in_use) {
                __raw_writel(scr, saif->base + SAIF_CTRL);
                return 0;
        }

        /*
         * Program the over-sample rate for MCLK output if used
         *
         * The available MCLK range is 32x, 48x... 512x. The rate
         * could be from 8kHz to 192kH.
         */
        switch (mclk / rate) {
        case 32:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(4);
                break;
        case 64:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(3);
                break;
        case 128:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(2);
                break;
        case 256:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(1);
                break;
        case 512:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(0);
                break;
        case 48:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(3);
                break;
        case 96:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(2);
                break;
        case 192:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(1);
                break;
        case 384:
                scr |= BF_SAIF_CTRL_BITCLK_MULT_RATE(0);
                break;
        default:
                return -EINVAL;
        }

        __raw_writel(scr, saif->base + SAIF_CTRL);

        return 0;
}

Regards
Dong Aisheng

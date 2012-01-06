From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jan 2012 21:39:11 +0800
Subject: [PATCH 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <20120106114029.GB2610@pengutronix.de>
References: <1325817712-4573-1-git-send-email-shawn.guo@linaro.org>
 <1325817712-4573-2-git-send-email-shawn.guo@linaro.org>
 <20120106114029.GB2610@pengutronix.de>
Message-ID: <20120106133908.GD4790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 12:40:29PM +0100, Wolfram Sang wrote:
> On Fri, Jan 06, 2012 at 10:41:51AM +0800, Shawn Guo wrote:
> > Both imx23 and imx28 have CHIPID register at address 0x8001c310, which
> > can be used to identify the SoC.  This patch changes cpu_is_xxx and
> > __arch_decomp_setup to use this CHIPID register than machine type to
> > detect the chip between imx23 and imx28, so that we do not need to
> > change these functions whenever a new board/machine gets added.
> > 
> > Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> [...]
> 
> > +
> > +/*
> > + * MXS CPU types
> > + */
> > +#define CHIPID	(MXS_IO_ADDRESS(MXS_DIGCTL_BASE_ADDR) + 0x310)
> 
> Hmm, in general I don't like accessing single registers this way. Since
> we only read, it might work for now, but I think it will turn ugly the
> more we use from DIGCTL (which is annoying to abstract, yes).
> 
I agree with you.  But I do not really want to start writing a digctl.c 
just from this patch series.

> 0x310 should not be hardcoded. CHIPID could be MXS_CHIPID.
> 
I thought about those when I wrote the code, and decided not to bother,
since they are very really limited in mxs.h.  But now I think I should
bother, because your comments are here.

> > diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
> > index 6777674..a8de26d 100644
> > --- a/arch/arm/mach-mxs/include/mach/uncompress.h
> > +++ b/arch/arm/mach-mxs/include/mach/uncompress.h
> > @@ -55,16 +55,17 @@ static inline void flush(void)
> >  
> >  #define MX23_DUART_BASE_ADDR	0x80070000
> >  #define MX28_DUART_BASE_ADDR	0x80074000
> > +#define MXS_DIGCTL_CHIPID	0x8001c310
> >  
> >  static inline void __arch_decomp_setup(unsigned long arch_id)
> >  {
> > -	switch (arch_id) {
> > -	case MACH_TYPE_MX23EVK:
> > +	u16 chipid = (*(volatile unsigned long *) MXS_DIGCTL_CHIPID) >> 16;
> 
> Can't we use the cpu_is-functions here?
> 
No.  We are running with MMU off here.

-- 
Regards,
Shawn

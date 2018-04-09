From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 9 Apr 2018 11:24:31 +0200
Subject: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
In-Reply-To: <20180408110932.7ef29ed2@dell-desktop.home>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-9-mylene.josserand@bootlin.com>
 <20180403091218.t6xuq6csjp4uyy5u@flea>
 <20180403220628.19c9acaf@dell-desktop.home>
 <20180404074515.r6nbkpcyy6vfelbr@flea>
 <20180408110932.7ef29ed2@dell-desktop.home>
Message-ID: <20180409092431.yfupppnbypnx6ha5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 08, 2018 at 11:09:32AM +0200, Myl?ne Josserand wrote:
> Hello Maxime,
> 
> On Wed, 4 Apr 2018 09:45:15 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
> > On Tue, Apr 03, 2018 at 10:06:28PM +0200, Myl?ne Josserand wrote:
> > > Hello,
> > > 
> > > Thank you for the review.
> > > 
> > > On Tue, 3 Apr 2018 11:12:18 +0200
> > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >   
> > > > On Tue, Apr 03, 2018 at 08:18:31AM +0200, Myl?ne Josserand wrote:  
> > > > > Add the initialization of CNTVOFF for sun8i-a83t.
> > > > > 
> > > > > For boot CPU, Create a new machine that handles this
> > > > > function's call in an "init_early" callback.
> > > > > For secondary CPUs, add this function into secondary_startup
> > > > > assembly entry.
> > > > > 
> > > > > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > > > > ---
> > > > >  arch/arm/mach-sunxi/headsmp.S |  1 +
> > > > >  arch/arm/mach-sunxi/sunxi.c   | 18 +++++++++++++++++-
> > > > >  2 files changed, 18 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
> > > > > index 79890fbe5613..b586b7cf803a 100644
> > > > > --- a/arch/arm/mach-sunxi/headsmp.S
> > > > > +++ b/arch/arm/mach-sunxi/headsmp.S
> > > > > @@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
> > > > >  
> > > > >  ENTRY(sunxi_mc_smp_secondary_startup)
> > > > >  	bl	sunxi_mc_smp_cluster_cache_enable
> > > > > +	bl	smp_init_cntvoff
> > > > >  	b	secondary_startup
> > > > >  ENDPROC(sunxi_mc_smp_secondary_startup)
> > > > >  
> > > > > diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> > > > > index 5e9602ce1573..090784108c0a 100644
> > > > > --- a/arch/arm/mach-sunxi/sunxi.c
> > > > > +++ b/arch/arm/mach-sunxi/sunxi.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include <linux/platform_device.h>
> > > > >  
> > > > >  #include <asm/mach/arch.h>
> > > > > +#include <asm/smp_cntvoff.h>
> > > > >  
> > > > >  static const char * const sunxi_board_dt_compat[] = {
> > > > >  	"allwinner,sun4i-a10",
> > > > > @@ -62,7 +63,6 @@ MACHINE_END
> > > > >  static const char * const sun8i_board_dt_compat[] = {
> > > > >  	"allwinner,sun8i-a23",
> > > > >  	"allwinner,sun8i-a33",
> > > > > -	"allwinner,sun8i-a83t",
> > > > >  	"allwinner,sun8i-h2-plus",
> > > > >  	"allwinner,sun8i-h3",
> > > > >  	"allwinner,sun8i-r40",
> > > > > @@ -75,6 +75,22 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
> > > > >  	.dt_compat	= sun8i_board_dt_compat,
> > > > >  MACHINE_END
> > > > >  
> > > > > +void __init sun8i_cntvoff_init(void)
> > > > > +{
> > > > > +	smp_init_cntvoff();    
> > > > 
> > > > Can't this be moved to the SMP setup code?  
> > > 
> > > I tried to put it in the first lines of "sunxi_mc_smp_init" function
> > > but it did not work. I tried to find some callbacks to have an
> > > early "init" and I only found the "init_early"'s one. There is probably
> > > another way to handle that so do not hesitate to tell me any ideas.  
> > 
> > It's hard to say without more context about why it doesn't work. Have
> > you checked the order between early_initcall, the timer initialization
> > function and init_early?
> > 
> 
> Yes, I tested it. I wanted to test it again to give more context. Here
> is the boot log: http://code.bulix.org/n1x864-315948?raw
> I added printk in the 3 functions (with "===========>").
> 
> The "init_early" and "sun6i_timer" are executed before
> "arch_timer_of_init" (which is the function that parses the DT property
> that we used previously "arm,cpu-registers-not-fw-configured").
> The "sunxi_mc_smp_init" function is called later so I guess that is why
> it is not working in that case.

Ok. Make sure to mention that in your commit log.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/1d5b5127/attachment.sig>

From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 3 Apr 2013 03:58:43 +0000
Subject: [PATCH v3 1/3] ARM: davinci: clk framework support for
 enable/disable functionality
In-Reply-To: <51597108.4050706@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
 <1364204268-15010-1-git-send-email-avinashphilip@ti.com>
 <51597108.4050706@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAA74AB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 17:05:36, Nori, Sekhar wrote:
> On 3/25/2013 3:07 PM, Philip Avinash wrote:
> > Davinci clock framework currently not supporting clock enable/disable
> 
> This is incorrect. We do support enable disable of PSCs in davinci clock
> implementation.
> 
> > functionality on clock nodes. In Davinci platform, EHRPWM module requires
> 
> s/In Davinci platform/On DA850 SoC/
> 
> > support for clock enable/disable for TBCLK support. Hence this patch
> > adds support for enabling/disabling clocks depends on the availability
> > of the functionality.
> 
> I reworded the path description as below. Taking care of above and
> making some other minor changes:
> 
>     DaVinci clock implementation does not support clock enable/disable
>     functionality on non-PSC clock nodes.
> 
>     On DA850 SoC, EHRPWM module requires support for enable/disable
>     of TBCLK controlled using a system module register.
> 
>     This patch adds a method for enabling/disabling non-PSC clocks
>     into DaVinci clock implementation.
> 
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > ---
> > Changes since v2:
> > 	- start using "usecount" field in clk structure to
> > 	  enable/disable clocks.
> > 
> > Changes since v1:
> > 	- Add support for clock enable/disable functionality.
> > 
> >  arch/arm/mach-davinci/clock.c |   21 ++++++++++++++-------
> >  arch/arm/mach-davinci/clock.h |    2 ++
> >  2 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> > index d458558..960c7a5 100644
> > --- a/arch/arm/mach-davinci/clock.c
> > +++ b/arch/arm/mach-davinci/clock.c
> > @@ -35,19 +35,26 @@ static void __clk_enable(struct clk *clk)
> >  {
> >  	if (clk->parent)
> >  		__clk_enable(clk->parent);
> > -	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
> > -		davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
> > -				true, clk->flags);
> > +	if (clk->usecount++ == 0) {
> > +		if (clk->flags & CLK_PSC)
> > +			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
> > +					true, clk->flags);
> 
> This line break can be aligned to open parenthesis. This is reported by
> checkpatch --strict. I fixed this locally.
> 
> With these changed, I am queuing this patch for v3.10


Thanks for correction and queuing. checkpatch --strict is new to me.

Avinash

> 
> Thanks,
> Sekhar
> 

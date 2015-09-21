From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 21 Sep 2015 10:18:25 +0800
Subject: [PATCH RESEND 1/2] arm: berlin: use non-self-cleared reset
 register to reset cpu
In-Reply-To: <55FEF511.2050600@gmail.com>
References: <1442213265-1002-1-git-send-email-jszhang@marvell.com>
 <1442213265-1002-2-git-send-email-jszhang@marvell.com>
 <55FEF511.2050600@gmail.com>
Message-ID: <20150921101825.099b304f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Sun, 20 Sep 2015 20:04:01 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 14.09.2015 08:47, Jisheng Zhang wrote:
> > In Berlin SoCs, there are two kinds of cpu reset control registers: the
> > first one's corresponding bits will be self-cleared after some cycles,
> > while the second one's bits won't. Previously the first kind of reset
> > control register is used, this patch uses the second kind one to prepare
> > for the next hotplug commit.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >   arch/arm/mach-berlin/platsmp.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
> > index 34a3753..bde327b 100644
> > --- a/arch/arm/mach-berlin/platsmp.c
> > +++ b/arch/arm/mach-berlin/platsmp.c
> > @@ -17,7 +17,7 @@
> >   #include <asm/smp_plat.h>
> >   #include <asm/smp_scu.h>
> >
> > -#define CPU_RESET		0x00
> > +#define CPU_RESET		0x20
> 
> Jisheng,
> 
> I am fine with the patch itself, except that I'd like to rather
> rename the 0x00-register to CPU_RESET_SC with a comment about
> the self-clearing nature. The 0x20-register would then be named
> CPU_RESET_NON_SC and used the way you propose.

Good idea. And such comment would let people understand why do we change
as that.

> 
> Are you fine with me naming the registers accordingly while
> applying the patches?

Sure, I'm fine. Thank you very much.

> 
> Sebastian
> 
> >   #define RESET_VECT		0x00
> >   #define SW_RESET_ADDR		0x94
> > @@ -31,6 +31,8 @@ static inline void berlin_perform_reset_cpu(unsigned int cpu)
> >   	u32 val;
> >
> >   	val = readl(cpu_ctrl + CPU_RESET);
> > +	val &= ~BIT(cpu_logical_map(cpu));
> > +	writel(val, cpu_ctrl + CPU_RESET);
> >   	val |= BIT(cpu_logical_map(cpu));
> >   	writel(val, cpu_ctrl + CPU_RESET);
> >   }
> >
> 

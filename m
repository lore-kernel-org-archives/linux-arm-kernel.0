From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 19 Mar 2013 15:00:35 -0400 (EDT)
Subject: ARM: 7653/2: do not scale loops_per_jiffy when using a constant
 delay clock
In-Reply-To: <20130319181616.GB26713@mudshark.cambridge.arm.com>
References: <20130306022308.GA21539@mudshark.cambridge.arm.com>
 <20130306183751.GV17833@n2100.arm.linux.org.uk>
 <20130307033221.GC25137@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1303071417260.28820@syhkavp.arg>
 <20130319181616.GB26713@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1303191454560.3069@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Mar 2013, Will Deacon wrote:

> On Thu, Mar 07, 2013 at 06:37:30AM +0000, Nicolas Pitre wrote:
> > On Thu, 7 Mar 2013, Will Deacon wrote:
> > 
> > > On the topic of this patch: I still think that we should revert it and
> > > require cpufreq drivers to pass CPUFREQ_CONST_LOOPS in their flags (I guess
> > > the cpu0 platform data may need extending to take some flags).
> > 
> > I must disagree.  The constness here is a property of the timer source 
> > used to implement one of the udelay() providers.  Constness has no 
> > relation with cpufreq which may or may not impact a given udelay 
> > implementation.
> > 
> > > Longer term, we might want to assess the binding between timer-based 
> > > delays and loops_per_jiffy, but that's an entirely new problem.
> > 
> > Actually I do think that the lpj should always be scaled regardless, as 
> > this has meaning only for a CPU loop.  This is even more important if 
> > there is the possibility for switching between different 
> > implementations. The local timer based udelay implementation should 
> > simply never factor in lpj into its delay evaluation.
> > 
> > So the current patch is a stop gap to fix the problem today.  When 
> > something better is proposed we can remove this fix.
> 
> Ok, how about a simple change like the one below?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
> index 720799f..06777b9 100644
> --- a/arch/arm/include/asm/delay.h
> +++ b/arch/arm/include/asm/delay.h
> @@ -24,7 +24,7 @@ extern struct arm_delay_ops {
>         void (*delay)(unsigned long);
>         void (*const_udelay)(unsigned long);
>         void (*udelay)(unsigned long);
> -       bool const_clock;
> +       unsigned long lpj;

What about calling this ticks_per_jiffy so to make sure this is not 
confused with the other lpj?



>  } arm_delay_ops;
>  
>  #define __delay(n)             arm_delay_ops.delay(n)
> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> index 6b93f6a..0d90ed8 100644
> --- a/arch/arm/lib/delay.c
> +++ b/arch/arm/lib/delay.c
> @@ -58,7 +58,7 @@ static void __timer_delay(unsigned long cycles)
>  static void __timer_const_udelay(unsigned long xloops)
>  {
>         unsigned long long loops = xloops;
> -       loops *= loops_per_jiffy;
> +       loops *= arm_delay_ops.lpj;

... and here that could be ticks *= arm_delay_ops.ticks_per_jiffy to 
make it clearer as well.

Otherwise this is fine with me.


Nicolas

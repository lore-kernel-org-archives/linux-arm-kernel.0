From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 14 Aug 2017 19:11:35 +0200 (CEST)
Subject: [PATCH] ARM: bcm2836: Send event when onlining other cores
In-Reply-To: <fdecf317-d20b-1a5d-046f-56ef40c55d82@gmail.com>
References: <1502190295-53391-1-git-send-email-phil@raspberrypi.org>
 <1502190295-53391-2-git-send-email-phil@raspberrypi.org>
 <fdecf317-d20b-1a5d-046f-56ef40c55d82@gmail.com>
Message-ID: <1168905996.270506.1502730695418@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> Florian Fainelli <f.fainelli@gmail.com> hat am 14. August 2017 um 18:25 geschrieben:
> 
> 
> 
> 
> On 08/08/2017 04:04 AM, Phil Elwell wrote:
> > Secondary cores should enter a low-power idle state when waiting to
> > be started. The "wfe" instruction causes a core to wait until an event
> > or interrupt arrives before continuing to the next instruction, and
> > the "sev" instruction sends a wakeup event to the other cores.
> > 
> > Add an "sev" (and a memory barrier) to bcm2836_boot_secondary, the
> > function that wakes the waiting cores during booting. This is required
> > if the secondary cores are sitting in "wfe", and harmless if not.
> 
> Eric, should I just pick this up for the upcoming ARM SoC pull requests
> that I am preparing, or do you have more changes aside from the two tags
> I already merged?

this patch depends on series "ARM: bcm2836: Move SMP startup code to arch/arm".

I didn't had the time to test Phil's patch in all relevant cases. But i could at least prepare a branch with my changes with the acks.

Stefan

> 
> Thanks!
> 
> > 
> > Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> > ---
> >  arch/arm/mach-bcm/platsmp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
> > index 3fa1a99..7811160 100644
> > --- a/arch/arm/mach-bcm/platsmp.c
> > +++ b/arch/arm/mach-bcm/platsmp.c
> > @@ -312,6 +312,9 @@ static int bcm2836_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  	writel(virt_to_phys(secondary_startup),
> >  	       intc_base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
> >  
> > +	dsb(sy);
> > +	sev();
> > +
> >  	iounmap(intc_base);
> >  
> >  	return 0;
> > 
> 
> -- 
> Florian

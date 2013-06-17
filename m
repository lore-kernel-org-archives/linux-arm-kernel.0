From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 15:30:21 +0100
Subject: [PATCH] ARM: mm: cpu_fa526_do_idle: remove WFI
In-Reply-To: <5020304.hteFFmWh1u@wuerfel>
References: <1371476360-8751-1-git-send-email-jonas.jensen@gmail.com>
 <5020304.hteFFmWh1u@wuerfel>
Message-ID: <20130617143021.GI2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 04:14:03PM +0200, Arnd Bergmann wrote:
> On Monday 17 June 2013 15:39:20 Jonas Jensen wrote:
> > As it was already suggested by Russell King and Arnd Bergmann ( https://lkml.org/lkml/2013/5/16/133 ), moxart and gemini seem to be the only platforms using CPU_FA526, and instead of pointing arm_pm_idle to an empty function from platform code, it makes sense to remove WFI code from the processor specific idle function.
> > 
> > Note: moxart boots and prints to UART without this patch, but input is broken.
> 
> Please make sure you have proper line wraps. Lines in checkin
> comments should be no longer than 70 characters normally.
> 
> > Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Since this patch is independent from the actual platform support,
> it should go through Russell's patch tracker at
> http://www.arm.linux.org.uk/developer/patches/

Except... the patch is wrong.

> >  arch/arm/mm/proc-fa526.S |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
> > index d217e97..85280b1 100644
> > --- a/arch/arm/mm/proc-fa526.S
> > +++ b/arch/arm/mm/proc-fa526.S
> > @@ -81,9 +81,7 @@ ENDPROC(cpu_fa526_reset)
> >   */
> >  	.align	4
> >  ENTRY(cpu_fa526_do_idle)
> > -	mcr	p15, 0, r0, c7, c0, 4		@ Wait for interrupt
> > -	mov	pc, lr
> > -
> > +	nop

It replaces the WFI and return with a pure nop, so we will fall through
to cpu_fa526_dcache_clean_area().  Do we really want to clean a random
D cache entry depending on what r0 happened to hold at this point?  I
think not...

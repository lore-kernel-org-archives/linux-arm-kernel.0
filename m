From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Nov 2011 14:15:06 +0000
Subject: [PATCH v6 2/5] ARM: reset: implement soft_restart for jumping to
 a physical address
In-Reply-To: <CAHkRjk4e7EEVsoM9oPBa993FZubO5trXDmw6S3VAq4s4wLTwzg@mail.gmail.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-3-git-send-email-will.deacon@arm.com>
 <CAHkRjk4e7EEVsoM9oPBa993FZubO5trXDmw6S3VAq4s4wLTwzg@mail.gmail.com>
Message-ID: <20111122141506.GH32572@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 01:41:24PM +0000, Catalin Marinas wrote:
> On 16 November 2011 17:54, Will Deacon <will.deacon@arm.com> wrote:
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index a92ca50..577d092 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -92,29 +92,56 @@ static int __init hlt_setup(char *__unused)
> > ?__setup("nohlt", nohlt_setup);
> > ?__setup("hlt", hlt_setup);
> >
> > -void soft_restart(unsigned long addr)
> > +extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
> > +typedef void (*phys_reset_t)(unsigned long);
> > +
> > +/*
> > + * A temporary stack to use for CPU reset. This is static so that we
> > + * don't clobber it with the identity mapping. When running with this
> > + * stack, any references to the current task *will not work* so you
> > + * should really do as little as possible before jumping to your reset
> > + * code.
> > + */
> > +#define SOFT_RESTART_STACK_WORDS ? ? ? 32
> > +static u32 soft_restart_stack[SOFT_RESTART_STACK_WORDS];
> 
> Just for ABI stack alignment requirements, do we get the right
> alignment of this array in memory?

I'll make it u64[16] instead then (as per Dave's suggestion).

> > +static void __soft_restart(void *addr)
> > ?{
> > - ? ? ? /* Disable interrupts first */
> > - ? ? ? local_irq_disable();
> > - ? ? ? local_fiq_disable();
> > + ? ? ? phys_reset_t phys_reset;
> >
> > - ? ? ? /*
> > - ? ? ? ?* Tell the mm system that we are going to reboot -
> > - ? ? ? ?* we may need it to insert some 1:1 mappings so that
> > - ? ? ? ?* soft boot works.
> > - ? ? ? ?*/
> > + ? ? ? /* Take out a flat memory mapping. */
> > ? ? ? ?setup_mm_for_reboot();
> >
> > - ? ? ? /* Clean and invalidate caches */
> > + ? ? ? /* Clean and invalidate caches. */
> > ? ? ? ?flush_cache_all();
> >
> > - ? ? ? /* Turn off caching */
> > + ? ? ? /* Turn off caching. */
> > ? ? ? ?cpu_proc_fin();
> 
> A few unnecessary comment changes :) (it's not clear in the Linux
> coding style but many single-line comments don't have a full-stop.

I think the change to the setup_mm_for_reboot comment is valid, but I'll
leave the other guys without full stops, even if it annoys me unjustifiably
:)

> > +void soft_restart(unsigned long addr)
> > +{
> > + ? ? ? u32 *stack = soft_restart_stack + SOFT_RESTART_STACK_WORDS;
> 
> We could use ARRAY_SIZE() here and just avoid defining SOFT_RESTART_STACK_WORDS.

Sure.


Thanks for the review, I'll post a v2 of this after Russell has stablised the
reset patches.

Will

From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 22 Nov 2011 13:54:48 +0000
Subject: [PATCH v6 2/5] ARM: reset: implement soft_restart for jumping to
 a physical address
In-Reply-To: <CAHkRjk4e7EEVsoM9oPBa993FZubO5trXDmw6S3VAq4s4wLTwzg@mail.gmail.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-3-git-send-email-will.deacon@arm.com>
 <CAHkRjk4e7EEVsoM9oPBa993FZubO5trXDmw6S3VAq4s4wLTwzg@mail.gmail.com>
Message-ID: <20111122135448.GG2066@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 01:41:24PM +0000, Catalin Marinas wrote:
> On 16 November 2011 17:54, Will Deacon <will.deacon@arm.com> wrote:
> > Tools such as kexec and CPU hotplug require a way to reset the processor
> > and branch to some code in physical space. This requires various bits of
> > jiggery pokery with the caches and MMU which, when it goes wrong, tends
> > to lock up the system.
> >
> > This patch fleshes out the soft_restart implementation so that it
> > branches to the reset code using the identity mapping. This requires us
> > to change to a temporary stack, held within the kernel image as a static
> > array, to avoid conflicting with the new view of memory.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > ?arch/arm/kernel/process.c | ? 51 ++++++++++++++++++++++++++++++++++----------
> > ?1 files changed, 39 insertions(+), 12 deletions(-)
> >
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

Could we fix that by making it a u64 array?

In architecture versions where it matters, the compiler should also 64-
bit align such an array.

Of we're paranoid, we could align the initial stack pointer explicitly.

Cheers
---Dave

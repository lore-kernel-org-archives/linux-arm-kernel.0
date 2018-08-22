From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2018 17:03:56 +0200
Subject: [PATCH] ARM: use choice for kernel unwinders
In-Reply-To: <77d139d225e16b90d9b8da1982a11707@agner.ch>
References: <20180821222416.7771-1-stefan@agner.ch>
 <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
 <77d139d225e16b90d9b8da1982a11707@agner.ch>
Message-ID: <CAK8P3a0xNM6CK=rUUGX9eeO+OVrNGSYxiQ96gMVh6CrcpxVheg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 4:38 PM Stefan Agner <stefan@agner.ch> wrote:
> On 22.08.2018 12:02, Arnd Bergmann wrote:
> > On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
> >
> > Looks ok to me. I've added it to my randconfig test environment, you
> > will hear from me within a day if I run into build regressions.
> >
> > We may still want to clean up these three lines:
> >
> > lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC &&
> > !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !X86
> > lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> > !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> > lib/Kconfig.debug:  select FRAME_POINTER if !MIPS && !PPC && !S390 &&
> > !MICROBLAZE && !ARM_UNWIND && !ARC && !X86
> >
> > in which ARM is the odd case that currently depends on an architecture
> > specific rather than the architecture itself.
>
> I guess we would just follow X86 lead by saying ARM is guaranteed to
> have unwinding support, and hence we can add !ARM.

Right, that was the idea.

> > We could introduce a 'config ARCH_HAS_UNWINDER' symbol that gets
> > selected by mips, ppc, s390, microblaze, arm and x86 unconditionally,
> > and then simplify the 'select' statements here.
>
> Yeah I was thinking about something like that too.
>
> It seems to be a bit weird to me that lib/Kconfig.debug selects a
> specific stack unwinding technique...

This must be a historic artifact from the time when FRAME_POINTER
was the only unwinding method that existed. We may also have some
architectures that don't support any unwinding.

> Ideally other config symbol should just ask arch to make sure a
> unwinding technique is available (NEED_STACK_UNWINDING?) and arch then
> makes sure to provide a reasonable default.
>
> This then also would make it possible to select no stack unwinding in
> case arch supports that and all the users of stack unwinding are
> disabled too. Not sure how that exactly would look like in Kconfig, I
> was thinking like:
>
> choice
>     prompt "Choose kernel unwinder"
>     optional if !NEED_STACK_UNWINDING
>     default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
>     default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
>
> But "optional if" does not exist yet :-)

You can write that as

choice
      prompt "Choose kernel unwinder" if NEED_STACK_UNWINDING

This will hide the prompt when NEED_STACK_UNWINDING is disabled,
making it impossible to pick one of the two unwinders.

> Reading the comments in arch/arm/Kconfig.debug seems to suggest that
> once upon a time it was possible to disable stack unwinding on ARM.
>
> But then, maybe we don't really want to go there? Might be interesting
> for tinification efforts.

I'd leave that for another day ;-)

      Arnd

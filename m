From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Jul 2014 15:35:45 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <201407061739.22152.arnd@arndb.de>
References: <20140701234800.GA23577@sirena.org.uk> <4473002.jGohFvPsvi@wuerfel>
 <7B049AD4-78F8-4494-A2CB-57DD346107DA@arm.com>
 <201407061739.22152.arnd@arndb.de>
Message-ID: <20140707143545.GD32276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 06, 2014 at 04:39:21PM +0100, Arnd Bergmann wrote:
> On Saturday 05 July 2014, Catalin Marinas wrote:
> > On 5 Jul 2014, at 19:43, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > I think if a there is no way to turn off a feature, we can't really
> > > treat it as "deprecated", since we are lacking the most important tool
> > > to help users migrate away from it. Do you know why the architecture
> > > folks believe it makes sense to have distinct steps 1 and 2?
> > 
> > During this phase you usually only get compiler warnings which are
> > clearly not enough for already built apps.
> > 
> > But it looks like this is changing with ARMv8. SETEND is deprecated and
> > disable bit available. IT instruction also deprecated with a disable bit
> > (basically only allowing for one subsequent conditional instruction,
> > though I don?t think we can easily get rid of this one in user space).
> 
> Ok. I can also see ways to emulate SETEND from kernel side by modifying
> the user pt_regs, but I don't see how we could emulate IT without anything
> short of a full interpretation of user instructions from the kernel.

Single-step ;).

I need to get clarification but hopefully even if IT undefs, the SPSR IT
bits are still taken into account. So the emulation/warning handler
needs to decode IT and set SPSR in pt_regs accordingly before returning
to the next instruction.

But I agree, we can't remove this instruction entirely from the
architecture until we are completely sure there are no users (which is
nearly impossible).

> > > Another problem that I see with the way that features are phased out
> > > on ARM is how the hypervisor architecture makes it really hard to
> > > run a guest in an older architecture version. For instance on s390,
> > > you can basically emulate any prior machine from the past 50 years
> > > by selectively trapping some of the instructions from the guest
> > > into the hypervisor, at least for any instruction that has had
> > > a different behavior in the past.
> > 
> > That?s indeed not possible (basically a SWP at EL1 would trap as undef
> > at EL1 rather than EL2). But is there much value in this? Do we have a
> > large base of pre-built OS kernels? We are trying hard to get to single
> > Image, let alone using old builds of a kernel.
> 
> There are countless reasons why you'd want this actually, including:
> 
> - running an old arm7tdmi rtos build that you lost the source code for
>   but that would be cheaper to run on a new cortex-a7 emulating the
>   peripherals than to rewrite and revalidate

That's a too rare case to justify the additional CPU gates.

> - running OABI binaries in a 32-bit guest on an armv8 (or future version)

But you can already run an ARMv7 kernel now with OABI enabled on an
ARMv8 (either native or guest).

> - testing armv4 kernel builds in a kvm guest using qemu models

Again, this would require pre-ARMv6 MMU to be carried over for little
benefit (well, just to developers but hard to justify ARMv4 hardware
compatibility to marketing).

> - running Windows CE binaries in a virtual machine

It could be but a certain company never mentioned it.

> - running an ARMv8 SBSA based OS on ARMv9 hardware

I think back to ARMv7 we kind of have compatibility. What's missing is
some obsolete/undefined instructions to be trapped at EL2. This could
probably be considered if ARM decides to deprecated new instructions in
the future (though I think the current non-deprecated features are
stable enough).

-- 
Catalin

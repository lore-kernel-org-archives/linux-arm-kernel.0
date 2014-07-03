From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Jul 2014 18:13:56 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703150008.GX32514@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com> <5534788.ziUvZhb6y0@wuerfel>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
Message-ID: <20140703171356.GD28175@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 04:00:08PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 03, 2014 at 04:28:38PM +0200, Arnd Bergmann wrote:
> > On Thursday 03 July 2014 11:41:35 Catalin Marinas wrote:
> > > In my view, we don't break user space. It's rather a choice of how much
> > > legacy we support on ARMv8 hardware with an arm64 kernel. We don't even
> > > provide HWCAP_SWP for compat (not that anyone bothers checking that).
> > > It's a similar reason we choose not to support/emulate NWFPE or OABI
> > > even though there are existing binaries out there. If we choose to
> > > support SWP in the arm64 kernel, then we won't be able to break user
> > > space and have to carry it for a long time (unless you figure out a way
> > > to remove such features from the kernel because HWCAP certainly doesn't
> > > work, nor printk).
> > > 
> > > The ARM feature deprecation/removal cycle allows for two architecture
> > > revisions before being entirely removed. SWP has been deprecated in
> > > ARMv6, made optional in ARMv7 (with the possibility of disabling it if
> > > still available) and removed in ARMv8. The Thumb-1/2 instruction sets
> > > never had the SWP instruction. Even when SWP was available in certain
> > > ARMv7 implementations, it was no longer guaranteed to be atomic.
> > 
> > The problem really is that the ARM architecture deprecation method is
> > not compatible with the one we use in the kernel. I don't think there
> > is a good answer to that.
> > 
> > Note that other architectures have a different way of handling this
> > by never removing instructions. Obviously knowing that does not help
> > deal with the problem on ARM.
> 
> Actually, there's not much difference.
> 
> Let's take a look at what x86 does.  As the instruction set there
> develops, they too "retire" old instructions.  Rather than deprecating
> them and then removing them entirely, instructions which were once
> fast become slower because the core is no longer optimised to execute
> that instruction.
> 
> This encourages those who wish to have high performance to move to the
> new solution - but most importantly, existing software continues to
> work.

For many reasons, that's not always possible on ARM. Maybe the
architects learnt from this but it's not just ARM Ltd here. SWP wasn't
removed because ARM Ltd found something better but because on certain
hardware its atomicity semantics could no longer be provided (bus
locking), hence the default y if SMP for the ARMv7 SWP emulation.

> We can have that on ARM, but only for userspace.  The difference is
> that the kernel has to do the backwards compatibility rather than the
> (nonexistent) CPU microcode - and we do have that capability for SWP.
> 
> We may not find it desirable to do it for ARMv8, but _if_ we wish to
> allow users to migrate... if we wish to allow the existing set of
> userspace programs (some of which may be statically linked to their
> C library) to continue to work, there's only one option here.
> 
> While I can understand ARM Ltd

Please don't generalise to ARM Ltd here, even though Will and myself are
employed by ARM. We try hard to separate the kernel maintenance
decisions from the ARM (management) ones (in this instance, they may
actually differ).

> not wanting to pollute their nice clean
> ARM64 kernel with ARM32 "legacy junk", the fact of the matter is that
> even the CPU is already polluted with the legacy ARM32 stuff - it
> supports ARM32 binaries.

It's not about polluting the kernel (I've seen at least one incarnation
of such patch and, as you said, it's small), but rather setting some
limit on how much "legacy" we add to the arm64 kernel and commit to
maintain long term. Our stance has always been that only non-deprecated
ARMv7 features are supported by arm64 compat (that's why I don't buy the
breaking user-space argument). Let's say we allow non-deprecated ARMv5
features as well (SWP), how far back to we go? I doubt anyone thinks
ARMv4 and OABI is still needed on an arm64 kernel.

> However, we /do/ need the CP15 barrier instructions as well.  We,
> as kernel developers, have omitted to provide a way to tell userspace
> whether the CP15 barrier instructions are available, *and* whether
> the new barrier instructions are there too.  So, like it or not, it
> is /our/ failing as kernel developers that userspace is running into
> these issues, and it is /our/ responsibility to make sure that
> userspace does not break, irrespective of what path is chosed by
> the raw CPU support.

Such barriers currently only require an SCTLR_EL1 bit to be set. But
what do we do in future version of the architecture if they are no
longer present? I guess we start emulating them (or NAK architectural
attempts at removing them, though that's not always successful and on
some occasions for good reasons).

The main argument on this thread is about how far back in the
architecture roadmap should the arm64 kernel support/emulate. Do we need
to have a plan in place for eventually removing such emulation (like
maybe even making the emulation slower and slower)?

-- 
Catalin

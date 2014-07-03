From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jul 2014 18:48:37 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703171356.GD28175@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com> <5534788.ziUvZhb6y0@wuerfel>
 <20140703150008.GX32514@n2100.arm.linux.org.uk>
 <20140703171356.GD28175@arm.com>
Message-ID: <20140703174837.GA32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 06:13:56PM +0100, Catalin Marinas wrote:
> On Thu, Jul 03, 2014 at 04:00:08PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 03, 2014 at 04:28:38PM +0200, Arnd Bergmann wrote:
> > > On Thursday 03 July 2014 11:41:35 Catalin Marinas wrote:
> > > > In my view, we don't break user space. It's rather a choice of how much
> > > > legacy we support on ARMv8 hardware with an arm64 kernel. We don't even
> > > > provide HWCAP_SWP for compat (not that anyone bothers checking that).
> > > > It's a similar reason we choose not to support/emulate NWFPE or OABI
> > > > even though there are existing binaries out there. If we choose to
> > > > support SWP in the arm64 kernel, then we won't be able to break user
> > > > space and have to carry it for a long time (unless you figure out a way
> > > > to remove such features from the kernel because HWCAP certainly doesn't
> > > > work, nor printk).
> > > > 
> > > > The ARM feature deprecation/removal cycle allows for two architecture
> > > > revisions before being entirely removed. SWP has been deprecated in
> > > > ARMv6, made optional in ARMv7 (with the possibility of disabling it if
> > > > still available) and removed in ARMv8. The Thumb-1/2 instruction sets
> > > > never had the SWP instruction. Even when SWP was available in certain
> > > > ARMv7 implementations, it was no longer guaranteed to be atomic.
> > > 
> > > The problem really is that the ARM architecture deprecation method is
> > > not compatible with the one we use in the kernel. I don't think there
> > > is a good answer to that.
> > > 
> > > Note that other architectures have a different way of handling this
> > > by never removing instructions. Obviously knowing that does not help
> > > deal with the problem on ARM.
> > 
> > Actually, there's not much difference.
> > 
> > Let's take a look at what x86 does.  As the instruction set there
> > develops, they too "retire" old instructions.  Rather than deprecating
> > them and then removing them entirely, instructions which were once
> > fast become slower because the core is no longer optimised to execute
> > that instruction.
> > 
> > This encourages those who wish to have high performance to move to the
> > new solution - but most importantly, existing software continues to
> > work.
> 
> For many reasons, that's not always possible on ARM. Maybe the
> architects learnt from this but it's not just ARM Ltd here. SWP wasn't
> removed because ARM Ltd found something better but because on certain
> hardware its atomicity semantics could no longer be provided (bus
> locking), hence the default y if SMP for the ARMv7 SWP emulation.

Yes, absolutely true.  SWP is a /very/ heavy weight instruction on
hardware which implements it - it goes right down to the bus level,
sometimes to the peripheral buses as well.

StrongARM with a DC21285 did this - the StrongARM has a LOCK signal
which instructs the DC21285 to assert the PCI LOCK signal across
the read and the write.

> The main argument on this thread is about how far back in the
> architecture roadmap should the arm64 kernel support/emulate. Do we need
> to have a plan in place for eventually removing such emulation (like
> maybe even making the emulation slower and slower)?

That is something that we, as kernel developers, are not in a
position to dictate.

That is more a userland thing, and, just like when we try and deprecate
a kernel feature, if someone notices its gone missing, that's a bug
that needs to be resolved.

In other words, it's always been the case that you /can/ remove things
that no one is using, but if someone is using it, then it can't be
removed.

The second point here is that we as kernel developers have failed big
time to deal with this.

We have failed to provide the information that userspace needs to be
able to decide which instructions to use.  Yes, we have sort of done
it with HWCAPs, but HWCAPs are not entirely sufficient to determine
whether a particular instruction should be used.

For instance, looking just at HWCAPs, can you tell me at what point
the SWP instruction should no longer be used?

Remember that HWCAP_SWP is set for ARMv6 with SMP.  It's also set
for ARMv7 SMP as well:

processor       : 0
model name      : ARMv7 Processor rev 10 (v7l)
Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 

processor       : 1
model name      : ARMv7 Processor rev 10 (v7l)
Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 

So, the presence of HWCAP_SWP doesn't mean "you can use SWP".  In
fact, because of our failign, HWCAP_SWP is absolutely meaningless to
userland.

Moreover, since we _have_ been advertising its presence at ARMv7
despite it being deprecated, that's another bug on us as kernel
developers.

So when we go and say "you can no longer use this on ARMv8 because
the architecture deprecated it"... err, the architecture may have,
but we've *not* been telling userland about that.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

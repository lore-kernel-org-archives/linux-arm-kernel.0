From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Nov 2014 18:14:25 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141118105611.GC28279@e104818-lin.cambridge.arm.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <CALCETrUAtAJ1CmuxOFiiu53kAWwofUpFaBeFAZF7Th2VXPbHZg@mail.gmail.com>
 <20141118105611.GC28279@e104818-lin.cambridge.arm.com>
Message-ID: <20141118181425.GY18842@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was really hoping to avoid this thread, but I wanted to comment on the
suitability of hwcap as a discovery mechanism.

On Tue, Nov 18, 2014 at 10:56:12AM +0000, Catalin Marinas wrote:
> On Mon, Nov 17, 2014 at 05:38:46PM +0000, Andy Lutomirski wrote:
> > On Nov 17, 2014 6:39 AM, "Russell King - ARM Linux"
> > > Given that even cocked these up (just as what happened with the cache
> > > type register) decoding of the feature type registers depends on the
> > > underlying CPU architecture.
> > >
> > > So, even _if_ we exported the feature registers to userspace, you still
> > > need to know the CPU architecture to decode them properly, so you still
> > > need to parse the AT_PLATFORM string to get that information.
> > 
> > There's no need to expose the hardware feature registers as is.
> > Define your own sensible feature bits just for Linux.
> 
> We get regular questions about direct access to the hardware feature
> bits, many using the x86 cpuid instruction as argument. So far we
> couldn't see good enough reasons, otherwise we would have pushed such
> instruction in the ARMv8 architecture. It's also not a simple direct
> hardware access since the kernel may want to mask some features it does
> not support, which pretty much requires HWCAP or some banked CPUID
> registers in hardware.

Or trapping the undef exception from EL0 and emulating it in the kernel,
which doesn't require any extra hardware, allows the kernel to mask out
things it can't support and gives userspace the information it needs
under any scenario.

> Another class are dynamic loaders that don't yet have a C library
> loaded. However, as such loaders are the first entry point, I don't see
> why they couldn't access auxv directly. One particular scenario here is
> finding out which CPU micro-architecture (implementation) it is so that
> the dynamic loader could choose a more optimised library. CPUID would
> help partially here (get the actual MIDR identifying the CPU
> implementation rather than just features) but not on heterogeneous
> systems like big.LITTLE. Which means that we would still be better off
> with some extra features in auxv, maybe even listing the individual MIDR
> for all the CPUs in the system.

The only way I can see hwcap working is if we follow what the architecture
allows for in ARMv8, which is 4 bits per feature over (currently) around
10 32-bit registers. That would mean potentially exposing 1280 hwcaps,
which is clearly insane.

Instead, we currently advertise a tiny subset of the information exposing
in the ID registers and end up grouping it together in an ad-hoc way without
any buy-in from the instruction set architects. For example, how the
`asimd' hwcap on the arm64 kernel corresponds to feature bits in the MVFR
registers is not at all clear, especially as those hardware registers are
extended over time.

We've done a bit better with the crypto extensions, where we provide
fine-grained sha1, sha2 etc hwcaps, but this is based on the relavant 4-bit
fields in ISAR5 being positive values. I can't find any architectural
guarantees that this will work on future cores (e.g. bumping the 4-bit
field to indicate a subset of previous functionality).

My position is that hwcap is trying to group fine-grained architectural
features into higher level Linux features, but that's likely to lead to
an unmaintainable mess as the feature diversity of real systems continues
to grow. We can fix this easily by exposing the features to userspace in
the form that is described by the architecture (probably with a single
HWCAP to say that such an access won't result in SIGILL).

Will

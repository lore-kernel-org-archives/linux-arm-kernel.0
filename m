From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Nov 2014 10:56:12 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <CALCETrUAtAJ1CmuxOFiiu53kAWwofUpFaBeFAZF7Th2VXPbHZg@mail.gmail.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <CALCETrUAtAJ1CmuxOFiiu53kAWwofUpFaBeFAZF7Th2VXPbHZg@mail.gmail.com>
Message-ID: <20141118105611.GC28279@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 05:38:46PM +0000, Andy Lutomirski wrote:
> On Nov 17, 2014 6:39 AM, "Russell King - ARM Linux"
> <linux@arm.linux.org.uk> wrote:
> >
> > On Mon, Nov 17, 2014 at 01:54:13PM +0000, Catalin Marinas wrote:
> > > If you haven't noticed, the distinction between ARMv6 and ARMv7 has been
> > > blurred enough (guess why cpu_architecture() reports ARMv7 for
> > > ARM11MPCore). ARM is trying to move away from architecture version
> > > numbers, which are rather useful for marketing, to proper feature
> > > detection based on CPUID. Whether there is an ARMv9 or not, it's
> > > irrelevant to what Linux should do (i.e. use CPUID rather than guess
> > > features based on architecture version numbers).
> >
> > That may be what is desired, but unfortunately we have no way to export
> > all the intricate feature registers to userspace.  No, elf hwcaps don't
> > support it, there's only 64 bits split between two words there, and
> > there are many more than just 64 bits of feature registers.
> 
> That's a ridiculous argument.  Linux can freely add bits.
> 
> You could add AT_ARM_FEATURES that points to a length followed by the
> indicated number of words, or you could just keep adding new HWCAP
> fields as needed.  This is expandable forever.

That's fine by me, I don't have a problem with more hwcap bits.

> > Given that even cocked these up (just as what happened with the cache
> > type register) decoding of the feature type registers depends on the
> > underlying CPU architecture.
> >
> > So, even _if_ we exported the feature registers to userspace, you still
> > need to know the CPU architecture to decode them properly, so you still
> > need to parse the AT_PLATFORM string to get that information.
> 
> There's no need to expose the hardware feature registers as is.
> Define your own sensible feature bits just for Linux.

We get regular questions about direct access to the hardware feature
bits, many using the x86 cpuid instruction as argument. So far we
couldn't see good enough reasons, otherwise we would have pushed such
instruction in the ARMv8 architecture. It's also not a simple direct
hardware access since the kernel may want to mask some features it does
not support, which pretty much requires HWCAP or some banked CPUID
registers in hardware.

There seems to be a category of software that can't access HWCAP or
/proc/self/auxv. This is Android software, I'm not sure how the
developers came to this conclusion but they think allowing
/proc/cpuinfo access is ok but not /proc/self/auxv. I'm not sure direct
cpuid access is a good enough argument for such scenario. To me it looks
like something they should solve in their security implementation.

Another class are dynamic loaders that don't yet have a C library
loaded. However, as such loaders are the first entry point, I don't see
why they couldn't access auxv directly. One particular scenario here is
finding out which CPU micro-architecture (implementation) it is so that
the dynamic loader could choose a more optimised library. CPUID would
help partially here (get the actual MIDR identifying the CPU
implementation rather than just features) but not on heterogeneous
systems like big.LITTLE. Which means that we would still be better off
with some extra features in auxv, maybe even listing the individual MIDR
for all the CPUs in the system.

-- 
Catalin

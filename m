From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Nov 2014 18:32:09 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141118181425.GY18842@arm.com>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <CALCETrUAtAJ1CmuxOFiiu53kAWwofUpFaBeFAZF7Th2VXPbHZg@mail.gmail.com>
 <20141118105611.GC28279@e104818-lin.cambridge.arm.com>
 <20141118181425.GY18842@arm.com>
Message-ID: <20141119183209.GJ7156@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Nov 18, 2014 at 06:14:25PM +0000, Will Deacon wrote:
> I was really hoping to avoid this thread, but I wanted to comment on the
> suitability of hwcap as a discovery mechanism.

Such discussions come up regularly, so I think we should stick to this
thread and try to sort it out (it would be good to get the glibc folk to
join).

> On Tue, Nov 18, 2014 at 10:56:12AM +0000, Catalin Marinas wrote:
> > On Mon, Nov 17, 2014 at 05:38:46PM +0000, Andy Lutomirski wrote:
> > > On Nov 17, 2014 6:39 AM, "Russell King - ARM Linux"
> > > > Given that even cocked these up (just as what happened with the cache
> > > > type register) decoding of the feature type registers depends on the
> > > > underlying CPU architecture.
> > > >
> > > > So, even _if_ we exported the feature registers to userspace, you still
> > > > need to know the CPU architecture to decode them properly, so you still
> > > > need to parse the AT_PLATFORM string to get that information.
> > > 
> > > There's no need to expose the hardware feature registers as is.
> > > Define your own sensible feature bits just for Linux.
> > 
> > We get regular questions about direct access to the hardware feature
> > bits, many using the x86 cpuid instruction as argument. So far we
> > couldn't see good enough reasons, otherwise we would have pushed such
> > instruction in the ARMv8 architecture. It's also not a simple direct
> > hardware access since the kernel may want to mask some features it does
> > not support, which pretty much requires HWCAP or some banked CPUID
> > registers in hardware.
> 
> Or trapping the undef exception from EL0 and emulating it in the kernel,
> which doesn't require any extra hardware, allows the kernel to mask out
> things it can't support and gives userspace the information it needs
> under any scenario.

This would be the simplest. What the hardware could do though is
populating ESR with the right information to avoid decoding the
undefined instruction.

If we go this route, I think we should also expose MIDR for some
micro-architecture optimisations (with the risk that people use it
incorrectly).

> > Another class are dynamic loaders that don't yet have a C library
> > loaded. However, as such loaders are the first entry point, I don't see
> > why they couldn't access auxv directly. One particular scenario here is
> > finding out which CPU micro-architecture (implementation) it is so that
> > the dynamic loader could choose a more optimised library. CPUID would
> > help partially here (get the actual MIDR identifying the CPU
> > implementation rather than just features) but not on heterogeneous
> > systems like big.LITTLE. Which means that we would still be better off
> > with some extra features in auxv, maybe even listing the individual MIDR
> > for all the CPUs in the system.
> 
> The only way I can see hwcap working is if we follow what the architecture
> allows for in ARMv8, which is 4 bits per feature over (currently) around
> 10 32-bit registers. That would mean potentially exposing 1280 hwcaps,
> which is clearly insane.

We have a similar set of registers on ARMv7. But I disagree with the
simplistic calculation that we need 1280 hwcaps. As I replied to
Stephen, many of these are not relevant to user space, other fields are
still reserved and they may never be populated.

Some values we don't even need to bother with, for example on ARMv7
ID_ISAR2[15:12] specify a MLA instruction that has been around since
ARMv4. The way these are structured, ARM assumes an incremental change
to such fields. In the ID_ISAR2[15:12] example, when the field is 1 it
means that MLA is present, when it is 2, it means whatever 1 supported
plus MLS (that's ARMv7 and ARMv6T2). So in this case we only need
HWCAP_MLS as MLA has been there already. Basically we don't need to
encode all the possible states in HWCAP.

> Instead, we currently advertise a tiny subset of the information exposing
> in the ID registers and end up grouping it together in an ad-hoc way without
> any buy-in from the instruction set architects. For example, how the
> `asimd' hwcap on the arm64 kernel corresponds to feature bits in the MVFR
> registers is not at all clear, especially as those hardware registers are
> extended over time.

Minor correction here, there is no MVFR on AArch64. Strangely, the
architects have a field for asimd which means not present when 0 and
present when ffff. It looks like they don't expect to add any values in
here. Crypto instructions which use the same register bank as ASIMD and
are listed in the ID_AA64ISAR registers with the possibility of
extending them (actually the AES fields got PMULL as well and we added a
HWCAP for it).

> We've done a bit better with the crypto extensions, where we provide
> fine-grained sha1, sha2 etc hwcaps, but this is based on the relavant 4-bit
> fields in ISAR5 being positive values. I can't find any architectural
> guarantees that this will work on future cores (e.g. bumping the 4-bit
> field to indicate a subset of previous functionality).

There are no guarantees that they are present (either not built in,
export regulations etc.), that's the aim of CPUID. The problem is when
something not covered by CPUID or covered by it but not by HWCAP gets
removed.

Another example is SWP. It has been included in ARMv7 CPUID as field
ID_ISAR0[3:0] == 1 but allowing implementations to drop this field to 0
(well, we even had HWCAP_SWP but people took its presence for granted,
which is fair since there was no other way to do atomic operations).

> My position is that hwcap is trying to group fine-grained architectural
> features into higher level Linux features, but that's likely to lead to
> an unmaintainable mess as the feature diversity of real systems continues
> to grow. We can fix this easily by exposing the features to userspace in
> the form that is described by the architecture (probably with a single
> HWCAP to say that such an access won't result in SIGILL).

I think there is still value to HWCAP like we do for crypto. We could
add access to CPUID but definitely not a replacement for HWCAP.

What we need from the architects:

1. Clear statement for an architecture version of what's the minimum
   CPUID required
2. Guarantees that a new architecture would not change such minimum to
   smaller values

-- 
Catalin

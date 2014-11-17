From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 16:19:42 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117154739.GT4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
 <20141117152624.GF20652@localhost>
 <20141117154739.GT4042@n2100.arm.linux.org.uk>
Message-ID: <20141117161941.GG29595@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 03:47:39PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 17, 2014 at 03:26:25PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 17, 2014 at 02:39:05PM +0000, Russell King - ARM Linux wrote:
> > > Given that even cocked these up (just as what happened with the cache
> > > type register) decoding of the feature type registers depends on the
> > > underlying CPU architecture.
> > > 
> > > So, even _if_ we exported the feature registers to userspace, you still
> > > need to know the CPU architecture to decode them properly, so you still
> > > need to parse the AT_PLATFORM string to get that information.
> > 
> > >From ARMv7 and many recent ARMv6, you can rely on the MIDR to tell you
> > whether you have the extended CPUID or not. Prior to that, MIDR contains
> > the architecture number.
> 
> That is not what I'm referring to.  Where the feature registers are
> implemented, there are at least two different interpretations of these
> feature registers.  They do not comprise of a single coherent set of
> definitions - the meaning of some nibbles were changed between different
> architectures.

They were indeed messy on ARMv6 and earlier but I think they stabilised
enough for ARMv7.

> > So what would you like to set it to? "v7l"? Even for pre-ARMv8 CPUs,
> > such value doesn't give enough information and user space should rely on
> > hwcap (yes, we missed a HWCAP_DMB because we relied on kuser helpers;
> > another big thing we missed is Thumb-2 in hwcap).
> 
> Shall we look at the entire code fragment again, and this time use our
> heads to *think* about it first?
> 
>         const char *ptr;
>         int architecture;
> 
>         ptr = (const char *)(uintptr_t)getauxval(AT_PLATFORM);
>         assert(ptr);
> 
>         if (!strncmp(ptr, "aarch64", 7))
>                 architecture = 8;
>         else
>                 assert(sscanf(ptr, "v%d", &architecture) == 1);
> 
>         switch (architecture) {
>         case 4:
>         case 5:
>                 no_mcr_dmb;
>                 break;
>         case 6:
>                 use_mcr;
>                 break;
>         default:
>                 use_dmb;
>                 break;
>         }
> 
> Now, if 32-bit ARMv8 returns "v8l" from the AT_PLATFORM auxval, then
> it is not equal to "aarch64".  So, we fall through th sscanf().  sscanf()
> parses the "v8l" string, and sets "architecture" to 8.

I agree, but is there a reason to still check for "aarch64" AT_PLATFORM?

> We now enter the switch() statement.  8 isn't 4.  8 also isn't 5.  Nor is
> it 6.  So, we fall through to the "default" section, which uses "use_dmb".

This indeed works and it is likely the way you designed it with the
_arm32_ kernel in mind (but not before accusing the arm64 maintainers of
making a bad decision with the "aarch64" AT_PLATFORM string for compat
apps ;)).

In your code sequence, the "aarch64" check should be removed, unless you
aim it at portable code between 32 and 64-bit but I would rather use an
#ifdef __aarch64__ in such case. On AArch64 (nothing to do with ARMv8,
v9 etc.), we should move away from thinking in terms of architecture
version numbers but just features.

Similarly for AArch32, I think we should switch our focus from version
numbers (well, only from v7/v8) to features (exposed by the hardware to
the kernel via CPUID). An example is how we got LPAE on ARMv7 without a
change in the architecture version number. We even expose this to user
space via hwcap because that's how we know we have atomic LDRD/STRD.

-- 
Catalin

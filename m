From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 15:26:25 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141117143905.GQ4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
 <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
 <20141117143905.GQ4042@n2100.arm.linux.org.uk>
Message-ID: <20141117152624.GF20652@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 02:39:05PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 17, 2014 at 01:54:13PM +0000, Catalin Marinas wrote:
> > On Sun, Nov 16, 2014 at 05:10:55PM +0000, Russell King - ARM Linux wrote:
> > > which means that rather than encoding the
> > > CPU architecture (like with every other Linux architecture), we have a
> > > string which encodes the kernel architecture instead, which is absurd.
> > 
> > Just like x86_64 vs i686?
> 
> That is still valid, but let's wait and see what happens when a new
> "version" of x86_64 comes along.

I'm not familiar enough with x86 but are there any differences between
AMD's and Intel's implementations? Or are they completely binary
compatible (no extensions)? The differences are probably covered by
hwcap.

> However, the issue on x86 is far less of a problem: userspace (even
> kernel space) does not have to play these games because the CPUs aren't
> designed by people intent on removing old instructions from the
> instruction set, thereby stopping existing binaries working without
> kernel emulation of the missing instructions.

That's what ARM hopes with AArch64. Whether this will still be valid
many years in the future, I can't tell (but a lesson learnt by the
architecture folk is that it's impossible to get rid of old instructions
in user space). There are, of course, optional features like crypto but
we use hwcap for them.

> > > Obviously, the plan for ARM64 is that there will never be an ARMv9
> > > architecture, and ARMv8 is the perfect architecture for the future. :p
> > 
> > If you haven't noticed, the distinction between ARMv6 and ARMv7 has been
> > blurred enough (guess why cpu_architecture() reports ARMv7 for
> > ARM11MPCore). ARM is trying to move away from architecture version
> > numbers, which are rather useful for marketing, to proper feature
> > detection based on CPUID. Whether there is an ARMv9 or not, it's
> > irrelevant to what Linux should do (i.e. use CPUID rather than guess
> > features based on architecture version numbers).
> 
> That may be what is desired, but unfortunately we have no way to export
> all the intricate feature registers to userspace.  No, elf hwcaps don't
> support it, there's only 64 bits split between two words there, and
> there are many more than just 64 bits of feature registers.

As I replied to Szabolcs, maybe we need a way to export more of the
CPUID space to user (like trapping such mrc's and returning something
that the kernel has enabled). I have a similar request from the AArch64
tools people.

> Given that even cocked these up (just as what happened with the cache
> type register) decoding of the feature type registers depends on the
> underlying CPU architecture.
> 
> So, even _if_ we exported the feature registers to userspace, you still
> need to know the CPU architecture to decode them properly, so you still
> need to parse the AT_PLATFORM string to get that information.

>From ARMv7 and many recent ARMv6, you can rely on the MIDR to tell you
whether you have the extended CPUID or not. Prior to that, MIDR contains
the architecture number.

> > > So, a reasonable parsing of this would be:
> > > 
> > > 	const char *ptr;
> > > 	int architecture;
> > > 
> > > 	ptr = (const char *)(uintptr_t)getauxval(AT_PLATFORM);
> > > 	assert(ptr);
> > > 
> > > 	if (!strncmp(ptr, "aarch64", 7))
> > > 		architecture = 8;
> > > 	else
> > > 		assert(sscanf(ptr, "v%d", &architecture) == 1);
> > 
> > Oh, have you even bothered trying 32-bit (compat) getauxval(AT_PLATFORM)
> > on an aarch64 kernel? It reports "v8l", so please don't confuse others.
> 
> Right, I see that now - I'm not knowledgable of the compat code, because
> ARM32 has nothing to do with it, and I missed COMPAT_ELF_PLATFORM.
> 
> As for "bothered trying" - tell me how I could possibly try that.  You
> know full well that I have /no/ 64-bit hardware, and you also know that
> I have *nothing* capable of running, let alone building a 64-bit ARM
> kernel.

Sorry, I was assuming that you have access to at least an ARM software
model (freely available, AArch64 Qemu is also stable enough). If you
have an interest and need ARMv8 hardware, please let us know.

> Now, think about what /you/ have said.  Think about your assertion about
> that "v8l" string.  How does the code react to that?  Oh my, it sets
> "architecture" to 8 !  Oh lookie, it's the right value.  Oh look, the
> code works correctly.

So what would you like to set it to? "v7l"? Even for pre-ARMv8 CPUs,
such value doesn't give enough information and user space should rely on
hwcap (yes, we missed a HWCAP_DMB because we relied on kuser helpers;
another big thing we missed is Thumb-2 in hwcap).

For ARMv8, we have additional features that I would like to include in
hwcap on arm32 (and we've already done this with crypto; there are
load/store with release/acquire semantics which would allow slightly
faster locking, see kuser helpers provided by the AArch64 kernel to
compat user space).

(I'm ignoring the rest of your email in order to keep the thread
constructive)

-- 
Catalin

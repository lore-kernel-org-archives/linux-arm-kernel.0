From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Dec 2013 11:25:40 +0100
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <20131218100321.GC4360@n2100.arm.linux.org.uk>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 December 2013 11:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 18, 2013 at 10:50:38AM +0100, Ard Biesheuvel wrote:
>> On 17 December 2013 13:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, Dec 16, 2013 at 09:04:34PM +0000, Ard Biesheuvel wrote:
>> >> This series is an expansion of the patch posted by Steve Capper about 6 weeks
>> >> ago that allocates hwcaps bits for CRC and Crypto Extensions instructions so
>> >> userland can discover whether the current CPU has any of those capabilities.
>> >>
>> >> Patch #1 is a cleanup patch for read_cpuid(), which allowed me to skip adding
>> >> yet another #define to asm/cputype.h (for ID_ISAR5_EL1)
>> >>
>> >> Patch #2 is Steve's original patch, but slightly tweaked because hwcaps bit 2
>> >> has been allocated for something else in the mean time.
>> >>
>> >> Patch #3 allocates the capability bits in the arch/arm tree. This is necessary
>> >> because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
>> >> so there should be agreement about the meaning of feature bits, even if those
>> >> features don't actually exist on systems covered by the arch/arm tree.
>> >>
>> >> @Russell: if this looks ok to you, could you please indicate whether you prefer
>> >> to take this patch separately, or ack it and let it be merged as part of the
>> >> series.
>> >>
>> >> Patch #4 advertises the CRC and Crypto Extensions to 32-bit binaries running
>> >> under an arm64 kernel.
>> >
>> > The series look fine to me. I'm happy to take all the patches if Russell
>> > Acks the arm one (or it can send it via the patch system).
>> >
>>
>> Hello Russell,
>>
>> Care to share your take on this? I imagine new hwcaps bits take a
>> while to percolate and make their way into a stable glibc, so I would
>> like to have these changes in sooner rather than later, and 3.14 seems
>> feasible.
>
> I'm not all that happy as it gobbles up a load of bits in the hwcap that
> will never be set for ARM, and we only have 32 of them (limited by the
> size of elf_addr_t).  On ARM64, it's less of a problem because the hwcap
> is 64-bit there.
>

I see. Unfortunately, all these features are really separate, i.e., it
is up to the implementor to decide which arbitrary combination of the
extensions he will implement. We could consider merging some bits,
e.g., HWCAP_SHA iff both SHA1 and SHA2 extensions are available, but
it seems like a bit of a hack,

> If we allocate the ARM64 private never-will-appear-on-ARM hwcaps in bit
> 32 and above, they'll be hidden from 32-bit stuff.  Hopefully, glibc
> doesn't concatenate the HWCAP and HWCAP2 fields though - someone should
> check that.
>
> Since the bits in the ARM64 hwcap are different from the ARM32 hwcap, I
> don't see any point in defining them for ARM32 - userspace needs to make
> the definition conditional anyway, and can't interpret the bits as-is
> because ARM64 already omits many of the ARM32 ones.

Please note that this is about the compat bits, not the ARM64 specific
ones. These correspond 1:1 with the ARM32 ones. The idea is that a
binary built for ARM will have access to the extended instructions
which ARM64 offers to ARM32 binaries running in 32 bit compatibility
mode (such as AES, SHAx etc). The point of allocating them for ARM is
to avoid conflicts, so if there is another way to ensure that
(HWCAP2?), we could consider that as well. [However, I personally feel
that it makes more sense to spill over to HWCAP2 once we really have
run out of bits in HWCAP, not to logically partition the hwcaps space]

Regards,
Ard.

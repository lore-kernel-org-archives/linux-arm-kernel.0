From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Dec 2013 22:57:33 +0100
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <alpine.LFD.2.10.1312181550271.7480@knanqh.ubzr>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
 <20131218112713.GA28112@arm.com>
 <20131218114211.GF4360@n2100.arm.linux.org.uk>
 <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
 <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
 <alpine.LFD.2.10.1312181449580.7480@knanqh.ubzr>
 <CAKv+Gu9jw4RHny3L3L6SWm4anhRguhRe4BkLKAxJeqpPB12igg@mail.gmail.com>
 <alpine.LFD.2.10.1312181550271.7480@knanqh.ubzr>
Message-ID: <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 December 2013 22:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 18 Dec 2013, Ard Biesheuvel wrote:
>> The capabilities in question are:
>> * AES
>> * 64 bit polynomial (carry-less) multiply
>> * SHA1
>> * SHA2
>> * CRC32
>> and it is up to the implementor to choose the combination. To me,
>> there are no obviously more likely combinations, but perhaps others
>> have other ideas?
>
> In any case, I agree with Russell that this looks a bit excessive to
> have a single bit for individual instructions.

They are not in fact individual instructions:
* AES -> aese, aesd, aesmc, aesimc
* SHA1 -> sha1c, sha1m, sha1m, sha1p, sha1su0, sha1su1
* SHA2 -> sha256h, sha256h2, sha256su0, sha256su1
* CRC32 -> crc32, crc32c

The only feature that covers a single instruction is poly64 multiply.

> The current hwcaps is
> certainly not suitable for that level of granularity without a way to
> extend it.
>

There is a way to extend it. It is called HWCAP2, and it is already in
use by powerpc.

> What does the ARM ARM say about those instructions?  Are they
> individually optional?
>

Yes, the features (mostly) are. The register is called ID_ISAR5: the
way the bits map to the features is a bit odd, though. AES, SHA1, SHA2
and CRC can be enabled independently, only (oddly) poly64 multiply
implies AES support as well.

>> The nice thing about hwcaps is that it is already integrated into the
>> ifunc resolution done by the loader, which makes it very easy and
>> straightforward to offer alternative implementations of library
>> functions based on CPU capabilities.
>
> The library may as well implement its own ifunc that tests the
> instruction while trapping SIGILL.  On those systems with the supported
> instruction there will be no trap.  On those that traps then the
> alternative implementation is going to be much slower anyway.
>

True. And the trap still only occurs at load time. But I think we
agree it is essentially a poor man's hwcaps.

>> As any kind of emulation in the kernel is likely to be slower than an
>> optimized implementation for a CPU without the feature in question,
>> trapping SIGILL to infer hwcaps is probably the only viable alternate
>> approach that does not require a new kernel interface.
>
> True.  However the kernel side infrastructure to emulate any instruction
> is already there.  So this is just a matter of adding an additional
> entry making the call to the existing libs.  At least that would make
> things work in case the user space libs, or some inline assembly in
> application code, is not expecting the lack of hardware support.
>

I agree that this is all feasible. But I still feel that the best
solution is to allocate 5 bits in HWCAP, that leaves us with 5 spares
now and another 32 when we (trivially) enable HWCAP2 for ARM.

Regards,
Ard.

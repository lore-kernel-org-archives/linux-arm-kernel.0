From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Dec 2013 18:33:45 +0100
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <20131219084816.7247b1c7@i7>
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
 <CAKv+Gu-1=7ZU+C3NL2_C0BBFkAcOhyZn8UvPtXHUtvwW6PKNYw@mail.gmail.com>
 <20131219084816.7247b1c7@i7>
Message-ID: <CAKv+Gu_gv1YAM3Fv1StAWvd4Ecvi+kqpcRiMxURsRsBjhR-Mhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 December 2013 07:48, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Wed, 18 Dec 2013 22:57:33 +0100
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 18 December 2013 22:18, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > On Wed, 18 Dec 2013, Ard Biesheuvel wrote:
>> >> The nice thing about hwcaps is that it is already integrated into the
>> >> ifunc resolution done by the loader, which makes it very easy and
>> >> straightforward to offer alternative implementations of library
>> >> functions based on CPU capabilities.
>> >
>> > The library may as well implement its own ifunc that tests the
>> > instruction while trapping SIGILL.  On those systems with the supported
>> > instruction there will be no trap.  On those that traps then the
>> > alternative implementation is going to be much slower anyway.
>> >
>>
>> True. And the trap still only occurs at load time. But I think we
>> agree it is essentially a poor man's hwcaps.
>
> And the hwcaps is essentially a poor man's replacement for a userspace
> accessible CPUID instruction enjoyed by x86.
>
> It's sad to see that the runtime CPU features detection still remains
> a PITA with AArch64. Basically, it's not enough to know if the
> instruction is supported or not. Different microarchitectures may
> various performance quirks for certain instructions. For example,
> VFPLite in Cortex-A8 is non-pipelined and slow. Cortex-A15 can
> dual-issue NEON instructions (nice for the code which can enjoy
> high ILP), but Cortex-A15 NEON instructions have relatively high
> latency (bad for the code, which is essentially a long dependency
> chain). The fastest way to read uncached memory for most ARM
> processors is to use the VFP load multiple instruction with as
> many registers as possible, but this is slow on Marvell PJ4. And
> so on.
>

You are comparing apples and oranges.

It is fairly well known that you are better off using the NEON for
floating point on a Cortex-A8, if you can afford the reduced
precision. But if you /can't/ afford the reduced precision, you are
still better off using VFP-lite than using software emulation.

The same applies to the Crypto Extensions: it is highly unlikely that
you will care about the particular implementation of the AES
instructions if you are faced with the choice of using those
instructions or using a software implementation. So using hwcaps bits
for these kinds of features makes perfect sense. (And so does enabling
the 'has-vfp' bit for VFP-lite)

I do agree with you that the heterogeneity between various ARM
implementors is a PITA at times, and knowing which CPU exactly you are
running on is a valid question in those cases (btw this applies to SSE
on Atom as well).
But please don't confuse it with the simple presence or absence of
some CPU extension.

Regards,
Ard.

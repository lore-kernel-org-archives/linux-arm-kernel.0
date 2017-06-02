From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 2 Jun 2017 09:55:07 +0000
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <59312080.1090906@arm.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
Message-ID: <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 June 2017 at 08:23, James Morse <james.morse@arm.com> wrote:
> Hi Pratyush,
>
> On 23/05/17 06:02, Pratyush Anand wrote:
>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>> even when we have -O2 optimization enabled. However, if dcache is enabled
>> during purgatory execution then, it takes just a second in SHA
>> verification.
>>
>> Therefore, these patches adds support for dcache enabling facility during
>> purgatory execution.
>
> I'm still not convinced we need this. Moving the SHA verification to happen
> before the dcache+mmu are disabled would also solve the delay problem, and we
> can print an error message or fail the syscall.
>
> For kexec we don't expect memory corruption, what are we testing for?

This is a very good question. SHA-256 is quite a heavy hammer if all
you need is CRC style error detection. Note that SHA-256 uses 256
bytes of round keys, which means that in the absence of a cache, each
64 byte chunk of data processed involves (re)reading 320 bytes from
DRAM. That also means you could write a SHA-256 implementation for
AArch64 that keeps the round keys in NEON registers instead, and it
would probably be a lot faster.

> I can see the use for kdump, but the kdump-kernel is unmapped so the kernel
> can't accidentally write over it.
>
> (we discussed all this last time, but it fizzled-out. If you and the
>  kexec-tools maintainer think its necessary, fine by me!)
>

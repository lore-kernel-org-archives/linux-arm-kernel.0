From: bhupesh.linux@gmail.com (Bhupesh SHARMA)
Date: Fri, 2 Jun 2017 16:45:23 +0530
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
 <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
Message-ID: <CAFTCetS17w0-BJJzTfi8uNS67xos4MwJz3R=qdz2Oe7+fcXk3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard, James

On Fri, Jun 2, 2017 at 3:25 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 2 June 2017 at 08:23, James Morse <james.morse@arm.com> wrote:
>> Hi Pratyush,
>>
>> On 23/05/17 06:02, Pratyush Anand wrote:
>>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
>>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>>> even when we have -O2 optimization enabled. However, if dcache is enabled
>>> during purgatory execution then, it takes just a second in SHA
>>> verification.
>>>
>>> Therefore, these patches adds support for dcache enabling facility during
>>> purgatory execution.
>>
>> I'm still not convinced we need this. Moving the SHA verification to happen
>> before the dcache+mmu are disabled would also solve the delay problem, and we
>> can print an error message or fail the syscall.
>>
>> For kexec we don't expect memory corruption, what are we testing for?
>
> This is a very good question. SHA-256 is quite a heavy hammer if all
> you need is CRC style error detection. Note that SHA-256 uses 256
> bytes of round keys, which means that in the absence of a cache, each
> 64 byte chunk of data processed involves (re)reading 320 bytes from
> DRAM. That also means you could write a SHA-256 implementation for
> AArch64 that keeps the round keys in NEON registers instead, and it
> would probably be a lot faster.

AFAICR the sha-256 implementation was proposed to boot a signed
kexec/kdump kernel to circumvent kexec from violating UEFI secure boot
restrictions (see [1]).

As Matthew Garret rightly noted (see[2]), secure Boot, if enabled, is
explicitly designed to stop you booting modified kernels unless you've
added your own keys.

But if you boot a signed Linux distribution with kexec enabled without
using the SHA like feature in the purgatory (like, say, Ubuntu) then
you're able to boot a modified Windows kernel that will still believe
it was booted securely.

So, CRC wouldn't possibly fulfil the functionality we are trying to
achieve with SHA-256 in the purgatory.

However, having seen the power of using the inbuilt CRC instructions
from the ARM64 ISA on a SoC which supports it, I can vouch that the
native ISA implementations are much faster than other approaches.

However, using the SHA-256 implementation (as you rightly noted) would
employ NEON registers and can be faster, however I remember some SoC
vendors disabling co-processor extensions in their ARM implementations
in the past, so I am not sure we can assume that NEON extensions would
be available in all ARMv8 implementations by default.

[1] https://lwn.net/Articles/603116/
[2] http://mjg59.dreamwidth.org/28746.html

Regards,
Bhupesh

>> I can see the use for kdump, but the kdump-kernel is unmapped so the kernel
>> can't accidentally write over it.
>>
>> (we discussed all this last time, but it fizzled-out. If you and the
>>  kexec-tools maintainer think its necessary, fine by me!)
>>
>
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

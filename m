From: james.morse@arm.com (James Morse)
Date: Fri, 02 Jun 2017 17:36:08 +0100
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <CAFTCetS17w0-BJJzTfi8uNS67xos4MwJz3R=qdz2Oe7+fcXk3g@mail.gmail.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
 <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
 <CAFTCetS17w0-BJJzTfi8uNS67xos4MwJz3R=qdz2Oe7+fcXk3g@mail.gmail.com>
Message-ID: <593193F8.1080509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

On 02/06/17 12:15, Bhupesh SHARMA wrote:
> On Fri, Jun 2, 2017 at 3:25 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 2 June 2017 at 08:23, James Morse <james.morse@arm.com> wrote:
>>> On 23/05/17 06:02, Pratyush Anand wrote:
>>>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
>>>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>>>> even when we have -O2 optimization enabled. However, if dcache is enabled
>>>> during purgatory execution then, it takes just a second in SHA
>>>> verification.
>>>>
>>>> Therefore, these patches adds support for dcache enabling facility during
>>>> purgatory execution.
>>>
>>> I'm still not convinced we need this. Moving the SHA verification to happen
>>> before the dcache+mmu are disabled would also solve the delay problem, and we
>>> can print an error message or fail the syscall.
>>>
>>> For kexec we don't expect memory corruption, what are we testing for?
>>
>> This is a very good question. SHA-256 is quite a heavy hammer if all
>> you need is CRC style error detection.

Thanks for the history links.

We don't (yet) support KEXEC_FILE or KEXEC_VERIFY_SIG, and arm64 doesn't have an
in-kernel purgatory (which looks to be required for kexec_file under secure-boot).


> AFAICR the sha-256 implementation was proposed to boot a signed
> kexec/kdump kernel to circumvent kexec from violating UEFI secure boot
> restrictions (see [1]).

The beginning of the kexec-tools git history is 'kexec-tools-1.101' in 2006, it
had util_lib/sha256.c. It looks like SecureBoot arrived in 2011 with v2.3.1 of UEFI.
I can see how x86 picked up on this checksum for secure-boot as kexec-tools
already did this work, (some of the files under arch/x86/purgatory note their
kexec-tools origin), my question is why did it do it in the first place?
If the reason is accidental writes, we mitigate this on arm64 by unmapping the
kdump region instead of just marking it read-only.


> As Matthew Garret rightly noted (see[2]), secure Boot, if enabled, is
> explicitly designed to stop you booting modified kernels unless you've
> added your own keys.

> So, CRC wouldn't possibly fulfil the functionality we are trying to
> achieve with SHA-256 in the purgatory.

Is this still true for a purgatory provided by user-space?


Thanks,

James

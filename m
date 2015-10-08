From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 8 Oct 2015 13:36:09 +0300
Subject: [PATCH v6 0/6] KASAN for arm64
In-Reply-To: <20151007100411.GG3069@e104818-lin.cambridge.arm.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151007100411.GG3069@e104818-lin.cambridge.arm.com>
Message-ID: <CAPAsAGxR-yqtmFeo65Xw_0RQyEy=mN1uG=GKtqoMLr_x_N0u5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-07 13:04 GMT+03:00 Catalin Marinas <catalin.marinas@arm.com>:
> On Thu, Sep 17, 2015 at 12:38:06PM +0300, Andrey Ryabinin wrote:
>> As usual patches available in git
>>       git://github.com/aryabinin/linux.git kasan/arm64v6
>>
>> Changes since v5:
>>  - Rebase on top of 4.3-rc1
>>  - Fixed EFI boot.
>>  - Updated Doc/features/KASAN.
>
> I tried to merge these patches (apart from the x86 one which is already
> merged) but it still doesn't boot on Juno as an EFI application.
>

4.3-rc1 was ok and 4.3-rc4 is not. Break caused by 0ce3cc008ec04
("arm64/efi: Fix boot crash by not padding between EFI_MEMORY_RUNTIME
regions")
It introduced sort() call in efi_get_virtmap().
sort() is generic kernel function and it's instrumented, so we crash
when KASAN tries to access shadow in sort().

[+CC efi some guys]

Comment in drivers/firmware/efi/libstub/Makefile says that EFI stub
executes with MMU disabled:
    # The stub may be linked into the kernel proper or into a separate
boot binary,
    # but in either case, it executes before the kernel does (with MMU
disabled) so
    # things like ftrace and stack-protector are likely to cause trouble if left
    # enabled, even if doing so doesn't break the build.

But in arch/arm64/kernel/efi-entry.S:
* We arrive here from the EFI boot manager with:
*
*    * CPU in little-endian mode
*    * MMU on with identity-mapped RAM

So is MMU enabled in ARM64 efi-stub?
If yes, we could solve this issue by mapping KASAN early shadow in efi stub.

> --
> Catalin

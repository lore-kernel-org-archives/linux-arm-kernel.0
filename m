From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 1 Feb 2017 13:41:11 +0000
Subject: [PATCH] efi: fdt: avoid FDT manipulation after ExitBootServices()
In-Reply-To: <CAF7UmSyYvmo8k910mJEAYhaOJy9j_bpXw6f+Cj=cS_m_iYiCCQ@mail.gmail.com>
References: <1485954693-25750-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAF7UmSyYvmo8k910mJEAYhaOJy9j_bpXw6f+Cj=cS_m_iYiCCQ@mail.gmail.com>
Message-ID: <CAKv+Gu8gUqqczZiZTaoPFn_1Fb2GsjoXK+yzQdxwtyjfR_LGnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2017 at 13:39, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On 1 February 2017 at 13:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Some AArch64 UEFI implementations disable the MMU in ExitBootServices(),
>> after which unaligned accesses to RAM are no longer supported.
>>
>> Commit abfb7b686a3e ("efi/libstub/arm*: Pass latest memory map to the
>> kernel") fixed an issue in the memory map handling of the stub FDT code,
>> but inadvertently created an issue with such firmwares, by moving some
>> of the FDT manipulation to after the invocation of ExitBootServices().
>> However, the stub's libfdt implementation uses the ordinary, accelerated
>> string functions, which rely on hardware handling of unaligned accesses,
>> resulting in alignment faults when executed with the MMU off.
>>
>> Whether disabling the MMU in ExitBootServices() complies with the UEFI
>> spec is unclear, but it is a reality we have to deal with, given that
>> it wasn't a problem before commit abfb7b686a3e was applied.
>
> I'm not sure it's unclear, but someone not reading the specification
> and instead looking
> at what the unfortunate LinuxLoader did might incorrectly deduce that
> such is the case.
>
>> So fix the situation by moving the update_fdt_memmap() into the callback
>> invoked by efi_exit_boot_services() right before it hits the button.
>>
>> Fixes: abfb7b686a3e ("efi/libstub/arm*: Pass latest memory map to the kernel")
>
> I would sort argue against the Fixes: tag, given that I don't consider
> that code to be
> incorrect.
>

Well, that patch ended up in -stable, and is breaking actual systems
that worked 'fine' before.

> I agree that this is a good change regardless.
>

Cheers.

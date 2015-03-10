From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 11:51:03 +0100
Subject: [PATCH 0/5] arm64: update/clarify/relax Image and FDT placement
 rules
In-Reply-To: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8Ghwr5DRjehr780=8NUpnCYciZSMNxUzFdo1VoOy1Dng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2015 at 12:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This series came about after Mark Rutland brought up the fact that the current
> FDT placement logic used by the EFI stub is flawed. But actually, it turned out
> that the documentation for both the Image and FDT placement was incorrect as
> well, or confusing at the very least.
>
> So this series does two things:
> - It relaxes the FDT placement requirements, and updates the documentation and
>   EFI stub FDT placement logic accordingly.
> - It clarifies the Image placement requirements in the documentation, and brings
>   the EFI stub Image placement logic in line with it
>

Anyone care to comment on these patches?

Patch #4 is arguably a bug fix, although it is unlikely that the base
of visible (to EL2) DRAM would be so close to a 512 MB boundary that
the Image would end up astride it.

However, the FDT placement issue is more likely to cause trouble: if
EL3 takes a couple of megs from the bottom of DRAM to give to the
secure world (in which case it is perfectly legal for it not to turn
up in the UEFI memory map at all), the current FDT placement logic
will prefer an offset which sits in the next 512 MB block, putting the
FDT out of reach for the initial page tables.

If we prefer not to use the fixmap region for the FDT,  the latter
issue should be addressed in a different way.

Regards,
Ard.

> Ard Biesheuvel (5):
>   of/fdt: allow FDT virtual address outside of linear direct mapping
>   arm64: use fixmap region for permanent FDT mapping
>   arm64: Documentation: clarify Image placement in physical RAM
>   arm64/efi: ensure that Image does not cross a 512 MB boundary
>   arm64/efi: adapt to relaxed FDT placement requirements
>
>  Documentation/arm64/booting.txt         | 12 +++----
>  arch/arm64/include/asm/efi.h            |  9 +++--
>  arch/arm64/include/asm/fixmap.h         |  9 +++++
>  arch/arm64/kernel/Makefile              |  1 +
>  arch/arm64/kernel/efi-stub.c            | 38 ++++++++++++++++----
>  arch/arm64/kernel/head.S                | 38 +-------------------
>  arch/arm64/kernel/setup.c               | 62 +++++++++++++++++++++++++++++----
>  drivers/firmware/efi/libstub/arm-stub.c |  2 +-
>  drivers/firmware/efi/libstub/fdt.c      |  7 ++--
>  drivers/of/fdt.c                        | 14 +++++++-
>  10 files changed, 125 insertions(+), 67 deletions(-)
>
> --
> 1.8.3.2
>

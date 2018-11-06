From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Nov 2018 18:27:23 +0000
Subject: [PATCH 0/4] arm/efi: fix memblock reallocation crash due to
 persistent reservations
In-Reply-To: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
References: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
Message-ID: <326d242e-e51b-c11f-8364-390d991488a6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 06/11/18 11:37, Ard Biesheuvel wrote:
> This series addresses the kexec/kdump crash on arm64 system with many CPUs
> that was reported by Bhupesh.
> 
> Patches #1 and #2 fix the actual crash. Patches #3 and #4 optimize the
> EFI persistent memreserve infrastructure so that fewer memblock reservations
> are required.
> 
> Ard Biesheuvel (4):
>   arm64: memblock: don't permit memblock resizing until linear mapping
>     is up
>   efi/arm: defer persistent reservations until after paging_init()
>   efi: permit multiple entries in persistent memreserve data structure
>   efi: reduce the amount of memblock reservations for persistent
>     allocations
> 
>  arch/arm/kernel/setup.c                 |  1 +
>  arch/arm64/kernel/setup.c               |  1 +
>  arch/arm64/mm/init.c                    |  2 -
>  arch/arm64/mm/mmu.c                     |  2 +
>  drivers/firmware/efi/efi.c              | 59 ++++++++++++++------
>  drivers/firmware/efi/libstub/arm-stub.c |  2 +-
>  include/linux/efi.h                     | 23 +++++++-
>  7 files changed, 68 insertions(+), 22 deletions(-)

I've just given these patches a go a a TX2 box (one of the 224 CPU
ones...), and kexec worked just fine (v4.20-rc1 vanilla didn't manage to
kexec on this box).

There seem to be some additional userspace patches that are required for
the ACPI tables not to be corrupted in the secondary kernel, but that's
an orthogonal issue.

Feel free to add

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

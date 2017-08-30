From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 30 Aug 2017 12:20:40 -0700
Subject: [PATCH] nd_blk: Remove mmio_flush_range()
In-Reply-To: <a8de5c42cbfcd467586d3f93adbbee877050b6b9.1504113975.git.robin.murphy@arm.com>
References: <a8de5c42cbfcd467586d3f93adbbee877050b6b9.1504113975.git.robin.murphy@arm.com>
Message-ID: <CAPcyv4hQbo+aGHYN8oDg8khsPPN8ao-fCYTjUvTtOxjSqthcxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 11:19 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> mmio_flush_range() suffers from a lack of clearly-defined semantics,
> and is somewhat ambiguous to port to other architectures where the
> scope of the writeback implied by "flush" and ordering might matter,
> but MMIO would tend to imply non-cacheable anyway. Per the rationale
> in 67a3e8fe9015 ("nd_blk: change aperture mapping from WC to WB"), the
> only existing use is actually to invalidate clean cache lines for
> ARCH_MEMREMAP_PMEM type mappings *without* writeback. Since the recent
> cleanup of the pmem API, that also now happens to be the exact purpose
> of arch_invalidate_pmem(), which would be a far more well-defined tool
> for the job.
>
> Rather than risk potentially inconsistent implementations of
> mmio_flush_range() for the sake of one callsite, streamline things by
> removing it entirely and instead move the ARCH_MEMREMAP_PMEM related
> definitions up to the libnvdimm level, so they can be shared by NFIT
> as well. This allows NFIT to be enabled for arm64.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/x86/Kconfig                  |  1 -
>  arch/x86/include/asm/cacheflush.h |  2 --
>  drivers/acpi/nfit/Kconfig         |  1 -
>  drivers/acpi/nfit/core.c          |  2 +-
>  drivers/nvdimm/pmem.h             | 14 --------------
>  include/linux/libnvdimm.h         | 15 +++++++++++++++
>  lib/Kconfig                       |  3 ---
>  tools/testing/nvdimm/test/nfit.c  |  4 ++--
>  8 files changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 781521b7cf9e..5f3b756ec0d3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -53,7 +53,6 @@ config X86
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_KCOV                    if X86_64
> -       select ARCH_HAS_MMIO_FLUSH
>         select ARCH_HAS_PMEM_API                if X86_64
>         select ARCH_HAS_UACCESS_FLUSHCACHE      if X86_64
>         select ARCH_HAS_SET_MEMORY
> diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
> index 8b4140f6724f..cb9a1af109b4 100644
> --- a/arch/x86/include/asm/cacheflush.h
> +++ b/arch/x86/include/asm/cacheflush.h
> @@ -7,6 +7,4 @@
>
>  void clflush_cache_range(void *addr, unsigned int size);
>
> -#define mmio_flush_range(addr, size) clflush_cache_range(addr, size)
> -
>  #endif /* _ASM_X86_CACHEFLUSH_H */
> diff --git a/drivers/acpi/nfit/Kconfig b/drivers/acpi/nfit/Kconfig
> index 6d3351452ea2..97117ba582f3 100644
> --- a/drivers/acpi/nfit/Kconfig
> +++ b/drivers/acpi/nfit/Kconfig
> @@ -2,7 +2,6 @@ config ACPI_NFIT
>         tristate "ACPI NVDIMM Firmware Interface Table (NFIT)"
>         depends on PHYS_ADDR_T_64BIT
>         depends on BLK_DEV
> -       depends on ARCH_HAS_MMIO_FLUSH

Lets add depends on ARCH_HAS_PMEM_API here since support for being to
perform the invalidation is critical to the operation of the ND_BLK
driver.

...but this otherwise looks good to me.

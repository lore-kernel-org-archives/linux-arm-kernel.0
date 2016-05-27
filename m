From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:00:53 +0530
Subject: [PATCH kexec-tools 22/32] arm: use generic mem_region sorting
 implementation
In-Reply-To: <E1axXTl-0004j5-II@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTl-0004j5-II@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuowUMo62_AQ2g3FxSW8YZXa4wQgt6oSwJvm_RVtt0+PaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Use the generic mem_region sorting implementation.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 85afd9f..d6db566 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -202,19 +202,6 @@ static void crash_exclude_range(void)
>         }
>  }
>
> -static int range_cmp(const void *a1, const void *a2)
> -{
> -       const struct memory_range *r1 = a1;
> -       const struct memory_range *r2 = a2;
> -
> -       if (r1->start > r2->start)
> -               return 1;
> -       if (r1->start < r2->start)
> -               return -1;
> -
> -       return 0;
> -}
> -
>  /**
>   * crash_get_memory_ranges() - read system physical memory
>   *
> @@ -246,8 +233,7 @@ static int crash_get_memory_ranges(void)
>         /*
>          * Make sure that the memory regions are sorted.
>          */
> -       qsort(usablemem_rgns.ranges, usablemem_rgns.size,
> -             sizeof(*usablemem_rgns.ranges), range_cmp);
> +       mem_regions_sort(&usablemem_rgns);
>
>         return 0;
>  }
> --
> 1.9.1
>

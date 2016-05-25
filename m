From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 13:30:27 +0530
Subject: [PATCH kexec-tools 11/32] kexec: add mem_regions sorting
 implementation
In-Reply-To: <E1axXSq-0004hx-8H@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSq-0004hx-8H@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Gur=Lf7-wX+=ddfEwXrC7U0mduSGTbV2hPp4HSG7nx-8yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add a mem_regions sorting implementation taken from the arm code.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/mem_regions.c | 27 +++++++++++++++++++++++++++
>  kexec/mem_regions.h |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index a4952ff..804984a 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -1,6 +1,33 @@
> +#include <stdlib.h>
> +
>  #include "kexec.h"
>  #include "mem_regions.h"
>
> +static int mem_range_cmp(const void *a1, const void *a2)
> +{
> +       const struct memory_range *r1 = a1;
> +       const struct memory_range *r2 = a2;
> +
> +       if (r1->start > r2->start)
> +               return 1;
> +       if (r1->start < r2->start)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +/**
> + * mem_regions_sort() - sort ranges into ascending address order
> + * @ranges: ranges to sort
> + *
> + * Sort the memory regions into ascending address order.
> + */
> +void mem_regions_sort(struct memory_ranges *ranges)
> +{
> +       qsort(ranges->ranges, ranges->size, sizeof(ranges->ranges),
> +             mem_range_cmp);
> +}
> +
>  /**
>   * mem_regions_add() - add a memory region to a set of ranges
>   * @ranges: ranges to add the memory region to
> diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
> index b9cfba1..da7b5e8 100644
> --- a/kexec/mem_regions.h
> +++ b/kexec/mem_regions.h
> @@ -3,6 +3,8 @@
>
>  struct memory_ranges;
>
> +void mem_regions_sort(struct memory_ranges *ranges);
> +
>  int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
>                      unsigned long long length, int type);
>
> --
> 1.9.1
>

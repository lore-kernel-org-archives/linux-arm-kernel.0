From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 13:30:12 +0530
Subject: [PATCH kexec-tools 10/32] kexec: add generic helper to add to
 memory_regions
In-Reply-To: <E1axXSl-0004hr-0T@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSl-0004hr-0T@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuohKypNtesrjfT3H=U74_X4gudqS5jw+Tu1u1BsO_QF_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add a helper to add a memory range to a memory_regions array.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/Makefile      |  4 ++++
>  kexec/mem_regions.c | 30 ++++++++++++++++++++++++++++++
>  kexec/mem_regions.h |  9 +++++++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 kexec/mem_regions.c
>  create mode 100644 kexec/mem_regions.h
>
> diff --git a/kexec/Makefile b/kexec/Makefile
> index a758b4a..e2aee84 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -69,6 +69,10 @@ dist                         += kexec/fs2dt.c kexec/fs2dt.h
>  $(ARCH)_FS2DT                  =
>  KEXEC_SRCS                     += $($(ARCH)_FS2DT)
>
> +dist                           += kexec/mem_regions.c kexec/mem_regions.h
> +$(ARCH)_MEM_REGIONS            =
> +KEXEC_SRCS                     += $($(ARCH)_MEM_REGIONS)
> +
>  include $(srcdir)/kexec/arch/alpha/Makefile
>  include $(srcdir)/kexec/arch/arm/Makefile
>  include $(srcdir)/kexec/arch/i386/Makefile
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> new file mode 100644
> index 0000000..a4952ff
> --- /dev/null
> +++ b/kexec/mem_regions.c
> @@ -0,0 +1,30 @@
> +#include "kexec.h"
> +#include "mem_regions.h"
> +
> +/**
> + * mem_regions_add() - add a memory region to a set of ranges
> + * @ranges: ranges to add the memory region to
> + * @max: maximum number of entries in memory region
> + * @base: base address of memory region
> + * @length: length of memory region in bytes
> + * @type: type of memory region
> + *
> + * Add the memory region to the set of ranges, and return %0 if successful,
> + * or %-1 if we ran out of space.
> + */
> +int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
> +                    unsigned long long length, int type)
> +{
> +       struct memory_range *range;
> +
> +       if (ranges->size >= ranges->max_size)
> +               return -1;
> +
> +       range = ranges->ranges + ranges->size++;
> +       range->start = base;
> +       range->end = base + length - 1;
> +       range->type = type;
> +
> +       return 0;
> +}
> +
> diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
> new file mode 100644
> index 0000000..b9cfba1
> --- /dev/null
> +++ b/kexec/mem_regions.h
> @@ -0,0 +1,9 @@
> +#ifndef MEM_REGIONS_H
> +#define MEM_REGIONS_H
> +
> +struct memory_ranges;
> +
> +int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
> +                    unsigned long long length, int type);
> +
> +#endif
> --
> 1.9.1
>

From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 13:30:44 +0530
Subject: [PATCH kexec-tools 12/32] kexec: add helper to exlude a region
 from a set of memory ranges
In-Reply-To: <E1axXSv-0004i3-Gi@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSv-0004i3-Gi@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Guo_ozXhAnkGk_NrdBME2fSYDoKTHwu3kLBvsrmbwxOdww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Add a helper to exclude a region from a set of memory ranges.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> ---
>  kexec/mem_regions.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  kexec/mem_regions.h |  4 ++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index 804984a..c6ba942 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -29,6 +29,61 @@ void mem_regions_sort(struct memory_ranges *ranges)
>  }
>
>  /**
> + * mem_regions_exclude() - excludes a memory region from a set of memory ranges
> + * @ranges: memory ranges to exclude the region from
> + * @range: memory range to exclude
> + *
> + * Exclude a memory region from a set of memory ranges.  We assume that
> + * the region to be excluded is either wholely located within one of the
> + * memory ranges, or not at all.
> + */
> +int mem_regions_exclude(struct memory_ranges *ranges,
> +                       const struct memory_range *range)
> +{
> +       int i;
> +
> +       for (i = 0; i < ranges->size; i++) {
> +               struct memory_range *r = ranges->ranges + i;
> +
> +               /*
> +                * We assume that crash area is fully contained in
> +                * some larger memory area.
> +                */
> +               if (r->start <= range->start && r->end >= range->end) {
> +                       if (r->start == range->start) {
> +                               /* Shrink the start of this memory range */
> +                               r->start = range->end + 1;
> +                       } else if (r->end == range->end) {
> +                               /* Shrink the end of this memory range */
> +                               r->end = range->start - 1;

What if r->start == range->start) && (r->end == range->end)?

> +                       } else {
> +                               struct memory_range *new;
> +
> +                               /*
> +                                * Split this area into 2 smaller ones and
> +                                * remove excluded range from between. First
> +                                * create new entry for the remaining area.
> +                                */
> +                               if (ranges->size >= ranges->max_size)
> +                                       return -1;
> +
> +                               new = ranges->ranges + ranges->size++;
> +                               new->start = range->end + 1;
> +                               new->end = r->end;
> +
> +                               /*
> +                                * Update this area to end before excluded
> +                                * range.
> +                                */
> +                               r->end = range->start - 1;
> +                               break;
> +                       }
> +               }
> +       }
> +       return 0;
> +}
> +
> +/**
>   * mem_regions_add() - add a memory region to a set of ranges
>   * @ranges: ranges to add the memory region to
>   * @max: maximum number of entries in memory region
> diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
> index da7b5e8..ae9e972 100644
> --- a/kexec/mem_regions.h
> +++ b/kexec/mem_regions.h
> @@ -2,9 +2,13 @@
>  #define MEM_REGIONS_H
>
>  struct memory_ranges;
> +struct memory_range;
>
>  void mem_regions_sort(struct memory_ranges *ranges);
>
> +int mem_regions_exclude(struct memory_ranges *ranges,
> +                       const struct memory_range *range);
> +
>  int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
>                      unsigned long long length, int type);
>
> --
> 1.9.1
>

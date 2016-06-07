From: panand@redhat.com (Pratyush Anand)
Date: Tue, 7 Jun 2016 10:25:15 +0530
Subject: [PATCH kexec-tools v2 12/32] kexec: add helper to exlude a
 region from a set of memory ranges
In-Reply-To: <E1b9xsO-0003sa-Sr@e0050434b2927.dyn.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
 <E1b9xsO-0003sa-Sr@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160607045515.GA13643@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016:05:59:44 PM, Russell King wrote:
> Add a helper to exclude a region from a set of memory ranges.
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>
> ---
>  kexec/mem_regions.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  kexec/mem_regions.h |  4 +++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index 804984a..b01a5c8 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -55,3 +55,74 @@ int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
>  	return 0;
>  }
>  
> +static void mem_regions_remove(struct memory_ranges *ranges, int index)
> +{
> +	int tail_entries;
> +
> +	/* we are assured to have at least one entry */
> +	ranges->size -= 1;
> +
> +	/* if we have following entries, shuffle them down one place */
> +	tail_entries = ranges->size - index;
> +	if (tail_entries)
> +		memmove(ranges->ranges + index, ranges->ranges + index + 1,
> +			tail_entries * sizeof(*ranges->ranges));
> +
> +	/* zero the new tail entry */
> +	memset(ranges->ranges + ranges->size, 0, sizeof(*ranges->ranges));
> +}
> +
> +/**
> + * mem_regions_exclude() - excludes a memory region from a set of memory ranges
> + * @ranges: memory ranges to exclude the region from
> + * @range: memory range to exclude
> + *
> + * Exclude a memory region from a set of memory ranges.  We assume that
> + * the region to be excluded is either wholely located within one of the
> + * memory ranges, or not at all.
> + */
> +int mem_regions_exclude(struct memory_ranges *ranges,
> +			const struct memory_range *range)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ranges->size; i++) {
> +		struct memory_range *r = ranges->ranges + i;
> +
> +		/*
> +		 * We assume that crash area is fully contained in
> +		 * some larger memory area.
> +		 */
> +		if (r->start <= range->start && r->end >= range->end) {
> +			if (r->start == range->start) {
> +				if (r->end == range->end)
> +					/* Remove this entry */
> +					mem_regions_remove(ranges, i);
> +				else
> +					/* Shrink the start of this memory range */
> +					r->start = range->end + 1;
> +			} else if (r->end == range->end) {
> +				/* Shrink the end of this memory range */
> +				r->end = range->start - 1;
> +			} else {
> +				/*
> +				 * Split this area into 2 smaller ones and
> +				 * remove excluded range from between. First
> +				 * create new entry for the remaining area.
> +				 */
> +				ret = mem_regions_add(ranges, range->end + 1,
> +						      r->end - range->end, 0);
> +				if (ret < 0)
> +					return ret;
> +
> +				/*
> +				 * Update this area to end before excluded
> +				 * range.
> +				 */
> +				r->end = range->start - 1;
> +				break;
> +			}
> +		}
> +	}
> +	return 0;
> +}
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
> +			const struct memory_range *range);
> +
>  int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
>                      unsigned long long length, int type);
>  
> -- 
> 1.9.1

From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Sep 2017 14:00:49 +0100
Subject: [PATCH v1 06/14] tee: optee: add page list manipulation functions
In-Reply-To: <1506621851-6929-7-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-7-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <20170929130049.GD5781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 09:04:03PM +0300, Volodymyr Babchuk wrote:
> +/**
> + * optee_fill_pages_list() - write list of user pages to given shared
> + * buffer.
> + *
> + * @dst: page-aligned buffer where list of pages will be stored
> + * @pages: array of pages that represents shared buffer
> + * @num_pages: number of entries in @pages
> + *
> + * @dst should be big enough to hold list of user page addresses and
> + *	links to the next pages of buffer
> + */
> +void optee_fill_pages_list(u64 *dst, struct page **pages, size_t num_pages)
> +{
> +	size_t i;

Why size_t? It's unusual for an array index.

> +	/* TODO: add support for RichOS page sizes that != 4096 */
> +	BUILD_BUG_ON(PAGE_SIZE != OPTEE_MSG_NONCONTIG_PAGE_SIZE);

This must be fixed before this can be considered for merging.

A large number of people build arm64 kernels with 64K pages, and this
will need to see some testing.

> +	for (i = 0; i < num_pages; i++, dst++) {
> +		/* Check if we are going to roll over the page boundary */
> +		if (IS_ALIGNED((uintptr_t)(dst + 1),
> +			       OPTEE_MSG_NONCONTIG_PAGE_SIZE)) {
> +			*dst = virt_to_phys(dst + 1);
> +			dst++;
> +		}
> +		*dst = page_to_phys(pages[i]);

... so this pagelist management will need to be reworked.

> +	}
> +}
> +
> +static size_t get_pages_array_size(size_t num_entries)
> +{
> +	/* Number of user pages + number of pages to hold list of user pages */
> +	return sizeof(u64) *
> +		(num_entries + (sizeof(u64) * num_entries) /
> +		 OPTEE_MSG_NONCONTIG_PAGE_SIZE);
> +}

I don't think this is correct.

For P 4096-byte pages, we can have 511 * P (8-byte) page entries, and P
(8-byte) next entries.

So if we need to list 1023 page entries, we need 3 (4096-byte) pages.
The first page holds 511 entries, the second holds 511 entries, and the
third holds 1 entry.

However, the above calculates that we need 2 (4096-byte) pages, as it
calculates that in bytes we need:

  8 * (1023 + (8 * 1023) / 4096)
  8 * (1023 + (8184) / 4096)
  8 * (1023 + 1)
  8 * 1024
  8192

... or 2 (4096-byte) pages.


I think it would be clearer to write this over a number of steps, e.g.

/*
 * The final entry in each pagelist page is a pointer to the next
 * pagelist page.
 */
#define PAGELIST_ENTRIES_PER_PAGE \
	((OPTEE_MSG_NONCONTIG_PAGE_SIZE / sizeof(u64)) - 1)

static size_t get_pages_array_size(size_t num_entries)
{
	int pages = DIV_ROUND_UP(num_entries, PAGELIST_ENTRIES_PER_PAGE);

	return pages * OPTEE_MSG_NONCONTIG_PAGE_SIZE;
}

> +
> +u64 *optee_allocate_pages_array(size_t num_entries)
> +{
> +	return alloc_pages_exact(get_pages_array_size(num_entries), GFP_KERNEL);
> +}
> +
> +void optee_free_pages_array(void *array, size_t num_entries)
> +{
> +	free_pages_exact(array, get_pages_array_size(num_entries));
> +}
> +
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index c374cd5..caa3c04 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -165,6 +165,10 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
>  int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
>  		       const struct tee_param *params);
>  
> +u64 *optee_allocate_pages_array(size_t num_entries);
> +void optee_free_pages_array(void *array, size_t num_entries);
> +void optee_fill_pages_list(u64 *dst, struct page **pages, size_t num_pages);

Any reason for the array/list naming disparity? IIUC, these are the same
structure.

Thanks,
Mark.

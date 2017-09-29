From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 29 Sep 2017 03:23:00 +0300
Subject: [PATCH v1 06/14] tee: optee: add page list manipulation functions
In-Reply-To: <1506621851-6929-7-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-7-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <20170929002300.zxu4n47m5jdymdyt@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 09:04:03PM +0300, Volodymyr Babchuk wrote:
> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> 
> These functions will be used to pass information about shared
> buffers to OP-TEE.
> 
> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> ---
>  drivers/tee/optee/call.c          | 48 +++++++++++++++++++++++++++++++++++++++
>  drivers/tee/optee/optee_private.h |  4 ++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index f7b7b40..f8e044d 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -11,6 +11,7 @@
>   * GNU General Public License for more details.
>   *
>   */
> +#include <asm/pgtable.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -442,3 +443,50 @@ void optee_disable_shm_cache(struct optee *optee)
>  	}
>  	optee_cq_wait_final(&optee->call_queue, &w);
>  }
> +
> +/**
> + * optee_fill_pages_list() - write list of user pages to given shared
> + * buffer.
> + *
> + * @dst: page-aligned buffer where list of pages will be stored

I'm not much familiar with the subsystem you work on, but I don't
understand why the type of dst is u64*. If it's just a buffer, it
should be void *. Also, if we assuming running it on arm were pointers
are 32-bit, the result of page_to_phys() will be u32, and you will
waste half of your u64 array for storing zeroes; this line:
		*dst = page_to_phys(pages[i]);

> + * @pages: array of pages that represents shared buffer
> + * @num_pages: number of entries in @pages
> + *
> + * @dst should be big enough to hold list of user page addresses and
> + *	links to the next pages of buffer
> + */
> +void optee_fill_pages_list(u64 *dst, struct page **pages, size_t num_pages)
> +{
> +	size_t i;
> +
> +	/* TODO: add support for RichOS page sizes that != 4096 */
> +	BUILD_BUG_ON(PAGE_SIZE != OPTEE_MSG_NONCONTIG_PAGE_SIZE);

RichOS stands for Linux? Why I am still not a rich OS developer? :)
This is the first occurrence of the term in kernel sources, please
explain it.

Also, I think that it would be more logical to add the dependency on
page size to Kconfig, not here, and move the comment there, so user
will be simply unable to build the whole module.

> +	for (i = 0; i < num_pages; i++, dst++) {
> +		/* Check if we are going to roll over the page boundary */
> +		if (IS_ALIGNED((uintptr_t)(dst + 1),
> +			       OPTEE_MSG_NONCONTIG_PAGE_SIZE)) {
> +			*dst = virt_to_phys(dst + 1);
> +			dst++;
> +		}

Is my understanding correct that @dst is not a simple array of buffer
page addresses?  Instead, it has a complex structure: First 511 records
store buffer page entries, and last one points to the next page of dst.
Is it somehow documented? Also, did you consider to create a header structure
for the buffer page, like memory allocators do? You can place there number
of entries, pointer to the next page, maybe some flags. I think it will be
more transparent, especially if we consider communication protocol between
independent software products.

> +		*dst = page_to_phys(pages[i]);
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
> +
>  /*
>   * Small helpers
>   */
> -- 
> 2.7.4

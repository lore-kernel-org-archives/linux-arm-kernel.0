From: jack@suse.cz (Jan Kara)
Date: Mon, 24 Jul 2017 13:35:42 +0200
Subject: [PATCH v4 2/5] dax: relocate some dax functions
In-Reply-To: <20170721223956.29485-3-ross.zwisler@linux.intel.com>
References: <20170721223956.29485-1-ross.zwisler@linux.intel.com>
 <20170721223956.29485-3-ross.zwisler@linux.intel.com>
Message-ID: <20170724113542.GJ652@quack2.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 21-07-17 16:39:52, Ross Zwisler wrote:
> dax_load_hole() will soon need to call dax_insert_mapping_entry(), so it
> needs to be moved lower in dax.c so the definition exists.
> 
> dax_wake_mapping_entry_waiter() will soon be removed from dax.h and be made
> static to dax.c, so we need to move its definition above all its callers.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/dax.c | 138 +++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index c844a51..779dc5e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -121,6 +121,31 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait, unsigned int mo
>  }
>  
>  /*
> + * We do not necessarily hold the mapping->tree_lock when we call this
> + * function so it is possible that 'entry' is no longer a valid item in the
> + * radix tree.  This is okay because all we really need to do is to find the
> + * correct waitqueue where tasks might be waiting for that old 'entry' and
> + * wake them.
> + */
> +void dax_wake_mapping_entry_waiter(struct address_space *mapping,
> +		pgoff_t index, void *entry, bool wake_all)
> +{
> +	struct exceptional_entry_key key;
> +	wait_queue_head_t *wq;
> +
> +	wq = dax_entry_waitqueue(mapping, index, entry, &key);
> +
> +	/*
> +	 * Checking for locked entry and prepare_to_wait_exclusive() happens
> +	 * under mapping->tree_lock, ditto for entry handling in our callers.
> +	 * So at this point all tasks that could have seen our entry locked
> +	 * must be in the waitqueue and the following check will see them.
> +	 */
> +	if (waitqueue_active(wq))
> +		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> +}
> +
> +/*
>   * Check whether the given slot is locked. The function must be called with
>   * mapping->tree_lock held
>   */
> @@ -392,31 +417,6 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
>  	return entry;
>  }
>  
> -/*
> - * We do not necessarily hold the mapping->tree_lock when we call this
> - * function so it is possible that 'entry' is no longer a valid item in the
> - * radix tree.  This is okay because all we really need to do is to find the
> - * correct waitqueue where tasks might be waiting for that old 'entry' and
> - * wake them.
> - */
> -void dax_wake_mapping_entry_waiter(struct address_space *mapping,
> -		pgoff_t index, void *entry, bool wake_all)
> -{
> -	struct exceptional_entry_key key;
> -	wait_queue_head_t *wq;
> -
> -	wq = dax_entry_waitqueue(mapping, index, entry, &key);
> -
> -	/*
> -	 * Checking for locked entry and prepare_to_wait_exclusive() happens
> -	 * under mapping->tree_lock, ditto for entry handling in our callers.
> -	 * So at this point all tasks that could have seen our entry locked
> -	 * must be in the waitqueue and the following check will see them.
> -	 */
> -	if (waitqueue_active(wq))
> -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> -}
> -
>  static int __dax_invalidate_mapping_entry(struct address_space *mapping,
>  					  pgoff_t index, bool trunc)
>  {
> @@ -468,50 +468,6 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  	return __dax_invalidate_mapping_entry(mapping, index, false);
>  }
>  
> -/*
> - * The user has performed a load from a hole in the file.  Allocating
> - * a new page in the file would cause excessive storage usage for
> - * workloads with sparse files.  We allocate a page cache page instead.
> - * We'll kick it out of the page cache if it's ever written to,
> - * otherwise it will simply fall out of the page cache under memory
> - * pressure without ever having been dirtied.
> - */
> -static int dax_load_hole(struct address_space *mapping, void **entry,
> -			 struct vm_fault *vmf)
> -{
> -	struct inode *inode = mapping->host;
> -	struct page *page;
> -	int ret;
> -
> -	/* Hole page already exists? Return it...  */
> -	if (!radix_tree_exceptional_entry(*entry)) {
> -		page = *entry;
> -		goto finish_fault;
> -	}
> -
> -	/* This will replace locked radix tree entry with a hole page */
> -	page = find_or_create_page(mapping, vmf->pgoff,
> -				   vmf->gfp_mask | __GFP_ZERO);
> -	if (!page) {
> -		ret = VM_FAULT_OOM;
> -		goto out;
> -	}
> -
> -finish_fault:
> -	vmf->page = page;
> -	ret = finish_fault(vmf);
> -	vmf->page = NULL;
> -	*entry = page;
> -	if (!ret) {
> -		/* Grab reference for PTE that is now referencing the page */
> -		get_page(page);
> -		ret = VM_FAULT_NOPAGE;
> -	}
> -out:
> -	trace_dax_load_hole(inode, vmf, ret);
> -	return ret;
> -}
> -
>  static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>  		sector_t sector, size_t size, struct page *to,
>  		unsigned long vaddr)
> @@ -938,6 +894,50 @@ int dax_pfn_mkwrite(struct vm_fault *vmf)
>  }
>  EXPORT_SYMBOL_GPL(dax_pfn_mkwrite);
>  
> +/*
> + * The user has performed a load from a hole in the file.  Allocating
> + * a new page in the file would cause excessive storage usage for
> + * workloads with sparse files.  We allocate a page cache page instead.
> + * We'll kick it out of the page cache if it's ever written to,
> + * otherwise it will simply fall out of the page cache under memory
> + * pressure without ever having been dirtied.
> + */
> +static int dax_load_hole(struct address_space *mapping, void **entry,
> +			 struct vm_fault *vmf)
> +{
> +	struct inode *inode = mapping->host;
> +	struct page *page;
> +	int ret;
> +
> +	/* Hole page already exists? Return it...  */
> +	if (!radix_tree_exceptional_entry(*entry)) {
> +		page = *entry;
> +		goto finish_fault;
> +	}
> +
> +	/* This will replace locked radix tree entry with a hole page */
> +	page = find_or_create_page(mapping, vmf->pgoff,
> +				   vmf->gfp_mask | __GFP_ZERO);
> +	if (!page) {
> +		ret = VM_FAULT_OOM;
> +		goto out;
> +	}
> +
> +finish_fault:
> +	vmf->page = page;
> +	ret = finish_fault(vmf);
> +	vmf->page = NULL;
> +	*entry = page;
> +	if (!ret) {
> +		/* Grab reference for PTE that is now referencing the page */
> +		get_page(page);
> +		ret = VM_FAULT_NOPAGE;
> +	}
> +out:
> +	trace_dax_load_hole(inode, vmf, ret);
> +	return ret;
> +}
> +
>  static bool dax_range_is_aligned(struct block_device *bdev,
>  				 unsigned int offset, unsigned int length)
>  {
> -- 
> 2.9.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

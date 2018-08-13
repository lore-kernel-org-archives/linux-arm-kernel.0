From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 13 Aug 2018 03:03:27 -0700
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
Message-ID: <20180813100327.GF44470@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct delayed_uprobe *du;
> +
> +	if (delayed_uprobe_check(uprobe, mm))
> +		return 0;
> +
> +	du = kzalloc(sizeof(*du), GFP_KERNEL);
> +	if (!du)
> +		return -ENOMEM;
> +
> +	du->uprobe = uprobe;
> +	du->mm = mm;
> +	list_add(&du->list, &delayed_uprobe_list);
> +	return 0;
> +}
> +

Should we keep the delayed uprobe list per mm?
That way we could avoid the global mutex lock.
And the list to traverse would also be small.


> 
> @@ -378,8 +557,15 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
> 
>  static void put_uprobe(struct uprobe *uprobe)
>  {
> -	if (atomic_dec_and_test(&uprobe->ref))
> +	if (atomic_dec_and_test(&uprobe->ref)) {
> +		/*
> +		 * If application munmap(exec_vma) before uprobe_unregister()
> +		 * gets called, we don't get a chance to remove uprobe from
> +		 * delayed_uprobe_list in remove_breakpoint(). Do it here.
> +		 */
> +		delayed_uprobe_remove(uprobe, NULL);

I am not getting this part. If unmap happens before unregister,
why cant we use uprobe_munmap? what am I missing.

>  		kfree(uprobe);
> +	}
>  }
> 

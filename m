From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 14 Aug 2018 14:26:49 +0530
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
Message-ID: <2e55cc3b-a268-b66b-f75f-2a0fab02c6bf@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +static int delayed_uprobe_install(struct vm_area_struct *vma)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +	unsigned long vaddr;
> +	int ret = 0, err = 0;
> +
> +	mutex_lock(&delayed_uprobe_lock);
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +
> +		if (!valid_ref_ctr_vma(du->uprobe, vma))
> +			continue;

I think we should compare mm here. I.e.:

    if (du->mm != vma->vm_mm || !valid_ref_ctr_vma(du->uprobe, vma))
            continue;

Otherwise things can mess up.

> +
> +		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
> +		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
> +		/* Record an error and continue. */
> +		if (ret && !err)
> +			err = ret;
> +		delayed_uprobe_delete(du);
> +	}
> +	mutex_unlock(&delayed_uprobe_lock);
> +	return err;
> +}

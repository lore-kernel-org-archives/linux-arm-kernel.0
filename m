From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 25 Jul 2018 13:08:02 +0200
Subject: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
In-Reply-To: <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
Message-ID: <20180725110802.GA27325@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No, I can't understand this patch...

On 07/16, Ravi Bangoria wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -63,6 +63,8 @@ static struct percpu_rw_semaphore dup_mmap_sem;
>
>  /* Have a copy of original instruction */
>  #define UPROBE_COPY_INSN	0
> +/* Reference counter offset is reloaded with non-zero value. */
> +#define REF_CTR_OFF_RELOADED	1
>
>  struct uprobe {
>  	struct rb_node		rb_node;	/* node in the rb tree */
> @@ -476,9 +478,23 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  		return ret;
>
>  	ret = verify_opcode(old_page, vaddr, &opcode);
> -	if (ret <= 0)
> +	if (ret < 0)
>  		goto put_old;

I agree, "ret <= 0" wasn't nice even before this change, but "ret < 0" looks
worse because this is simply not possible.

> +	/*
> +	 * If instruction is already patched but reference counter offset
> +	 * has been reloaded to non-zero value, increment the reference
> +	 * counter and return.
> +	 */
> +	if (ret == 0) {
> +		if (is_register &&
> +		    test_bit(REF_CTR_OFF_RELOADED, &uprobe->flags)) {
> +			WARN_ON(!uprobe->ref_ctr_offset);
> +			ret = update_ref_ctr(uprobe, mm, true);
> +		}
> +		goto put_old;
> +	}

So we need to force update_ref_ctr(true) in case when uprobe_register_refctr()
detects the already registered uprobe with ref_ctr_offset == 0, and then it calls
register_for_each_vma().

Why this can't race with uprobe_mmap() ?

uprobe_mmap() can do install_breakpoint() right after REF_CTR_OFF_RELOADED was set,
then register_for_each_vma() will find this vma and do install_breakpoint() too.
If ref_ctr_vma was already mmaped, the counter will be incremented twice, no?

> @@ -971,6 +1011,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  	bool is_register = !!new;
>  	struct map_info *info;
>  	int err = 0;
> +	bool installed = false;
>
>  	percpu_down_write(&dup_mmap_sem);
>  	info = build_map_info(uprobe->inode->i_mapping,
> @@ -1000,8 +1041,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  		if (is_register) {
>  			/* consult only the "caller", new consumer. */
>  			if (consumer_filter(new,
> -					UPROBE_FILTER_REGISTER, mm))
> +					UPROBE_FILTER_REGISTER, mm)) {
>  				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
> +				installed = true;
> +			}
>  		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
>  			if (!filter_chain(uprobe,
>  					UPROBE_FILTER_UNREGISTER, mm))
> @@ -1016,6 +1059,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>  	}
>   out:
>  	percpu_up_write(&dup_mmap_sem);
> +	if (installed)
> +		clear_bit(REF_CTR_OFF_RELOADED, &uprobe->flags);

I simply can't understand this "bool installed"....

shouldn't we clear REF_CTR_OFF_RELOADED unconditionally after register_for_each_vma()?



Also. Suppose we have a registered uprobe with ref_ctr_offset == 0. Then you add and
remove uprobe with ref_ctr_offset != 0. But afaics uprobe->ref_ctr_offset is never
cleared, so another uprobe with a different ref_ctr_offset != 0 will hit pr_warn/-EINVAL
in alloc_uprobe() and find_old_trace_uprobe() added by the previous patch can't detect
this case?

Plus it seems that we can have the unbalanced update_ref_ctr(false), at least in case
when __uprobe_register() with REF_CTR_OFF_RELOADED set fails before it patches all mm's.
If/when the 1st uprobe with ref_ctr_offset == 0 goes away, remove_breakpoint() will dec
the counter even if wasn't incremented.

Quite possibly I am totally confused, but this patch wrong in many ways...

Oleg.

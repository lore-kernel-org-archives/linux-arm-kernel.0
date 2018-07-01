From: oleg@redhat.com (Oleg Nesterov)
Date: Sun, 1 Jul 2018 23:09:35 +0200
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
Message-ID: <20180701210935.GA14404@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28, Ravi Bangoria wrote:
>
> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
>  	if (ret <= 0)
>  		goto put_old;
>  
> +	/* Update the ref_ctr if we are going to replace instruction. */
> +	if (!ref_ctr_updated) {
> +		ret = update_ref_ctr(uprobe, mm, is_register);
> +		if (ret)
> +			goto put_old;
> +
> +		ref_ctr_updated = 1;
> +	}

Why can't this code live in install_breakpoint() and remove_breakpoint() ?
this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
and the logic will be more simple.

And let me ask again... May be you have already explained this, but I can't
find the previous discussion.

So why do we need a counter but not a boolean? IIRC, because the counter can
be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
right?

But who else can use this counter and how? Say, can userspace update it too?
If yes, why this can't race with __update_ref_ctr() ?

And btw, why does __update_ref_ctr() use FOLL_FORCE? This vma should be writeable
or valid_ref_ctr_vma() should nack it?

And shouldn't valid_ref_ctr_vma() check VM_SHARED? IIUC we do not want to write
to this file?

Oleg.

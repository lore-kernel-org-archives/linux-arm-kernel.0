From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 16 Apr 2014 16:51:07 +0200
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <1397626297-23873-2-git-send-email-victor.kamensky@linaro.org>
References: <1397626297-23873-1-git-send-email-victor.kamensky@linaro.org>
 <1397626297-23873-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140416145107.GA11039@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15, Victor Kamensky wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1149,7 +1149,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	}
>
>  	ret = install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO, &area->page);
> +				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_WRITE, &area->page);

Yes, this is nasty.

I would like to have a reason to nack this change ;) Unfortunately the current
code is buggy too and we need to protect the kernel from malicious applications
which can rewrite the insn we are going to step over in UTASK_SSTEP state anyway.

> +void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> +				  void *src, unsigned long len)
> +{
> +	/*
> +	 * Note if CPU does not support instructions write snooping
> +	 * from dcache it needs to define its own version of this
> +	 * function that would take care of proper cache flushes.
> +	 *
> +	 * Nothing we can do if it fails, added if to make unused
> +	 * result warning happy. If xol write failed because process
> +	 * unmapped xol area by mistake, process will crash in some
> +	 * other place.
> +	 */
> +	if (__copy_to_user((void *) vaddr, src, len));
> +}

Plus, again, this can write to another mapping, say to file-backed memory.

Finally, with this change it won't be possible to share this xol memory with
other tasks.

But it seems that it is pointless to argue.

Oleg.

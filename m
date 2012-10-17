From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Wed, 17 Oct 2012 22:22:18 +0530
Subject: [PATCH 3/9] uprobes: allow ignoring of probe hits
In-Reply-To: <1350242593-17761-3-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-3-git-send-email-rabin@rab.in>
Message-ID: <20121017165218.GG11096@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1469,6 +1474,7 @@ static void handle_swbp(struct pt_regs *regs)
>  	struct uprobe *uprobe;
>  	unsigned long bp_vaddr;
>  	int uninitialized_var(is_swbp);
> +	bool ignored = false;
> 
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
>  	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
> @@ -1499,6 +1505,12 @@ static void handle_swbp(struct pt_regs *regs)
>  			goto cleanup_ret;
>  	}
>  	utask->active_uprobe = uprobe;
> +
> +	if (arch_uprobe_ignore(&uprobe->arch, regs)) {
> +		ignored = true;
> +		goto cleanup_ret;
> +	}
> +

With Oleg's changes, this should become simple. Something like:

	if (arch_uprobe_ignore(&uprobe->arch, regs))
		goto out;

>  	handler_chain(uprobe, regs);
>  	if (uprobe->flags & UPROBE_SKIP_SSTEP && can_skip_sstep(uprobe, regs))
>  		goto cleanup_ret;
> @@ -1514,7 +1526,7 @@ cleanup_ret:
>  		utask->active_uprobe = NULL;
>  		utask->state = UTASK_RUNNING;
>  	}
> -	if (!(uprobe->flags & UPROBE_SKIP_SSTEP))
> +	if (!ignored && !(uprobe->flags & UPROBE_SKIP_SSTEP))
> 
>  		/*
>  		 * cannot singlestep; cannot skip instruction;
> -- 
> 1.7.9.5
> 

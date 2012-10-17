From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Wed, 17 Oct 2012 22:10:59 +0530
Subject: [PATCH 2/9] uprobes: check for single step support
In-Reply-To: <1350242593-17761-2-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-2-git-send-email-rabin@rab.in>
Message-ID: <20121017164059.GF11096@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rabin Vincent <rabin@rab.in> [2012-10-14 21:23:06]:

> Check for single step support before calling user_enable_single_step(),
> since user_enable_single_step() just BUG()s if support does not exist.
> Needed by ARM.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  kernel/events/uprobes.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 98256bc..db4e3ab 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1450,7 +1450,8 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
> 
>  void __weak arch_uprobe_enable_step(struct arch_uprobe *arch)
>  {
> -	user_enable_single_step(current);
> +	if (arch_has_single_step())
> +		user_enable_single_step(current);
>  }
> 
>  void __weak arch_uprobe_disable_step(struct arch_uprobe *arch)

This change is fine. But I am wondering if should have a dummy
arch_uprobe_enable_step / arch_uprobe_disable_step in uprobes ARM.

If arch_uprobe_enable_step() wasnt a weak function, then the fix you
suggested would have been the only way to go.

Again, I am not against this change. But I am hoping that we get
feedback on which option is prefered, having this check or having a
dummy function in archs like ARM.

-- 
Thanks and Regards
Srikar

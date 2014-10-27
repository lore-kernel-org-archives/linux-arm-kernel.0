From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 27 Oct 2014 21:24:57 +0900
Subject: [PATCH v7 1/2] kprobes: copy ainsn after alloc aggr kprobe
In-Reply-To: <1414219865-35988-2-git-send-email-wangnan0@huawei.com>
References: <1414219865-35988-1-git-send-email-wangnan0@huawei.com>
 <1414219865-35988-2-git-send-email-wangnan0@huawei.com>
Message-ID: <544E3999.2010802@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/10/25 15:51), Wang Nan wrote:
> Copy old kprobe to newly alloced optimized_kprobe before
> arch_prepare_optimized_kprobe(). Original kprove can brings more
> information to optimizer.

Hmm, yes, but this also call copy_kprobe twice in try_to_optimize_kprobe().
If you really need the original kprobe information, I think you'd better
change the arch_prepare_optimized_kprobe as below;

/* Pass both of new optprobe and original kprobe */
arch_prepare_optimized_kprobe(op, p);

Thank you,

> 
> v1 -> v2:
>  -  Bugfix: copy p->addr when alloc_aggr_kprobe.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  kernel/kprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 3995f54..e9868ec 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -730,7 +730,13 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&op->list);
> +
> +	/*
> +	 * copy gives arch_prepare_optimized_kprobe
> +	 * more information
> +	 */
>  	op->kp.addr = p->addr;
> +	copy_kprobe(p, &op->kp);
>  	arch_prepare_optimized_kprobe(op);
>  
>  	return &op->kp;
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com

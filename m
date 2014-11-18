From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 18 Nov 2014 20:38:22 +0900
Subject: [PATCH v8 1/2] kprobes: copy ainsn after alloc aggr kprobe
In-Reply-To: <1416292359-75893-2-git-send-email-wangnan0@huawei.com>
References: <1416292359-75893-1-git-send-email-wangnan0@huawei.com>
 <1416292359-75893-2-git-send-email-wangnan0@huawei.com>
Message-ID: <546B2FAE.7000104@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wang,

(2014/11/18 15:32), Wang Nan wrote:
> Copy old kprobe to newly alloced optimized_kprobe before
> arch_prepare_optimized_kprobe(). Original kprove can brings more
> information to optimizer.

As I've asked you on the previous series, I prefer to transfer the
original kprobes to arch_prepare_optimized_kprobe().

OK, now I'll send you my patch. If you can agree, feel free to
pick that into your series.

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

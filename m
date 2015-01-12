From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 12 Jan 2015 21:52:48 +0900
Subject: [PATCH] kprobes: bugfix: checks kprobes_all_disarmed in
 unoptimized_kprobe().
In-Reply-To: <1421064563-77831-1-git-send-email-wangnan0@huawei.com>
References: <54B3B32E.7070709@hitachi.com>
 <1421064563-77831-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54B3C3A0.6010708@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/01/12 21:09), Wang Nan wrote:
> Original code failed to disarm the probed instruction after
> 
> echo 0 > /sys/kernel/debug/kprobes/enabled
> 
> if OPTPROBE is enabled.
> 
> This patch checks kprobes_all_disarmed in unoptimized_kprobe().
> 

Looks good :)

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Thank you!

> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  kernel/kprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9471710..f16936b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -630,6 +630,9 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
>  {
>  	struct optimized_kprobe *op;
>  
> +	if (kprobes_all_disarmed)
> +		return;
> +
>  	if (!kprobe_aggrprobe(p) || kprobe_disarmed(p))
>  		return; /* This is not an optprobe nor optimized */
>  
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com

From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 12 Jan 2015 20:42:38 +0900
Subject: [PATCH] kprobes: bugfix: force unoptimize when disable kprobes.
In-Reply-To: <1420461140-27153-1-git-send-email-wangnan0@huawei.com>
References: <1420461140-27153-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54B3B32E.7070709@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/01/05 21:32), Wang Nan wrote:
> Original code failed to disarm the probed instruction after
> 
> echo 0 > /sys/kernel/debug/kprobes/enabled
> 
> if OPTPROBE is enabled.
> 
> This is caused by a piece of logically inconsistent code:
> 
> 	unoptimize_kprobe(p, false);
> 	if (!kprobe_queued(p)) {
> 		...
> 	}
> 
> unoptimize_kprobe() with 'force' == false queues p onto
> unoptimizing_list, so following kprobe_queued() check always fail unless
> another core schedules optimizer and does the unoptimization very soon.
> This logic causes arch_disarm_kprobe() failed to get execute, lefts a
> breakpoint at the probed address, instead of restoring it.

No, the root cause of this failure comes from the lack of checking
kprobes_all_disarmed in unoptimized_kprobe(). It should check the flag
and return soon if it is set.

So, I Nak this patch.

> 
> This patch uses force unoptimize instead.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index b185464..9fbe0c3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -869,7 +869,7 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
>  {
>  	struct kprobe *_p;
>  
> -	unoptimize_kprobe(p, false);	/* Try to unoptimize */
> +	unoptimize_kprobe(p, true);	/* Try to unoptimize */
>  
>  	if (!kprobe_queued(p)) {
>  		arch_disarm_kprobe(p);
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com

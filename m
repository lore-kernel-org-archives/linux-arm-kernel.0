From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 20 Jan 2015 16:12:13 +0900
Subject: [PATCH] kprobes: bugfix: makes kprobes/enabled works correctly
 for optimized kprobes.
In-Reply-To: <1421722311-30455-1-git-send-email-wangnan0@huawei.com>
References: <54BCFC6E.1080007@hitachi.com>
 <1421722311-30455-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54BDFFCD.6070303@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/01/20 11:51), Wang Nan wrote:
> debugfs/kprobes/enabled doesn't work correctly on optimized kprobes.
> Masami Hiramatsu has a test report on x86_64 platform:
> 
> https://lkml.org/lkml/2015/1/19/274
> 
> This patch forces it to unoptimize kprobe if kprobes_all_disarmed
> is set. It also checks the flag in unregistering path for skipping
> unneeded disarming process when kprobes globally disarmed.
> 

OK, here is the test result.
----
[root at localhost tracing]# echo p do_fork+5 > kprobe_events
[root at localhost tracing]# echo $$ > set_ftrace_pid
[root at localhost tracing]# echo 1 > events/kprobes/p_do_fork_5/enable
[root at localhost tracing]# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-11466 [004] d...  4548.420463: p_do_fork_5: (do_fork+0x5/0x360)
[root at localhost tracing]# cat ../kprobes/list
ffffffff810bc1c5  k  do_fork+0x5    [OPTIMIZED]
[root at localhost tracing]# echo 0 > ../kprobes/enabled   # kprobes globally disabled
[root at localhost tracing]# echo > trace                  # clear trace buffer
[root at localhost tracing]# cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |          # No event traced!
[root at localhost tracing]# echo 0 > events/kprobes/p_do_fork_5/enable
[root at localhost tracing]# echo > kprobe_events
[root at localhost tracing]# cat ../kprobes/list
[root at localhost tracing]#				# And we can safely remove the probe
-----

Now it looks good to me :)

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Tested-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Ingo,
Could you pull this patch to your -tip tree?

Thank you,

> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  kernel/kprobes.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9471710..fb995ef 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -869,7 +869,8 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
>  {
>  	struct kprobe *_p;
>  
> -	unoptimize_kprobe(p, false);	/* Try to unoptimize */
> +	/* Try to unoptimize */
> +	unoptimize_kprobe(p, kprobes_all_disarmed);
>  
>  	if (!kprobe_queued(p)) {
>  		arch_disarm_kprobe(p);
> @@ -1571,7 +1572,13 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
>  
>  		/* Try to disarm and disable this/parent probe */
>  		if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
> -			disarm_kprobe(orig_p, true);
> +			/*
> +			 * If kprobes_all_disarmed is set, orig_p
> +			 * should have already been disarmed, so
> +			 * skip unneed disarming process.
> +			 */
> +			if (!kprobes_all_disarmed)
> +				disarm_kprobe(orig_p, true);
>  			orig_p->flags |= KPROBE_FLAG_DISABLED;
>  		}
>  	}
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com

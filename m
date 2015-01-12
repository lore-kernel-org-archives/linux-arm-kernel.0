From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 12 Jan 2015 20:24:02 +0900
Subject: [PATCH] kprobes: bugfix: set kprobes_all_disarmed earlier
 to enable re-optimization.
In-Reply-To: <1420461075-27012-1-git-send-email-wangnan0@huawei.com>
References: <1420461075-27012-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54B3AED2.5070000@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/01/05 21:31), Wang Nan wrote:
> In original code, the probed instruction doesn't get optimized after
> 
> echo 0 > /sys/kernel/debug/kprobes/enabled
> echo 1 > /sys/kernel/debug/kprobes/enabled
> 
> This is because original code checks kprobes_all_disarmed in
> optimize_kprobe(), but this flag is turned off after calling that
> function. Therefore, optimize_kprobe() will see
> kprobes_all_disarmed == true and doesn't do the optimization.

OK, a workaround is to disable/enable optimizing via sysctl.

> 
> This patch simply turns off kprobes_all_disarmed earlier to enable
> optimization.
> 

Anyway, thank you for finding that! :)

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>


> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  kernel/kprobes.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bad4e95..b185464 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2320,6 +2320,12 @@ static void arm_all_kprobes(void)
>  	if (!kprobes_all_disarmed)
>  		goto already_enabled;
>  
> +	/*
> +	 * optimize_kprobe() called by arm_kprobe() checks
> +	 * kprobes_all_disarmed, so set kprobes_all_disarmed before
> +	 * arm_kprobe.
> +	 */
> +	kprobes_all_disarmed = false;
>  	/* Arming kprobes doesn't optimize kprobe itself */
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
> @@ -2328,7 +2334,6 @@ static void arm_all_kprobes(void)
>  				arm_kprobe(p);
>  	}
>  
> -	kprobes_all_disarmed = false;
>  	printk(KERN_INFO "Kprobes globally enabled\n");
>  
>  already_enabled:
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com

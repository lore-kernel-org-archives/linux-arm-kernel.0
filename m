From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Wed, 14 Jan 2015 00:34:13 +0900
Subject: [RFC PATCH 01/11] ARM: kprobes: directly modify code if kprobe
 is not initialized.
In-Reply-To: <1420616124-42765-1-git-send-email-wangnan0@huawei.com>
References: <1420616086-42692-1-git-send-email-wangnan0@huawei.com>
 <1420616124-42765-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54B53AF5.2010303@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/01/07 16:35), Wang Nan wrote:
> If kprobe is optimized before kprobe is initialized, there should
> be only one core, the probed instruction is not armed with breakpoint,
> so simply patch text is okay.

This patch looks very hacky. If kprobes is not initialized, why anyone
can optimize kprobes? I think you must introduce early kprobes init
routine and set init flag at that point.

Thank you,

> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  arch/arm/probes/kprobes/opt-arm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index 15b37c0..a021474 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -325,8 +325,17 @@ void __kprobes arch_optimize_kprobes(struct list_head *oplist)
>  		 * Similar to __arch_disarm_kprobe, operations which
>  		 * removing breakpoints must be wrapped by stop_machine
>  		 * to avoid racing.
> +		 *
> +		 * If this function is called before kprobes initialized,
> +		 * the kprobe should be an early kprobe, the instruction
> +		 * is not armed with breakpoint. There should be only
> +		 * one core now, so directly __patch_text is enough.
>  		 */
> -		kprobes_remove_breakpoint(op->kp.addr, insn);
> +		if (unlikely(!kprobes_initialized)) {
> +			BUG_ON(!(op->kp.flags & KPROBE_FLAG_EARLY));
> +			__patch_text(op->kp.addr, insn);
> +		} else
> +			kprobes_remove_breakpoint(op->kp.addr, insn);
>  
>  		list_del_init(&op->list);
>  	}
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com

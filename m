From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 21 Jun 2013 23:18:26 +0200 (CEST)
Subject: [PATCHv3/RESEND 4/4] clocksource: arch_timer: Add support for
 memory mapped timers
In-Reply-To: <1371836361-20574-5-git-send-email-sboyd@codeaurora.org>
References: <1371836361-20574-1-git-send-email-sboyd@codeaurora.org>
 <1371836361-20574-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1306212304480.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013, Stephen Boyd wrote:
>  /*
>   * Architected system timer support.
> @@ -46,13 +73,69 @@ static bool arch_timer_use_virtual = true;
>  static inline void arch_timer_reg_write(int access, int reg, u32 val,
>  					struct clock_event_device *clk)
>  {
> -	arch_timer_reg_write_cp15(access, reg, val);
> +	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
> +		struct arch_timer *timer = to_arch_timer(clk);
> +		switch (reg) {
> +		case ARCH_TIMER_REG_CTRL:
> +			writel_relaxed(val, timer->base + CNTP_CTL);
> +			break;
> +		case ARCH_TIMER_REG_TVAL:
> +			writel_relaxed(val, timer->base + CNTP_TVAL);
> +			break;
> +		default:
> +			BUILD_BUG();

So you are relying on the compiler cleverness to identify a caller
which calls that inline with a not supported reg value.

How does that work, when the compiler decides not to inline that?

enum without a default case emits at least a reliable warning.

> +		}
> +	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
> +		struct arch_timer *timer = to_arch_timer(clk);
> +		switch (reg) {
> +		case ARCH_TIMER_REG_CTRL:
> +			writel_relaxed(val, timer->base + CNTV_CTL);
> +			break;
> +		case ARCH_TIMER_REG_TVAL:
> +			writel_relaxed(val, timer->base + CNTV_TVAL);
> +			break;
> +		default:
> +			BUILD_BUG();
> +		}
> +	} else {
> +		arch_timer_reg_write_cp15(access, reg, val);
> +	}
>  }

Something in my little brain yells: function pointer

You can't be serious about hacking nested if/else/switch constructs
into a hot path.

Why not making your cpu data:

struct arch_timer {
       struct clock_event_device evt;
       ....
       void (*write_ctrl)(val, timer);
       void (*write_tval)(val, timer);
       ....
}

and get rid of all that conditionals?

Thanks,

	tglx

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Feb 2016 11:58:24 +0000
Subject: [PATCH] arm64: add architecture specified current_pt_regs
In-Reply-To: <1455796115-7844-1-git-send-email-zhizhou.zh@gmail.com>
References: <1455796115-7844-1-git-send-email-zhizhou.zh@gmail.com>
Message-ID: <20160218115824.GA2538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 07:48:35PM +0800, Zhi-zhou Zhang wrote:
> From: zhizhou <zhizhou.zh@gmail.com>
> 
> This patch is based on the implementation of arm. The generic
> current_pt_regs is implemented with current->stack. It need to access
> memory that would be too expensive.

Do you have any performance numbers?

> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index e9e5467..1865d54 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -185,5 +185,9 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
>  
>  extern unsigned long profile_pc(struct pt_regs *regs);
>  
> +#define current_pt_regs(void) ({ (struct pt_regs *)			\
> +	((current_stack_pointer | (THREAD_SIZE - 1)) - 0xf) - 1;	\
> +})

I don't think this works well with the separate IRQ stack that we merged
in 4.5-rc1. current_thread_info() explicitly uses "sp_el0" while
current_stack_pointer is just "sp" (though I don't think we ever use
current_pt_regs in interrupt context).

-- 
Catalin

From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Mar 2016 16:08:16 +0000
Subject: [PATCH 1/2] arm64: Store breakpoint single step state into pstate
In-Reply-To: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
Message-ID: <20160321160816.GL23397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 08:37:49AM +0000, He Kuang wrote:
> From: Wang Nan <wangnan0@huawei.com>
> 
> Store breakpoint single step state into pstate to fix the
> recursion issue on ARM64.
> 
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/debug-monitors.h |  9 ++++++
>  arch/arm64/include/uapi/asm/ptrace.h    | 10 +++++++
>  arch/arm64/kernel/hw_breakpoint.c       | 49 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal.c              |  2 ++
>  4 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 279c85b5..b5902e8 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -132,11 +132,20 @@ int kernel_active_single_step(void);
>  
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
>  int reinstall_suspended_bps(struct pt_regs *regs);
> +u64 signal_single_step_enable_bps(void);
> +void signal_reinstall_single_step(u64 pstate);
>  #else
>  static inline int reinstall_suspended_bps(struct pt_regs *regs)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline u64 signal_single_step_enable_bps(void)
> +{
> +	return 0;
> +}
> +
> +static inline void signal_reinstall_single_step(u64 pstate) { }
>  #endif
>  
>  int aarch32_break_handler(struct pt_regs *regs);
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 208db3d..8dbfdac 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -52,6 +52,16 @@
>  #define PSR_N_BIT	0x80000000
>  
>  /*
> + * pstat in pt_regs and user_pt_regs are 64 bits. The highest 32 bits
> + * of it can be used by kernel. One user of them is signal handler.
> + */
> +#define PSR_LINUX_MASK        0xffffffff00000000UL
> +#define PSR_LINUX_HW_BP_SS    0x0000000100000000UL    /* Single step and disable breakpoints */
> +#define PSR_LINUX_HW_WP_SS    0x0000000200000000UL    /* Single step and disable watchpoints */
> +
> +#define PSR_LINUX_HW_SS    (PSR_LINUX_HW_BP_SS | PSR_LINUX_HW_WP_SS)

As I've said before, I'm not at all keen on this approach. We're changing
a UAPI header to include magic numbers that may or may not conflict with
the architecture in future in order to fix a problem that doesn't exist
outside of a contrived test case.

I'd much rather place a restriction on .wakeup_events of the hw_breakpoint
and simply refuse to initialise things in a way that leads to problems down
the line. Ptrace and GDB are the primary users of this interface and I'm not
willing to risk breaking them with these sorts of invasive changes.

Will

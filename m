From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 26 May 2017 08:42:36 -0700
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Explicitly restore
 CONFIG_DEBUG_FS
In-Reply-To: <49b2579b9ad2e5ce0a7c4b163dffb5a885ac7dae.1495797565.git.leonard.crestez@nxp.com>
References: <49b2579b9ad2e5ce0a7c4b163dffb5a885ac7dae.1495797565.git.leonard.crestez@nxp.com>
Message-ID: <20170526154236.GY3956@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 02:26:06PM +0300, Leonard Crestez wrote:
> This option was removed by "make savedefconfig" in
> commit c5054a98bce4 ("ARM: imx_v6_v7_defconfig: Select SMSC_PHY")
> 
> This happened because CONFIG_DEBUG_FS was implicitly selected by
> CONFIG_TREE_RCU_TRACE which defaulted to true because CONFIG_RCU_TRACE
> was enabled by default by commit 961518259b3b ("rcu: Enable RCU
> tracepoints by default to aid in debugging")
> 
> Recently however CONFIG_RCU_TRACE was completely removed by
> commit 6e74c237c410 ("rcu: Remove debugfs tracing")

CONFIG_RCU_TRACE is still very much alive in its new home at
kernel/rcu/Kconfig.debug:

config RCU_TRACE
	bool "Enable tracing for RCU"
	depends on DEBUG_KERNEL
	default y if TREE_RCU
	select TRACE_CLOCK
	help
	  This option enables additional tracepoints for ftrace-style
	  event tracing.

	  Say Y here if you want to enable RCU tracing
	  Say N if you are unsure.

That said, I need to make it default to "y" if PREEMPT_RCU as well as
the current TREE_RCU.  Would that help?

							Thanx, Paul

> The result is that imx_v6_v7_defconfig no longer includes DEBUG_FS on
> linux-next since next-20170517. This is bad, DEBUG_FS is extremely
> useful for kernel introspection and testing.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> 
> Patch is against next-20170526. Applying it to shawnguo/imx/defconfig
> and cycling via savedefconfig makes this diff go away.
> 
> Alternatively maybe DEBUG_FS itself could be made "default y if DEBUG_KERNEL"
> or similar?
> 
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index bf1e7e3..51ca814 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -381,6 +381,7 @@ CONFIG_NLS_ISO8859_1=y
>  CONFIG_NLS_ISO8859_15=m
>  CONFIG_NLS_UTF8=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
>  CONFIG_PROVE_LOCKING=y
> -- 
> 2.7.4
> 

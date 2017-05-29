From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 29 May 2017 14:58:36 +0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Explicitly restore
 CONFIG_DEBUG_FS
In-Reply-To: <20170526154236.GY3956@linux.vnet.ibm.com>
References: <49b2579b9ad2e5ce0a7c4b163dffb5a885ac7dae.1495797565.git.leonard.crestez@nxp.com>
 <20170526154236.GY3956@linux.vnet.ibm.com>
Message-ID: <1496059116.31994.6.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-05-26 at 08:42 -0700, Paul E. McKenney wrote:
> On Fri, May 26, 2017 at 02:26:06PM +0300, Leonard Crestez wrote:
> > 
> > This option was removed by "make savedefconfig" in
> > commit c5054a98bce4 ("ARM: imx_v6_v7_defconfig: Select SMSC_PHY")
> > 
> > This happened because CONFIG_DEBUG_FS was implicitly selected by
> > CONFIG_TREE_RCU_TRACE which defaulted to true because CONFIG_RCU_TRACE
> > was enabled by default by commit 961518259b3b ("rcu: Enable RCU
> > tracepoints by default to aid in debugging")
> > 
> > Recently however CONFIG_RCU_TRACE was completely removed by
> > commit 6e74c237c410 ("rcu: Remove debugfs tracing")

> CONFIG_RCU_TRACE is still very much alive in its new home at
> kernel/rcu/Kconfig.debug:

Sorry, what was removed is the dependency on DEBUG_FS. In particular
this snippet:

diff --git a/init/Kconfig b/init/Kconfig
index 2aa14ff..3025383 100644
--
- a/init/Kconfig
+++ b/init/Kconfig
@@ -659,14 +659,6 @@ config
RCU_FAST_NO_HZ
?
??????????Say N if you are unsure.
?
-config
TREE_RCU_TRACE
-???????def_bool RCU_TRACE && ( TREE_RCU || PREEMPT_RCU )
-???????select DEBUG_FS
-???????help
-?????????This option provides
tracing for the TREE_RCU and
-?????????PREEMPT_RCU implementations,
permitting Makefile to
-?????????trivially select
kernel/rcutree_trace.c.
-
?config RCU_BOOST
????????bool "Enable RCU
priority boosting"
????????depends on RT_MUTEXES && PREEMPT_RCU &&
RCU_EXPERT

> config RCU_TRACE
> 	bool "Enable tracing for RCU"
> 	depends on DEBUG_KERNEL
> 	default y if TREE_RCU
> 	select TRACE_CLOCK
> 	help
> 	??This option enables additional tracepoints for ftrace-style
> 	??event tracing.
> 
> 	??Say Y here if you want to enable RCU tracing
> 	??Say N if you are unsure.
> 
> That said, I need to make it default to "y" if PREEMPT_RCU as well as
> the current TREE_RCU.??Would that help?

I don't think you can help unless you want to make RCU_TRACE depend on
DEBUG_FS for no reason. The proper fix is to have DEBUG_FS inside the
imx_v6_v7_defconfig.

My problem is just an unfortunate accident with default dependencies
and overzealous savedefconfig.

As far as I understand after recent changes RCU_TRACE is now only
useful with tracepoints. Shouldn't it depend on TRACEPOINTS in some
way? It's still possible to compile with RCU_TRACE on and TRACEPOINTS
off, is this intentional? It seems that when this happens you're just
relying on tracepoint macros to expand to nothing.

Fr example maybe RCU_TRACE should be "default y if (TREE_RCU &&
TRACEPOINTS); depends on TRACEPOINTS"?

In theory you could also "select TRACEPOINTS" but then you would end up
enabling TRACEPOINTS by default in all configurations that use TREE_RCU
but don't explicitly disable RCU_TRACE.

I'd say that if $SUBSYSTEM_DEBUG depends on $MAJOR_DEBUG_FEATURE it
should try to avoid selecting $MAJOR_DEBUG_FEATURE by default if it's
not otherwise enabled. As far as I can tell this is how RCU ended up
indirectly pulling in DEBUG_FS and later unexpectedly removed it.

Or I could be completely wrong, kconfig can be very confusing.

--?
Regards,
Leonard

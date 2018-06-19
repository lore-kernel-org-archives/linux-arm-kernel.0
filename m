From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jun 2018 13:58:50 +0100
Subject: [PATCH] arm: Hook up SYNC_CORE functionality for sys_membarrier()
In-Reply-To: <1431651959.17300.1529412602455.JavaMail.zimbra@efficios.com>
References: <1529410974-18929-1-git-send-email-will.deacon@arm.com>
 <1431651959.17300.1529412602455.JavaMail.zimbra@efficios.com>
Message-ID: <20180619125849.GH13984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Tue, Jun 19, 2018 at 08:50:02AM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 19, 2018, at 8:22 AM, Will Deacon will.deacon at arm.com wrote:
> 
> > Exception return implies context synchronization, so we can hook up the
> > SYNC_CORE option to sys_membarrier() simply by selecting the Kconfig option,
> > just like we've done for arm64 already.
> > 
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Orion Hodson <oth@google.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > arch/arm/Kconfig | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 54eeb8d00bc6..b0ac18547370 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -9,6 +9,7 @@ config ARM
> > 	select ARCH_HAS_ELF_RANDOMIZE
> > 	select ARCH_HAS_FORTIFY_SOURCE
> > 	select ARCH_HAS_KCOV
> > +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> 
> In addition to this, we added this comment in arch/arm64/kernel/entry.S:
> 
> +       /*
> +        * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
> +        * when returning from IPI handler, and when returning to user-space.
> +        */
> 
> So I would expect a similar comment in arch/arm/kernel/entry-header.S, within
> svc_exit and svc_exit_via_fiq:
> 
>         /*
>          * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on [insn] context synchronization
>          * when returning from IPI handler, and when returning to user-space.
>          */

Bah, you know I hate that comment ;) I should update arch-support.txt,
though. Diff below.

> Which instruction exactly is responsible for context synchronization on
> arm32 ?

It's the act of doing an exception return, so there are multiple instruction
sequences to do that on 32-bit arm.

Will

--->8

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index dbdf62907703..c7858dd1ea8f 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -5,10 +5,10 @@
 #
 # Architecture requirements
 #
-# * arm64
+# * arm/arm64
 #
-# Rely on eret context synchronization when returning from IPI handler, and
-# when returning to user-space.
+# Rely on implicit context synchronization as a result of exception return
+# when returning from IPI handler, and when returning to user-space.
 #
 # * x86
 #
@@ -31,7 +31,7 @@
     -----------------------
     |       alpha: | TODO |
     |         arc: | TODO |
-    |         arm: | TODO |
+    |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |

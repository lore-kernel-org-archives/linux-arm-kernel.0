From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Tue, 19 Jun 2018 08:50:02 -0400 (EDT)
Subject: [PATCH] arm: Hook up SYNC_CORE functionality for sys_membarrier()
In-Reply-To: <1529410974-18929-1-git-send-email-will.deacon@arm.com>
References: <1529410974-18929-1-git-send-email-will.deacon@arm.com>
Message-ID: <1431651959.17300.1529412602455.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- On Jun 19, 2018, at 8:22 AM, Will Deacon will.deacon at arm.com wrote:

> Exception return implies context synchronization, so we can hook up the
> SYNC_CORE option to sys_membarrier() simply by selecting the Kconfig option,
> just like we've done for arm64 already.
> 
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Orion Hodson <oth@google.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> arch/arm/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 54eeb8d00bc6..b0ac18547370 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -9,6 +9,7 @@ config ARM
> 	select ARCH_HAS_ELF_RANDOMIZE
> 	select ARCH_HAS_FORTIFY_SOURCE
> 	select ARCH_HAS_KCOV
> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE

In addition to this, we added this comment in arch/arm64/kernel/entry.S:

+       /*
+        * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
+        * when returning from IPI handler, and when returning to user-space.
+        */

So I would expect a similar comment in arch/arm/kernel/entry-header.S, within
svc_exit and svc_exit_via_fiq:

        /*
         * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on [insn] context synchronization
         * when returning from IPI handler, and when returning to user-space.
         */

Which instruction exactly is responsible for context synchronization on
arm32 ?

Thanks,

Mathieu



> 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
> 	select ARCH_HAS_PHYS_TO_DMA
> 	select ARCH_HAS_SET_MEMORY
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

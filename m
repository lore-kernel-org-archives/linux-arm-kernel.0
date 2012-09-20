From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Sep 2012 10:58:53 +0100
Subject: [PATCH 1/2] arm: Add ARM ERRATA 775420 workaround
In-Reply-To: <1347434097-7924-2-git-send-email-horms@verge.net.au>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-2-git-send-email-horms@verge.net.au>
Message-ID: <CAHkRjk6vbM8f=bK_GkgpDmnYh-UU_M3T9TeOj6Ti7UZB-5U2cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2012 08:14, Simon Horman <horms@verge.net.au> wrote:
> +config ARM_ERRATA_775420
> +       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
> +       depends on CPU_V7
> +       help
> +         This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> +         r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> +         operation aborts with MMU exception, it might cause the processor
> +         deadlock. This workaround puts DSB before executing ISB at the
> +         beginning of the abort exception handler.
> +
>  endmenu

The only case where we can get an abort on cache maintenance is
v7_coherent_user_range(). I don't think we have any ISB on the
exception handling path for this function, so we could just add the
DSB there:

--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -211,6 +211,9 @@ ENTRY(v7_coherent_user_range)
  * isn't mapped, fail with -EFAULT.
  */
 9001:
+#ifdef CONFIG_ARM_ERRATA_775420
+	dsb
+#endif
 	mov	r0, #-EFAULT
 	mov	pc, lr
  UNWIND(.fnend		)

-- 
Catalin

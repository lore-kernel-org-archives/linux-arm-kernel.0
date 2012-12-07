From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 07 Dec 2012 14:48:54 +0000
Subject: [PATCH v2] ARM: Kconfig: Do not force selection of ARCH_VEXPRESS
 by ARCH_MULTI_V7
In-Reply-To: <1353431918-9326-1-git-send-email-festevam@gmail.com>
References: <1353431918-9326-1-git-send-email-festevam@gmail.com>
Message-ID: <50C201D6.7060408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/12 17:18, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When building a kernel using imx_v6_v7_defconfig, it is not possible to unselect
> ARCH_VEXPRESS due to the fact that it is automatically selected by ARCH_MULTI_V7.
> 
> This is not good when someone wants to create a minimal kernel build, so let
> multi_v7_defconfig select ARCH_VEXPRESS instead.

This patch solves one aspect of a problem previously discussed for !MMU [1], but
we still have the dependency of ARCH_MULTI_V7 for ARCH_VEXPRESS. ARCH_MULTI_V7
doesn't make very much sense without an MMU because we need to hardcode things
like PHYS_OFFSET and the vectors.

Looking back though the log, I can't see quite why we need this dependency. With
Fabio's patch that selects ARCH_VEXPRESS in the defconfig, is it still required?

How do people feel about something like the patch below, to allow NOMMU things
to use Versatile Express without MULTI_V7?

Jonny
[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129976.html

-----8<-----------
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index c952960..7d3fff4 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_VEXPRESS
-       bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
+       bool "ARM Ltd. Versatile Express family" if (ARCH_MULTI_V7 || !MMU)
        select ARCH_WANT_OPTIONAL_GPIOLIB
        select ARM_AMBA
        select ARM_GIC

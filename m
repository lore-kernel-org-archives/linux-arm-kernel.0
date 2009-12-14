From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 14 Dec 2009 14:04:39 +0000
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

perf events require that we can support atomic64's. There is a generic,
spinlocked version that we can use until we have proper hardware
support.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/include/asm/atomic.h |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c40efec..b13cb85 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,7 @@ config ARM
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
+	select GENERIC_ATOMIC64
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index d0daeab..ff286a8 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -15,6 +15,10 @@
 #include <linux/types.h>
 #include <asm/system.h>
 
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
 #define ATOMIC_INIT(i)	{ (i) }
 
 #ifdef __KERNEL__
-- 
1.6.5.4

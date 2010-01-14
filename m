From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 14 Jan 2010 12:14:14 +0000
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
Message-ID: <1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
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
index 31d52ed..293a879 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
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

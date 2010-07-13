From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:25 +0800
Subject: [PATCH 10/13] [ARM] Introduce ARCH_USES_DEFAULT_TIMEX_H for default
	CLOCK_TICK_RATE
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-11-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLOCK_TICK_RATE is actually a don't-care value. Make it default to
(100 * HZ) when USE_DEFAULT_TIMEX_H is defined, and so no machine
specific timex.h needs to be included.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig             |    3 +++
 arch/arm/include/asm/timex.h |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44aa8b3..57180ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -56,6 +56,9 @@ config ARCH_USES_DEFAULT_IO_H
 config ARCH_USES_DEFAULT_GPIO_H
 	def_bool n
 
+config ARCH_USES_DEFAULT_TIMEX_H
+	def_bool n
+
 config GENERIC_CLOCKEVENTS
 	bool
 
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 3be8de3..8df3b2e 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,7 +12,11 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
+#ifndef CONFIG_ARCH_USES_DEFAULT_TIMEX_H
 #include <mach/timex.h>
+#else
+#define CLOCK_TICK_RATE	(100 * HZ)
+#endif
 
 typedef unsigned long cycles_t;
 
-- 
1.7.1

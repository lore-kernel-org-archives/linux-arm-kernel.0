From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 20:15:59 +0200
Subject: [PATCH 1/5] ARM: iwmmxt: explicitly check for supported architectures
In-Reply-To: <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140414151236.75f8816d@skate>
 <1397585763-23482-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1397585763-23482-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iwmmxt.S requires special treatment of coprocessor access registers
for PJ4 and XScale-based CPUs. It only checks for CPU_PJ4 and drops
down to XScale-based treatment on all other architectures.

As some PJ4B also come with iWMMXt and also need PJ4 treatment,
rework the corresponding preprocessor directives to explicitly
check for supported architectures and fail on unsupported ones.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Chao Xie <xiechao.mail@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/kernel/iwmmxt.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index a08783823b32..2452dd1bef53 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -19,12 +19,16 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 
-#if defined(CONFIG_CPU_PJ4)
+#if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
 #define PJ4(code...)		code
 #define XSC(code...)
-#else
+#elif defined(CONFIG_CPU_MOHAWK) || \
+	defined(CONFIG_CPU_XSC3) || \
+	defined(CONFIG_CPU_XSCALE)
 #define PJ4(code...)
 #define XSC(code...)		code
+#else
+#error "Unsupported iWMMXt architecture"
 #endif
 
 #define MMX_WR0		 	(0x00)
-- 
1.9.1

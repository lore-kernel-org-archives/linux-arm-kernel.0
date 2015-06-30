From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 30 Jun 2015 16:23:07 -0500
Subject: [PATCH 4/4] hvc_dcc: disable user-space access to DCC
In-Reply-To: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
Message-ID: <1435699387-32591-4-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the DCC driver loads, then disable user-space access to the DCC so that
we don't have two entities trying to access the DCC at the same time.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm/include/asm/dcc.h   | 15 +++++++++++++++
 arch/arm64/include/asm/dcc.h | 11 +++++++++++
 drivers/tty/hvc/hvc_dcc.c    |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm/include/asm/dcc.h b/arch/arm/include/asm/dcc.h
index b74899d..c50056b 100644
--- a/arch/arm/include/asm/dcc.h
+++ b/arch/arm/include/asm/dcc.h
@@ -9,8 +9,11 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#ifndef __ASM_DCC_H
+#define __ASM_DCC_H
 
 #include <asm/barrier.h>
+#include <asm/hardware/cp14.h>
 
 static inline u32 __dcc_getstatus(void)
 {
@@ -39,3 +42,15 @@ static inline void __dcc_putchar(char c)
 		: "r" (c));
 	isb();
 }
+
+static inline void __dcc_initialize(void)
+{
+	u32 val;
+
+	/* Disable user-space access to DCC */
+	val = MRC14(0, c0, c1, 0);
+	val |= 1 << 12; /* DSCR[Comms] */
+	MCR14(val, 0, c0, c1, 0);
+}
+
+#endif
diff --git a/arch/arm64/include/asm/dcc.h b/arch/arm64/include/asm/dcc.h
index fcb8d7d..7843e62 100644
--- a/arch/arm64/include/asm/dcc.h
+++ b/arch/arm64/include/asm/dcc.h
@@ -49,4 +49,15 @@ static inline void __dcc_putchar(char c)
 	isb();
 }
 
+static inline void __dcc_initialize(void)
+{
+	u32 val;
+
+	/* Disable user-space access to DCC */
+	asm ("mrs %0, mdscr_el1\n"
+		"	orr %0, %0, #4096\n" /* Set the TDCC bit */
+		"	msr mdscr_el1, %0\n"
+		: "=r" (val));
+}
+
 #endif
diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index f8b8cf2..5ccafa4 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -231,6 +231,8 @@ static int __init hvc_dcc_console_init(void)
 	if (!hvc_dcc_check())
 		return -ENODEV;
 
+	__dcc_initialize();
+
 	/* Returns -1 if error */
 	ret = hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

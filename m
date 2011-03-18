From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 18 Mar 2011 14:38:26 -0700
Subject: [PATCH] msm: uncompress.h: Fix putc unused warning
Message-ID: <1300484306-4480-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-msm/include/mach/uncompress.h:22:
warning: 'putc' defined but not used

When DEBUG_ICEDCC=y putc is redefined to icedcc_putc(). This
leaves the putc implemtation in uncompress.h as unused,
triggering this warning. Fix it by not compiling putc() when
DEBUG_ICEDCC=y.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/uncompress.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index d94292c..47a5579 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -19,6 +19,7 @@
 #include "linux/io.h"
 #include "mach/msm_iomap.h"
 
+#ifndef CONFIG_DEBUG_ICEDCC
 static void putc(int c)
 {
 #if defined(MSM_DEBUG_UART_PHYS)
@@ -27,6 +28,7 @@ static void putc(int c)
 	writel(c, base + 0x0c);
 #endif
 }
+#endif
 
 static inline void flush(void)
 {
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

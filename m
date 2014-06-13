From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 13 Jun 2014 11:26:13 +0400
Subject: [PATCH 2/2] ARM: i.MX system: Add a reset fallback if base address of
 watchdog is not set
In-Reply-To: <1402644373-8408-1-git-send-email-shc_work@mail.ru>
References: <1402644373-8408-1-git-send-email-shc_work@mail.ru>
Message-ID: <1402644373-8408-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a reset fallback if base address of watchdog is not set.
This is intended for a targets not compatible with imx-21 watchdog,
i.MX1 for example.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/system.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index ae521f3..3b9259b 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -42,6 +42,9 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 {
 	unsigned int wcr_enable;
 
+	if (!wdog_base)
+		goto reset_fallback;
+
 	if (!IS_ERR_OR_NULL(wdog_clk))
 		clk_enable(wdog_clk);
 
@@ -70,6 +73,7 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 	/* delay to allow the serial port to show the message */
 	mdelay(50);
 
+reset_fallback:
 	/* we'll take a jump through zero as a poor second */
 	soft_restart(0);
 }
-- 
1.8.5.5

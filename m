From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 13:30:04 +0800
Subject: [PATCH] ARM: imx: improve mxc_restart() on the SRC bit writes
Message-ID: <1383197404-17968-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current comment in the code does not make it clear why the double writes
on SRC bit is needed.  Let's quote the errata to get it clear.  Also, to
ensure there are at least 2 writes happen in the same one 32kHz period,
we actually need 3 writes.  Let's add the third one.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/system.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 826b72b..5e3027d 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -52,7 +52,14 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
 
 	/* Assert SRS signal */
 	__raw_writew(wcr_enable, wdog_base);
-	/* write twice to ensure the request will not get ignored */
+	/*
+	 * Due to imx6q errata ERR004346 (WDOG: WDOG SRS bit requires to be
+	 * written twice), we add another two writes to ensure there must be at
+	 * least two writes happen in the same one 32kHz clock period.  We save
+	 * the target check here, since the writes shouldn't be a huge burden
+	 * for other platforms.
+	 */
+	__raw_writew(wcr_enable, wdog_base);
 	__raw_writew(wcr_enable, wdog_base);
 
 	/* wait for reset to assert... */
-- 
1.7.9.5

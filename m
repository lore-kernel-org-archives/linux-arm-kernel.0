From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Tue, 16 Feb 2010 22:41:52 +0100
Subject: [PATCH 1/2] arm/pxa: Enable check_scoop_reg() only if CONFIG_PM is
	set.
Message-ID: <1266356512-1269-1-git-send-email-stefan@datenfreihafen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function gets only called from scoop_suspend() and scoop_resume() which are
only built in if we have CONFIG_PM set. Make it the same for check_scoop_reg().

This fixes the following warning:
arch/arm/common/scoop.c:143: warning: ?check_scoop_reg? defined but not used

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 arch/arm/common/scoop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 37bda5f..9012004 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -140,6 +140,7 @@ EXPORT_SYMBOL(reset_scoop);
 EXPORT_SYMBOL(read_scoop_reg);
 EXPORT_SYMBOL(write_scoop_reg);
 
+#ifdef CONFIG_PM
 static void check_scoop_reg(struct scoop_dev *sdev)
 {
 	unsigned short mcr;
@@ -149,7 +150,6 @@ static void check_scoop_reg(struct scoop_dev *sdev)
 		iowrite16(0x0101, sdev->base + SCOOP_MCR);
 }
 
-#ifdef CONFIG_PM
 static int scoop_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct scoop_dev *sdev = platform_get_drvdata(dev);
-- 
1.6.6.2

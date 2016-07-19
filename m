From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 19 Jul 2016 20:32:50 +0900
Subject: [PATCH] usb: ehci-platform: switch over to shared reset
Message-ID: <1468927970-32240-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent update in the reset subsystem requires all reset consumers
to be explicit when requesting reset lines.  For detail, see the log
of commit 3c35f6edc09b ("reset: Reorder inline reset_control_get*()
wrappers").

The devm_reset_control_get_optional() is deprecated, and falls into
the _exclusive variant during the migration, but the reset control
in this driver is apparently shared-tolerate.  Besides, this driver
is for generic platforms, so actually should be able to work with a
shared reset line.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/usb/host/ehci-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 1757ebb..2f5a16c 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -234,7 +234,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 		}
 	}
 
-	priv->rst = devm_reset_control_get_optional(&dev->dev, NULL);
+	priv->rst = devm_reset_control_get_optional_shared(&dev->dev, NULL);
 	if (IS_ERR(priv->rst)) {
 		err = PTR_ERR(priv->rst);
 		if (err == -EPROBE_DEFER)
-- 
1.9.1

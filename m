From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:57:32 +0100
Subject: [PATCH] pcmcia: badge4: avoid unused function warning
Message-ID: <1453737465-1960022-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcmv_setup is only used when the badge4 driver is built-in, but
not when it is a loadable module:

drivers/pcmcia/sa1111_badge4.c:153:122: error: 'pcmv_setup' defined but not used [-Werror=unused-function]

This adds an #ifdef to avoid the definition of the unused function
in the modular case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/sa1111_badge4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/sa1111_badge4.c b/drivers/pcmcia/sa1111_badge4.c
index 12f0dd091477..a57dc1042ba0 100644
--- a/drivers/pcmcia/sa1111_badge4.c
+++ b/drivers/pcmcia/sa1111_badge4.c
@@ -150,6 +150,7 @@ int pcmcia_badge4_init(struct sa1111_dev *dev)
 	return ret;
 }
 
+#ifndef MODULE
 static int __init pcmv_setup(char *s)
 {
 	int v[4];
@@ -164,3 +165,4 @@ static int __init pcmv_setup(char *s)
 }
 
 __setup("pcmv=", pcmv_setup);
+#endif
-- 
2.7.0

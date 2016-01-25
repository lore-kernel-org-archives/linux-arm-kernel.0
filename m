From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 18:07:32 +0100
Subject: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized variable access
Message-ID: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc warns about the possibilty of accessing a property read from
devicetree in cs35l32_i2c_probe() when it has not been initialized
because CONFIG_OF is disabled:

sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

The code is actually correct because it checks the dev->of_node
variable first and we know this is NULL here, but by adding a
check for IS_ENABLED(CONFIG_OF), we can let the compiler know
as well, and also generate smaller object code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cs35l32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 44c30fe3e315..52ffaa8eb02b 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -372,7 +372,7 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 			dev_err(&i2c_client->dev, "could not allocate pdata\n");
 			return -ENOMEM;
 		}
-		if (i2c_client->dev.of_node) {
+		if (IS_ENABLED(CONFIG_OF) && i2c_client->dev.of_node) {
 			ret = cs35l32_handle_of_data(i2c_client,
 						     &cs35l32->pdata);
 			if (ret != 0)
-- 
2.7.0

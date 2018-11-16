From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 16 Nov 2018 17:23:53 +0100
Subject: [PATCH v2 07/17] Platform: OLPC: Avoid a warning if the EC didn't
 register yet
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Message-ID: <20181116162403.49854-8-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just return ENODEV, so that whoever attempted to use the EC call can
defer their work.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- EPROBE_DEFER instead of ENODEV

 drivers/platform/olpc/olpc-ec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 35a21c66cd0d..9ee993d5d54b 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
 	struct olpc_ec_priv *ec = ec_priv;
 	struct ec_cmd_desc desc;
 
-	/* Ensure a driver and ec hook have been registered */
-	if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
+	/* Driver not yet registered. */
+	if (!ec_driver)
+		return -EPROBE_DEFER;
+
+	if (WARN_ON(!ec_driver->ec_cmd))
 		return -ENODEV;
 
 	if (!ec)
-- 
2.19.1

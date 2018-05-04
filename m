From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri,  4 May 2018 15:56:31 +0200
Subject: [PATCH net-next v2 01/13] net: phy: sfp: make the i2c-bus property
 really optional
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180504135643.23466-2-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SFF,SFP documentation is clear about making all the DT properties,
with the exception of the compatible, optional. In practice this is not
the case and without an i2c-bus property provided the SFP code will
throw NULL pointer exceptions.

This patch is an attempt to fix this.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/sfp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4ab6e9a50bbe..4686c443fc22 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -298,11 +298,17 @@ static void sfp_set_state(struct sfp *sfp, unsigned int state)
 
 static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
 {
+	if (!sfp->read)
+		return -EOPNOTSUPP;
+
 	return sfp->read(sfp, a2, addr, buf, len);
 }
 
 static int sfp_write(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
 {
+	if (!sfp->write)
+		return -EOPNOTSUPP;
+
 	return sfp->write(sfp, a2, addr, buf, len);
 }
 
@@ -533,6 +539,8 @@ static int sfp_sm_mod_hpower(struct sfp *sfp)
 		return 0;
 
 	err = sfp_read(sfp, true, SFP_EXT_STATUS, &val, sizeof(val));
+	if (err == -EOPNOTSUPP)
+		goto err;
 	if (err != sizeof(val)) {
 		dev_err(sfp->dev, "Failed to read EEPROM: %d\n", err);
 		err = -EAGAIN;
@@ -542,6 +550,8 @@ static int sfp_sm_mod_hpower(struct sfp *sfp)
 	val |= BIT(0);
 
 	err = sfp_write(sfp, true, SFP_EXT_STATUS, &val, sizeof(val));
+	if (err == -EOPNOTSUPP)
+		goto err;
 	if (err != sizeof(val)) {
 		dev_err(sfp->dev, "Failed to write EEPROM: %d\n", err);
 		err = -EAGAIN;
@@ -565,6 +575,8 @@ static int sfp_sm_mod_probe(struct sfp *sfp)
 	int ret;
 
 	ret = sfp_read(sfp, false, 0, &id, sizeof(id));
+	if (ret == -EOPNOTSUPP)
+		return ret;
 	if (ret < 0) {
 		dev_err(sfp->dev, "failed to read EEPROM: %d\n", ret);
 		return -EAGAIN;
-- 
2.17.0

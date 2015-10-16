From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:30:59 +0200
Subject: [PATCH] [media] horus3a: fix horus3a_attach inline wrapper
Message-ID: <7188906.Hi9qi0FZQC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'static inline' version of horus3a_attach() is incorrectly
copied from another file, which results in a build error when
CONFIG_DVB_HORUS3A is disabled:

In file included from /git/arm-soc/drivers/media/pci/netup_unidvb/netup_unidvb_core.c:34:0:
media/dvb-frontends/horus3a.h:51:13: warning: 'struct cxd2820r_config' declared inside parameter list
media/dvb-frontends/horus3a.h:51:13: warning: its scope is only this definition or declaration, which is probably not what you want
media/pci/netup_unidvb/netup_unidvb_core.c: In function 'netup_unidvb_dvb_init':
media/pci/netup_unidvb/netup_unidvb_core.c:417:279: warning: passing argument 1 of '__a' from incompatible pointer type [-Wincompatible-pointer-types]
media/pci/netup_unidvb/netup_unidvb_core.c:417:279: note: expected 'const struct cxd2820r_config *' but argument is of type 'struct dvb_frontend *'
media/pci/netup_unidvb/netup_unidvb_core.c:417:298: warning: passing argument 2 of '__a' from incompatible pointer type [-Wincompatible-pointer-types]
media/pci/netup_unidvb/netup_unidvb_core.c:417:298: note: expected 'struct i2c_adapter *' but argument is of type 'struct horus3a_config *'
media/pci/netup_unidvb/netup_unidvb_core.c:417:275: error: too many arguments to function '__a'

This changes the code to have the correct prototype.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a5d32b358254 ("[media] horus3a: Sony Horus3A DVB-S/S2 tuner driver")
---
Found on ARM randconfig builds

diff --git a/drivers/media/dvb-frontends/horus3a.h b/drivers/media/dvb-frontends/horus3a.h
index b055319d532e..c1e2d1834b78 100644
--- a/drivers/media/dvb-frontends/horus3a.h
+++ b/drivers/media/dvb-frontends/horus3a.h
@@ -46,8 +46,8 @@ extern struct dvb_frontend *horus3a_attach(struct dvb_frontend *fe,
 					const struct horus3a_config *config,
 					struct i2c_adapter *i2c);
 #else
-static inline struct dvb_frontend *horus3a_attach(
-					const struct cxd2820r_config *config,
+static inline struct dvb_frontend *horus3a_attach(struct dvb_frontend *fe,
+					const struct horus3a_config *config,
 					struct i2c_adapter *i2c)
 {
 	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __func__);

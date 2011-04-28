From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 28 Apr 2011 23:15:45 +0800
Subject: [PATCH 2/3] i2c: pxa: support hardware lock
In-Reply-To: <2011042801>
References: <2011042801>
Message-ID: <1304003746-12127-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append hardware lock support since it's required by Marvell PXA910.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-pxa.c |    3 +++
 include/linux/i2c/pxa-i2c.h  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index cab529d..e9a5dd8 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1120,6 +1120,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	if (plat) {
 		i2c->adap.class = plat->class;
+		i2c->adap.hardware_lock = plat->hardware_lock;
+		i2c->adap.hardware_unlock = plat->hardware_unlock;
+		i2c->adap.hardware_trylock = plat->hardware_trylock;
 		i2c->use_pio = plat->use_pio;
 		i2c->fast_mode = plat->fast_mode;
 	}
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 1a9f65e..076324f 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -67,6 +67,9 @@ struct i2c_pxa_platform_data {
 	unsigned int		class;
 	unsigned int		use_pio :1;
 	unsigned int		fast_mode :1;
+	void			(*hardware_lock)(struct i2c_adapter *);
+	void			(*hardware_unlock)(struct i2c_adapter *);
+	int			(*hardware_trylock)(struct i2c_adapter *);
 };
 
 extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-- 
1.7.1

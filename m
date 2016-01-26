From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 15:09:58 +0100
Subject: [PATCH 4/7] [media] b2c2: flexcop: avoid unused function warnings
In-Reply-To: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
References: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
Message-ID: <1453817424-3080054-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flexcop driver has two functions that are normally used, except
when multiple frontend drivers are disabled:

drivers/media/common/b2c2/flexcop-fe-tuner.c:42:12: warning: 'flexcop_set_voltage' defined but not used [-Wunused-function]
drivers/media/common/b2c2/flexcop-fe-tuner.c:71:12: warning: 'flexcop_sleep' defined but not used [-Wunused-function]

This avoids the build warning by updating the #ifdef for flexcop_set_voltage
to the exact condition under which it is used. For flexcop_sleep, the
condition is rather complex, so I resort to marking it as __maybe_unused,
so the compiler can silently drop it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/common/b2c2/flexcop-fe-tuner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/b2c2/flexcop-fe-tuner.c b/drivers/media/common/b2c2/flexcop-fe-tuner.c
index 9c59f4306883..f5956402fc69 100644
--- a/drivers/media/common/b2c2/flexcop-fe-tuner.c
+++ b/drivers/media/common/b2c2/flexcop-fe-tuner.c
@@ -38,7 +38,7 @@ static int flexcop_fe_request_firmware(struct dvb_frontend *fe,
 #endif
 
 /* lnb control */
-#if FE_SUPPORTED(MT312) || FE_SUPPORTED(STV0299)
+#if (FE_SUPPORTED(MT312) || FE_SUPPORTED(STV0299)) && FE_SUPPORTED(PLL)
 static int flexcop_set_voltage(struct dvb_frontend *fe,
 			       enum fe_sec_voltage voltage)
 {
@@ -68,7 +68,7 @@ static int flexcop_set_voltage(struct dvb_frontend *fe,
 #endif
 
 #if FE_SUPPORTED(S5H1420) || FE_SUPPORTED(STV0299) || FE_SUPPORTED(MT312)
-static int flexcop_sleep(struct dvb_frontend* fe)
+static int __maybe_unused flexcop_sleep(struct dvb_frontend* fe)
 {
 	struct flexcop_device *fc = fe->dvb->priv;
 	if (fc->fe_sleep)
-- 
2.7.0

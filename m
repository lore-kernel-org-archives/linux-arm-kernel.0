From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 15:50:31 +0100
Subject: [PATCH] rtc: armada38x: hide maybe-uninitialized warning
Message-ID: <20170111145112.722743-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function is too complicated for gcc to realize that this variable
does eventually get initialized, causing a harmless warning:

drivers/rtc/rtc-armada38x.c: In function 'read_rtc_register_wa':
drivers/rtc/rtc-armada38x.c:131:25: warning: 'index_max' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds an explicit initializion at the start of the function.
I generally try to avoid that, but it seems appropriate here,
as we start out with max=0 as well.

Fixes: 61cffa2438e3 ("rtc: armada38x: Follow the new recommendation for errata implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-armada38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 6c9a2cbdc1a9..65e16965af7e 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -90,7 +90,7 @@ static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
 
 static u32 read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
 {
-	int i, index_max, max = 0;
+	int i, index_max = 0, max = 0;
 
 	for (i = 0; i < SAMPLE_NR; i++) {
 		rtc->val_to_freq[i].value = readl(rtc->regs + rtc_reg);
-- 
2.9.0

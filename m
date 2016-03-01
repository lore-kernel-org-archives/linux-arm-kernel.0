From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  1 Mar 2016 17:59:59 +0100
Subject: [PATCH 3/6] powerpc: rtc: provide rtc_class_ops directly
In-Reply-To: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
Message-ID: <1456851608-3374907-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rtc-generic driver provides an architecture specific
wrapper on top of the generic rtc_class_ops abstraction,
and powerpc has another abstraction on top, which is a bit
silly.

This changes the powerpc rtc-generic device to provide its
rtc_class_ops directly, to reduce the number of layers
by one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/time.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 81b0900a39ee..84a1228be617 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1080,6 +1080,28 @@ void calibrate_delay(void)
 	loops_per_jiffy = tb_ticks_per_jiffy;
 }
 
+static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
+{
+	ppc_md.get_rtc_time(tm);
+	return rtc_valid_tm(tm);
+}
+
+static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
+{
+	if (!ppc_md.set_rtc_time)
+		return -EOPNOTSUPP;
+
+	if (ppc_md.set_rtc_time(tm) < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = rtc_generic_get_time,
+	.set_time = rtc_generic_set_time,
+};
+
 static int __init rtc_init(void)
 {
 	struct platform_device *pdev;
@@ -1087,7 +1109,9 @@ static int __init rtc_init(void)
 	if (!ppc_md.get_rtc_time)
 		return -ENODEV;
 
-	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
-- 
2.7.0

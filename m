From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 24 Nov 2010 11:54:18 +0800
Subject: [PATCH 1/8] ARM: pxa: append missing class register for clock sysdev
Message-ID: <1290570865-7577-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/clock-pxa2xx.c |    8 ++++++++
 arch/arm/mach-pxa/clock-pxa3xx.c |   10 ++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/clock-pxa2xx.c b/arch/arm/mach-pxa/clock-pxa2xx.c
index 66eb531..1ce0904 100644
--- a/arch/arm/mach-pxa/clock-pxa2xx.c
+++ b/arch/arm/mach-pxa/clock-pxa2xx.c
@@ -54,3 +54,11 @@ struct sysdev_class pxa2xx_clock_sysclass = {
 	.suspend	= pxa2xx_clock_suspend,
 	.resume		= pxa2xx_clock_resume,
 };
+
+static int __init pxa2xx_clock_init(void)
+{
+	if (cpu_is_pxa2xx())
+		return sysdev_class_register(&pxa2xx_clock_sysclass);
+	return 0;
+}
+postcore_initcall(pxa2xx_clock_init);
diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
index 16b4c5f..dd122d9 100644
--- a/arch/arm/mach-pxa/clock-pxa3xx.c
+++ b/arch/arm/mach-pxa/clock-pxa3xx.c
@@ -169,6 +169,7 @@ static int pxa3xx_clock_suspend(struct sys_device *d, pm_message_t state)
 	cken[0] = CKENA;
 	cken[1] = CKENB;
 	accr = ACCR;
+	return 0;
 }
 
 static int pxa3xx_clock_resume(struct sys_device *d)
@@ -176,6 +177,7 @@ static int pxa3xx_clock_resume(struct sys_device *d)
 	ACCR = accr;
 	CKENA = cken[0];
 	CKENB = cken[1];
+	return 0;
 }
 #else
 #define pxa3xx_clock_suspend	NULL
@@ -187,3 +189,11 @@ struct sysdev_class pxa3xx_clock_sysclass = {
 	.suspend	= pxa3xx_clock_suspend,
 	.resume		= pxa3xx_clock_resume,
 };
+
+static int __init pxa3xx_clock_init(void)
+{
+	if (cpu_is_pxa3xx())
+		return sysdev_class_register(&pxa3xx_clock_sysclass);
+	return 0;
+}
+postcore_initcall(pxa3xx_clock_init);
-- 
1.5.6.5

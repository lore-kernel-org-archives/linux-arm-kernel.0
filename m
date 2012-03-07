From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 7 Mar 2012 15:57:53 +0530
Subject: [PATCH 12/15] watchdog/mpcore_wdt: Add support for WDIOF_CARDRESET
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
Message-ID: <cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mpcore watchdog can give last boot status, whether we got a watchdog reset or
not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to return
correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/smp_twd.h |    2 ++
 drivers/watchdog/mpcore_wdt.c  |   10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index ef9ffba9..a13b536 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -18,6 +18,8 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
+#define TWD_WDOG_RESETSTAT_MASK		0x1
+
 struct clock_event_device;
 
 extern void __iomem *twd_base;
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 27a5069..6a04e31 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -36,6 +36,7 @@
 
 struct mpcore_wdt {
 	unsigned long	timer_alive;
+	unsigned long	boot_status;
 	struct device	*dev;
 	void __iomem	*base;
 	int		irq;
@@ -210,6 +211,7 @@ static ssize_t mpcore_wdt_write(struct file *file, const char *data,
 static const struct watchdog_info ident = {
 	.options		= WDIOF_SETTIMEOUT |
 				  WDIOF_KEEPALIVEPING |
+				  WDIOF_CARDRESET |
 				  WDIOF_MAGICCLOSE,
 	.identity		= "MPcore Watchdog",
 };
@@ -239,10 +241,13 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
 		uarg.i = 0;
 		break;
 
+	case WDIOC_GETBOOTSTATUS:
+		uarg.i = wdt->boot_status;
+		break;
+
 	case WDIOC_SETOPTIONS:
 		if (uarg.i & WDIOS_DISABLECARD)
 			mpcore_wdt_stop(wdt);
@@ -366,6 +371,9 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
+			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
+
 	mpcore_wdt_stop(wdt);
 	platform_set_drvdata(pdev, wdt);
 	mpcore_wdt_pdev = pdev;
-- 
1.7.8.110.g4cb5d

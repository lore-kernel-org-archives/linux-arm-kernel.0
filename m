From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 23 Sep 2014 11:38:42 +0200
Subject: [PATCH v7 02/10] rtc: at91sam9: use standard readl/writel functions
 instead of raw versions
In-Reply-To: <1411465130-29011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411465130-29011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1411465130-29011-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Raw versions of writel and writel should not be directly used and should
be replaced by their relaxed versions (readl/writel_relaxed), which take
endianness conversion into account.

In this driver we prefer the standard readl/writel function which add the
appropriate memory barrier around the access (the performance penalty is
negligible for this kind of application).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/rtc/rtc-at91sam9.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 51f0038..74a9ca0 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -77,14 +77,14 @@ struct sam9_rtc {
 };
 
 #define rtt_readl(rtc, field) \
-	__raw_readl((rtc)->rtt + AT91_RTT_ ## field)
+	readl((rtc)->rtt + AT91_RTT_ ## field)
 #define rtt_writel(rtc, field, val) \
-	__raw_writel((val), (rtc)->rtt + AT91_RTT_ ## field)
+	writel((val), (rtc)->rtt + AT91_RTT_ ## field)
 
 #define gpbr_readl(rtc) \
-	__raw_readl((rtc)->gpbr)
+	readl((rtc)->gpbr)
 #define gpbr_writel(rtc, val) \
-	__raw_writel((val), (rtc)->gpbr)
+	writel((val), (rtc)->gpbr)
 
 /*
  * Read current time and date in RTC
-- 
1.9.1

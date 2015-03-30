From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:17:09 +0200
Subject: [PATCH 07/11] clocksource: at91: Make IO endian agnostic
In-Reply-To: <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
References: <5519AEB2.8050306@linaro.org>
 <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427746633-9137-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Fix the use of __raw IO accessor with the readl/writel_relaxed versions
to allow the code to be used on a system running in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clocksource/timer-atmel-pit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index b5b4d45..c0304ff 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -61,12 +61,12 @@ static inline struct pit_data *clkevt_to_pit_data(struct clock_event_device *clk
 
 static inline unsigned int pit_read(void __iomem *base, unsigned int reg_offset)
 {
-	return __raw_readl(base + reg_offset);
+	return readl_relaxed(base + reg_offset);
 }
 
 static inline void pit_write(void __iomem *base, unsigned int reg_offset, unsigned long value)
 {
-	__raw_writel(value, base + reg_offset);
+	writel_relaxed(value, base + reg_offset);
 }
 
 /*
-- 
1.9.1

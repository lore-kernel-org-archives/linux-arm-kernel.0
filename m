From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:31 +0900
Subject: [PATCH 05/12] clocksource: sh_cmt: CMSTR and CMCSR register access
 update
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update hardware register access code for CMSTR and CMCSR
from using sh_cmt_read() and sh_cmt_write() to make use
of 16-bit register access functions such as sh_cmt_read16()
and sh_cmt_write16(). Also update sh_cmt_read() and
sh_cmt_write() now when the special cases are gone.

This patch moves us one step closer to the goal of separating
counter register access functions from control control register
functions.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: John Stultz <john.stultz@linaro.org>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |   66 +++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index a2f8023..eefacc3 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -56,44 +56,46 @@ struct sh_cmt_priv {
 	bool cs_enabled;
 };
 
-static DEFINE_RAW_SPINLOCK(sh_cmt_lock);
+static inline unsigned long sh_cmt_read16(void __iomem *base,
+					  unsigned long offs)
+{
+	return ioread16(base + (offs << 1));
+}
+
+static inline void sh_cmt_write16(void __iomem *base, unsigned long offs,
+				  unsigned long value)
+{
+	iowrite16(value, base + (offs << 1));
+}
 
-#define CMSTR -1 /* shared register */
 #define CMCSR 0 /* channel register */
 #define CMCNT 1 /* channel register */
 #define CMCOR 2 /* channel register */
 
 static inline unsigned long sh_cmt_read(struct sh_cmt_priv *p, int reg_nr)
 {
-	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 	void __iomem *base = p->mapbase;
-	unsigned long offs;
-
-	if (reg_nr == CMSTR) {
-		offs = 0;
-		base -= cfg->channel_offset;
-	} else
-		offs = reg_nr;
+	unsigned long offs = reg_nr;
 
-	if (p->width == 16)
+	if (p->width == 16) {
 		offs <<= 1;
-	else {
+		return ioread16(base + offs);
+	} else {
 		offs <<= 2;
-		if ((reg_nr == CMCNT) || (reg_nr == CMCOR))
-			return ioread32(base + offs);
+		return ioread32(base + offs);
 	}
-
-	return ioread16(base + offs);
 }
 
 static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_priv *p)
 {
-	return sh_cmt_read(p, CMSTR);
+	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
+
+	return sh_cmt_read16(p->mapbase - cfg->channel_offset, 0);
 }
 
 static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_priv *p)
 {
-	return sh_cmt_read(p, CMCSR);
+	return sh_cmt_read16(p->mapbase, CMCSR);
 }
 
 static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_priv *p)
@@ -104,39 +106,30 @@ static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_priv *p)
 static inline void sh_cmt_write(struct sh_cmt_priv *p, int reg_nr,
 				unsigned long value)
 {
-	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 	void __iomem *base = p->mapbase;
-	unsigned long offs;
+	unsigned long offs = reg_nr;
 
-	if (reg_nr == CMSTR) {
-		offs = 0;
-		base -= cfg->channel_offset;
-	} else
-		offs = reg_nr;
-
-	if (p->width == 16)
+	if (p->width == 16) {
 		offs <<= 1;
-	else {
+		iowrite16(value, base + offs);
+	} else {
 		offs <<= 2;
-		if ((reg_nr == CMCNT) || (reg_nr == CMCOR)) {
-			iowrite32(value, base + offs);
-			return;
-		}
+		iowrite32(value, base + offs);
 	}
-
-	iowrite16(value, base + offs);
 }
 
 static inline void sh_cmt_write_cmstr(struct sh_cmt_priv *p,
 				      unsigned long value)
 {
-	sh_cmt_write(p, CMSTR, value);
+	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
+
+	sh_cmt_write16(p->mapbase - cfg->channel_offset, 0, value);
 }
 
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_priv *p,
 				      unsigned long value)
 {
-	sh_cmt_write(p, CMCSR, value);
+	sh_cmt_write16(p->mapbase, CMCSR, value);
 }
 
 static inline void sh_cmt_write_cmcnt(struct sh_cmt_priv *p,
@@ -173,6 +166,7 @@ static unsigned long sh_cmt_get_counter(struct sh_cmt_priv *p,
 	return v2;
 }
 
+static DEFINE_RAW_SPINLOCK(sh_cmt_lock);
 
 static void sh_cmt_start_stop_ch(struct sh_cmt_priv *p, int start)
 {
-- 
1.7.10.4

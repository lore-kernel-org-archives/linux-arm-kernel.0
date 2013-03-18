From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:33 +0900
Subject: [PATCH 07/12] clocksource: sh_cmt: Add control register callbacks
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This patch adds control register callbacks for the CMT
driver. At this point only 16-bit access is supported
but in the future this will be updated to allow 32-bit
access as well.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: John Stultz <john.stultz@linaro.org>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index da904d7..7108963 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -55,6 +55,11 @@ struct sh_cmt_priv {
 	unsigned long total_cycles;
 	bool cs_enabled;
 
+	/* callbacks for CMSTR and CMCSR access */
+	unsigned long (*read_control)(void __iomem *base, unsigned long offs);
+	void (*write_control)(void __iomem *base, unsigned long offs,
+			      unsigned long value);
+
 	/* callbacks for CMCNT and CMCOR access */
 	unsigned long (*read_count)(void __iomem *base, unsigned long offs);
 	void (*write_count)(void __iomem *base, unsigned long offs,
@@ -91,12 +96,12 @@ static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_priv *p)
 {
 	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 
-	return sh_cmt_read16(p->mapbase - cfg->channel_offset, 0);
+	return p->read_control(p->mapbase - cfg->channel_offset, 0);
 }
 
 static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_priv *p)
 {
-	return sh_cmt_read16(p->mapbase, CMCSR);
+	return p->read_control(p->mapbase, CMCSR);
 }
 
 static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_priv *p)
@@ -109,13 +114,13 @@ static inline void sh_cmt_write_cmstr(struct sh_cmt_priv *p,
 {
 	struct sh_timer_config *cfg = p->pdev->dev.platform_data;
 
-	sh_cmt_write16(p->mapbase - cfg->channel_offset, 0, value);
+	p->write_control(p->mapbase - cfg->channel_offset, 0, value);
 }
 
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_priv *p,
 				      unsigned long value)
 {
-	sh_cmt_write16(p->mapbase, CMCSR, value);
+	p->write_control(p->mapbase, CMCSR, value);
 }
 
 static inline void sh_cmt_write_cmcnt(struct sh_cmt_priv *p,
@@ -702,6 +707,9 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		goto err1;
 	}
 
+	p->read_control = sh_cmt_read16;
+	p->write_control = sh_cmt_write16;
+
 	if (resource_size(res) == 6) {
 		p->width = 16;
 		p->read_count = sh_cmt_read16;
-- 
1.7.10.4

From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Feb 2014 01:59:43 +0100
Subject: [PATCH 05/27] clocksource: sh_cmt: Add memory base to sh_cmt_channel
 structure
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392339605-20691-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The channel memory base is channel-specific, add it to the channel
structure in preparation for support of multiple channels per device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 1ac84ff..ec10cf4 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -40,6 +40,7 @@ struct sh_cmt_device;
 struct sh_cmt_channel {
 	struct sh_cmt_device *cmt;
 
+	void __iomem *base;
 	struct irqaction irqaction;
 
 	unsigned long flags;
@@ -132,12 +133,12 @@ static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_channel *ch)
 
 static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_channel *ch)
 {
-	return ch->cmt->read_control(ch->cmt->mapbase_ch, CMCSR);
+	return ch->cmt->read_control(ch->base, CMCSR);
 }
 
 static inline unsigned long sh_cmt_read_cmcnt(struct sh_cmt_channel *ch)
 {
-	return ch->cmt->read_count(ch->cmt->mapbase_ch, CMCNT);
+	return ch->cmt->read_count(ch->base, CMCNT);
 }
 
 static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
@@ -149,19 +150,19 @@ static inline void sh_cmt_write_cmstr(struct sh_cmt_channel *ch,
 static inline void sh_cmt_write_cmcsr(struct sh_cmt_channel *ch,
 				      unsigned long value)
 {
-	ch->cmt->write_control(ch->cmt->mapbase_ch, CMCSR, value);
+	ch->cmt->write_control(ch->base, CMCSR, value);
 }
 
 static inline void sh_cmt_write_cmcnt(struct sh_cmt_channel *ch,
 				      unsigned long value)
 {
-	ch->cmt->write_count(ch->cmt->mapbase_ch, CMCNT, value);
+	ch->cmt->write_count(ch->base, CMCNT, value);
 }
 
 static inline void sh_cmt_write_cmcor(struct sh_cmt_channel *ch,
 				      unsigned long value)
 {
-	ch->cmt->write_count(ch->cmt->mapbase_ch, CMCOR, value);
+	ch->cmt->write_count(ch->base, CMCOR, value);
 }
 
 static unsigned long sh_cmt_get_counter(struct sh_cmt_channel *ch,
@@ -704,6 +705,7 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch,
 
 	memset(ch, 0, sizeof(*ch));
 	ch->cmt = cmt;
+	ch->base = cmt->mapbase_ch;
 
 	/* Request irq using setup_irq() (too early for request_irq()). */
 	irq = platform_get_irq(cmt->pdev, 0);
-- 
1.8.3.2

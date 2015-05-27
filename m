From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 27 May 2015 18:40:37 +0100
Subject: [PATCH 1/5] ARM: l2c: restore the behaviour documented above
 l2c_enable()
In-Reply-To: <1432731613.2781.13.camel@collabora.co.uk>
References: <1432731613.2781.13.camel@collabora.co.uk>
Message-ID: <E1YxfJl-00047U-IZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

l2c_enable() is documented that it must not be called if the cache has
already been enabled.  Unfortunately, commit 6b49241ac252 ("ARM: 8259/1:
l2c: Refactor the driver to use commit-like interface") changed this
without updating the comment, for very little reason.  Revert this
change and restore the expected behaviour.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e309c8f35af5..1471c0f29bd3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -129,10 +129,6 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
 	unsigned long flags;
 
-	/* Do not touch the controller if already enabled. */
-	if (readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN)
-		return;
-
 	l2x0_saved_regs.aux_ctrl = aux;
 	l2c_configure(base);
 
@@ -163,7 +159,11 @@ static void l2c_save(void __iomem *base)
 
 static void l2c_resume(void)
 {
-	l2c_enable(l2x0_base, l2x0_saved_regs.aux_ctrl, l2x0_data->num_lock);
+	void __iomem *base = l2x0_base;
+
+	/* Do not touch the controller if already enabled. */
+	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN))
+		l2c_enable(base, l2x0_saved_regs.aux_ctrl, l2x0_data->num_lock);
 }
 
 /*
-- 
2.1.0

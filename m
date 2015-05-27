From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 27 May 2015 18:40:42 +0100
Subject: [PATCH 2/5] ARM: l2c: write auxiliary control register first
In-Reply-To: <1432731613.2781.13.camel@collabora.co.uk>
References: <1432731613.2781.13.camel@collabora.co.uk>
Message-ID: <E1YxfJq-00047a-OR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before calling the controller specific configuration function, write
the auxiliary control register first, so that bits shared with other
registers (such as the prefetch control register) are not overwritten
by the later write to the auxctrl register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 1471c0f29bd3..977eb9f4f77e 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -115,10 +115,10 @@ static void l2c_configure(void __iomem *base)
 		return;
 	}
 
+	l2c_write_sec(l2x0_saved_regs.aux_ctrl, base, L2X0_AUX_CTRL);
+
 	if (l2x0_data->configure)
 		l2x0_data->configure(base);
-
-	l2c_write_sec(l2x0_saved_regs.aux_ctrl, base, L2X0_AUX_CTRL);
 }
 
 /*
-- 
2.1.0

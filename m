From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Sep 2011 14:48:23 -0700
Subject: [PATCH 4/4] ARM: OMAP: irq: loop counter fix in omap_init_irq()
In-Reply-To: <20110928214707.29263.58095.stgit@kaulin.local>
References: <20110928214707.29263.58095.stgit@kaulin.local>
Message-ID: <20110928214823.29263.53645.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tapani Utriainen <tapani@technexion.com>

Fixes bug where variable i was redundantly used for counting two nested loops.

Signed-off-by: Tapani Utriainen <tapani@technexion.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 3a12f75..65f1be6 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -165,8 +165,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
 
 		omap_irq_bank_init_one(bank);
 
-		for (i = 0, j = 0; i < bank->nr_irqs; i += 32, j += 0x20)
-			omap_alloc_gc(bank->base_reg + j, i, 32);
+		for (j = 0; j < bank->nr_irqs; j += 32)
+			omap_alloc_gc(bank->base_reg + j, j, 32);
 
 		nr_of_irqs += bank->nr_irqs;
 		nr_banks++;

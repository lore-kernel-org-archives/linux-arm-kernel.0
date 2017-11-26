From: peng.fan@nxp.com (Peng Fan)
Date: Sun, 26 Nov 2017 20:25:30 +0800
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
Message-ID: <20171126122530.857-1-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To boot Linux in Non-secure mode with l2x0, the l2x0 controller
is enabled in secure mode and ways locked to make it seems L2 cache
disabled during linux boot process. So during l2x0 initialization,
need to unlock the ways to make l2x0 could cache data/inst.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Brandt <chris.brandt@renesas.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-l2x0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 808efbb89b88..de8eed0871ec 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -879,6 +879,10 @@ static int __init __l2c_init(const struct l2c_init_data *data,
 		l2x0_saved_regs.aux_ctrl = aux;
 
 		data->enable(l2x0_base, data->num_lock);
+	} else {
+		pr_info("%s: unlock cache controller\n", data->type);
+
+		data->unlock(l2x0_base, data->num_lock);
 	}
 
 	outer_cache = fns;
-- 
2.14.1

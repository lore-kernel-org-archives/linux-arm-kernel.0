From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 31 May 2017 17:59:26 +0100
Subject: [PATCH v5 2/7] arm: fix return value of parse_cpu_capacity
In-Reply-To: <20170531165931.6945-1-juri.lelli@arm.com>
References: <20170531165931.6945-1-juri.lelli@arm.com>
Message-ID: <20170531165931.6945-3-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

parse_cpu_capacity() has to return 0 on failure, but it currently returns
1 instead if raw_capacity kcalloc failed.

Fix it (by directly returning 0).

Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Morten Rasmussen <morten.rasmussen@arm.com>
Fixes: 06073ee26775 ('ARM: 8621/3: parse cpu capacity-dmips-mhz from DT')
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Vincent Guittot <vincent.guittot@linaor.org>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index f8a3ab82e77f..1b8ec3054642 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -166,7 +166,7 @@ static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			if (!raw_capacity) {
 				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
 				cap_parsing_failed = true;
-				return !ret;
+				return 0;
 			}
 		}
 		capacity_scale = max(cpu_capacity, capacity_scale);
-- 
2.11.0

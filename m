From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Tue, 24 Oct 2017 11:27:18 +0100
Subject: [PATCH v3 2/2] arm: topology: add missing of_node_put() for cpu
 device node
In-Reply-To: <20171024102718.16113-1-dietmar.eggemann@arm.com>
References: <20171024102718.16113-1-dietmar.eggemann@arm.com>
Message-ID: <20171024102718.16113-3-dietmar.eggemann@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing of_node_put() for of_find_node_by_path() and
of_get_cpu_node() in parse_dt_topology().

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@gmail.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 15cc131ae387..81ec42333489 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -41,6 +41,7 @@ static void __init parse_dt_topology(void)
 		pr_err("No CPU information found in DT\n");
 		return;
 	}
+	of_node_put(cn);
 
 	for_each_possible_cpu(cpu) {
 		/* too early to use cpu->of_node */
@@ -50,8 +51,8 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
-		if (topology_parse_cpu_capacity(cn, cpu))
-			of_node_put(cn);
+		topology_parse_cpu_capacity(cn, cpu);
+		of_node_put(cn);
 	}
 
 	topology_normalize_cpu_scale();
-- 
2.11.0

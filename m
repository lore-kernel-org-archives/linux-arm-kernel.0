From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 18 Feb 2013 17:07:47 +0530
Subject: [PATCH, RFC 2/8] ARM: twd: register clock event for 1 core SMP
In-Reply-To: <cover.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
Message-ID: <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register percpu local timer for scheduler tick in the case of one core
SMP configuration. In other cases - secondary cpu's as well as boot
cpu's having more than one core, this is being registered as per
existing boot flow, with a difference that they happens after delay
calibration. Registering the clock for tick in case of one core should
be done before Kernel calibrates delay (this is required to boot,
unless local timer is the only one registered for tick). Registering
twd local timer at init_time (which platforms are doing now) helps
achieve that with the proposed change.

This helps in an almost booting Kernel (minimal) by only relying on
ARM parts for an A9 one core SMP.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/kernel/smp_twd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 616268c..118f4f2 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -335,6 +335,9 @@ static int __init twd_local_timer_common_register(struct device_node *np)
 
 	twd_get_clock(np);
 
+	if (num_possible_cpus() == 1)
+		twd_timer_setup(evt);
+
 	return 0;
 
 out_irq:
-- 
1.7.12

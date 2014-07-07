From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jul 2014 16:51:37 +0200
Subject: [PATCHv2 3/8] ARM: mvebu: ensure CPU clocks are enabled
In-Reply-To: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404744702-32010-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the Armada XP SMP support code, we are reading the clock frequency
of the booting CPU, and use that to assign the same frequency to the
other CPUs, and we do this while the clocks are disabled.

However, the CPU clocks are in fact never prepared/enabled, and to
support cpufreq, we now have two code paths to change the frequency of
the CPU clocks in the CPU clock driver: one when the clock is enabled
(dynamic frequency scaling), one when the clock is disabled (adjusting
the CPU frequency before starting the CPU). In order for this to work,
the CPU clocks now have to be prepared and enabled after the initial
synchronization of the clock frequencies is done, so that all future
rate changes of the CPU clocks will trigger a dynamic frequency
scaling transition.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 88b976b3..4880b0f 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -67,6 +67,7 @@ static void __init set_secondary_cpus_clock(void)
 		if (!cpu_clk)
 			return;
 		clk_set_rate(cpu_clk, rate);
+		clk_prepare_enable(cpu_clk);
 	}
 }
 
-- 
2.0.0

From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 15 Jan 2014 21:26:13 +0900
Subject: [PATCH 03/04] ARM: shmobile: r8a7790 CA15-SCU enablement
In-Reply-To: <20140115122539.9437.63968.sendpatchset@w520>
References: <20140115122539.9437.63968.sendpatchset@w520>
Message-ID: <20140115122613.9437.11213.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Power on CA15 SCU in case of booting from a CA7 core.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
[damm at opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7790.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0004/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-01-15 14:41:47.000000000 +0900
@@ -29,6 +29,11 @@
 #define CA7RESCNT	0x0044
 #define MERAM		0xe8080000
 
+static struct rcar_sysc_ch r8a7790_ca15_scu = {
+	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
+	.isr_bit = 12, /* CA15-SCU */
+};
+
 static struct rcar_sysc_ch r8a7790_ca7_scu = {
 	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
 	.isr_bit = 21, /* CA7-SCU */
@@ -64,6 +69,7 @@ static void __init r8a7790_smp_prepare_c
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
+	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
 

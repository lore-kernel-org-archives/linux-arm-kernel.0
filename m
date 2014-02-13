From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:13:54 +0900
Subject: [PATCH 05/12] ARM: shmobile: r8a7790 CA15-SCU enablement
In-Reply-To: <cover.1392277789.git.horms+renesas@verge.net.au>
References: <cover.1392277789.git.horms+renesas@verge.net.au>
Message-ID: <f5046cf88c3232492d776a86262f0ba0b192e575.1392278855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Power on CA15 SCU in case of booting from a CA7 core.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
[damm at opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index beb47ae..5910527 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
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
@@ -64,6 +69,7 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
+	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
 
-- 
1.8.5.2

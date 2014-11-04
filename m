From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:57 +0900
Subject: [PATCH 09/11] ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm
 domain support
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <1618a677046b0391621708734f56886233210047.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the A4R power domain, and hook up the A3RV subdomain,
and the CEU0, TMU0, and IIC0 hardware blocks.
This domain also contains the Realtime CPU (SH-4A), Realtime CPU debug
modules, H-UDI, RT-SHwy, INTCS, RT-HPB, VIO6C, JPU, RTDMAC1/2, SSP,
MSIOF0, CMT0, ICB, DREQPAK (RT), 2DDMAC, IPMMUI, and 2DG hardware
blocks, but these are currently not used by any driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 arch/arm/mach-shmobile/pm-r8a7740.c            | 4 ++++
 arch/arm/mach-shmobile/setup-r8a7740.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e064443..25813da 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1236,6 +1236,7 @@ static void __init eva_init(void)
 		{ "A4LC", &hdmi_lcdc_device },
 		{ "A4MP", &hdmi_device },
 		{ "A4MP", &fsi_device },
+		{ "A4R",  &ceu0_device },
 		{ "A4S",  &sh_eth_device },
 		{ "A3SP", &pwm_device },
 		{ "A3SP", &sdhi0_device },
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 8b1af2a..74e6a67 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -55,6 +55,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.gov		= &pm_domain_always_on_gov,
 		.suspend	= r8a7740_pd_d4_suspend,
 	}, {
+		.genpd.name	= "A4R",
+		.bit_shift	= 5,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
@@ -78,6 +81,7 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 void __init r8a7740_init_pm_domains(void)
 {
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
+	pm_genpd_add_subdomain_names("A4R", "A3RV");
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 	pm_genpd_add_subdomain_names("A4S", "A3SG");
 }
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index dbf8a93..b77c226 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -746,6 +746,8 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 void __init r8a7740_add_standard_devices(void)
 {
 	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4R",  &tmu0_device },
+		{ "A4R",  &i2c0_device },
 		{ "A4S",  &irqpin0_device },
 		{ "A4S",  &irqpin1_device },
 		{ "A4S",  &irqpin2_device },
-- 
2.1.1

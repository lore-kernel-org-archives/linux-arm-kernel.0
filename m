From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 31 Oct 2012 04:43:12 -0600
Subject: [PATCH 1/4] ARM: OMAP2+: clockdomain: Fix OMAP4 ISS clk domain to
 support only SWSUP
In-Reply-To: <20121031103607.6557.64591.stgit@dusk.lan>
References: <20121031103607.6557.64591.stgit@dusk.lan>
Message-ID: <20121031104309.6557.72704.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miguel Vadillo <vadillo@ti.com>

Since CAM domain (ISS) has no module wake-up dependency
with any other clock domain of the device and the dynamic
dependency from L3_main_2 is always disabled, the domain
needs to be in force wakeup in order to be able to access
it for configure (sysconfig) it or use it.

Also since there is no clock in the domain managed automatically
by the hardware, there is no use to configure automatic
clock domain transition. SW should keep the SW_WKUP domain
transition as long as a module in the domain is required to
be functional.

Signed-off-by: Miguel Vadillo <vadillo@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index b56d06b..95192a0 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -359,7 +359,7 @@ static struct clockdomain iss_44xx_clkdm = {
 	.clkdm_offs	  = OMAP4430_CM2_CAM_CAM_CDOFFS,
 	.wkdep_srcs	  = iss_wkup_sleep_deps,
 	.sleepdep_srcs	  = iss_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain l3_dss_44xx_clkdm = {

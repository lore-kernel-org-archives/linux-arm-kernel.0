From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 1 Jul 2011 22:27:40 +0200
Subject: [PATCH v2 5/5] OMAP4: powerdomain data: Remove unsupported MPU
	powerdomain state
In-Reply-To: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
Message-ID: <1309552060-4547-6-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4430 devices, because of boot ROM code bug, MPU OFF state can't
be attempted independently. When coming out of MPU OFF state, ROM code
disables the clocks of IVAHD, TESLA which is not desirable. Hence the
MPU OFF state is not usable on OMAP4430 devices.

OMAP4460 onwards, MPU OFF state will be descoped completely because
the DDR firewall falls in MPU power domain. When the MPU hit OFF state,
DDR won't be accessible for other initiators. The deepest state supported
is open switch retention (OSWR) just like CORE and PER PD on OMAP4430.

So in summary MPU power domain OFF state is not supported on OMAP4
and onwards designs. Thanks to new PRCM design, device off mode can
still be achieved with power domains hitting OSWR state.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson at ti.com: Fix changelog typos]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 8f46e7d..247e794 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -205,7 +205,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
 	.pwrsts_mem_ret	= {
-- 
1.7.0.4

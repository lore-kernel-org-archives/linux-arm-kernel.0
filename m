From: nm@ti.com (Nishanth Menon)
Date: Wed,  2 Mar 2011 16:25:15 +0530
Subject: [PATCH v2 02/18] omap3+: voltage: remove initial voltage
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Message-ID: <1299063331-27968-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap2_set_init_voltage should setup the curr_volt based on which OPP
the system is functioning at. Blindly setting a 1.2v setting in the
initial structure may not even match the default voltages stored in
the voltage table which are supported for the domain.

For example, OMAP3430 core domain does not use 1.2v and ends up
generating a warning on the first transition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 12be525..280ee12 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -863,7 +863,6 @@ static int __init omap3_vdd_data_configure(struct omap_vdd_info *vdd)
 	sys_clk_speed /= 1000;
 
 	/* Generic voltage parameters */
-	vdd->curr_volt = 1200000;
 	vdd->ocp_mod = OCP_MOD;
 	vdd->prm_irqst_reg = OMAP3_PRM_IRQSTATUS_MPU_OFFSET;
 	vdd->read_reg = omap3_voltage_read_reg;
@@ -1054,7 +1053,6 @@ static int __init omap4_vdd_data_configure(struct omap_vdd_info *vdd)
 	sys_clk_speed /= 1000;
 
 	/* Generic voltage parameters */
-	vdd->curr_volt = 1200000;
 	vdd->ocp_mod = OMAP4430_PRM_OCP_SOCKET_INST;
 	vdd->read_reg = omap4_voltage_read_reg;
 	vdd->write_reg = omap4_voltage_write_reg;
-- 
1.7.1

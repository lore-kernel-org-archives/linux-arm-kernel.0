From: aalonso@freescale.com (Adrian Alonso)
Date: Fri, 18 Sep 2015 11:29:51 -0500
Subject: [PATCH v4 1/8] pinctrl: freescale: imx: fix system crash if enable
 two pinctl instances
Message-ID: <1442593798-11501-1-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Gong <b38343@freescale.com>

Fix system chrash caused by groups whose number is smaller than the number
of groups of the last pinctl instance which is not initialized.

iMX7D supports two iomux controllers (iomuxc-lpsr and iomuxc) on probing
the second instance (iomuxc) the chrash below occurs.

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.2.0-next-20150901-00006-gebfa43c (aalonso at bluefly)
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7)
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasin instruction cache
[    0.000000] Machine model: Freescale i.MX7 SabreSD Board
[    0.661012] [<802a6cb0>] (strcmp) from [<802cc80c>] (imx_dt_node_to_map+0x58/0x208)
[    0.668879] [<802cc80c>] (imx_dt_node_to_map) from [<802cbe24>] (pinctrl_dt_to_map+0x174/0x2b0)
[    0.677654] [<802cbe24>] (pinctrl_dt_to_map) from [<802c8f18>] (pinctrl_get+0x100/0x424)
[    0.685878] [<802c8f18>] (pinctrl_get) from [<802c9510>] (pinctrl_register+0x26c/0x480)
[    0.694104] [<802c9510>] (pinctrl_register) from [<802ccf3c>] (imx_pinctrl_probe+0x580/0x6e8)
[    0.702706] [<802ccf3c>] (imx_pinctrl_probe) from [<80351b58>] (platform_drv_probe+0x44/0xa4)
[    0.711455] [<80351b58>] (platform_drv_probe) from [<803503ec>] (driver_probe_device+0x174/0x2b4)
[    0.720405] [<803503ec>] (driver_probe_device) from [<803505fc>] (__driver_attach+0x8c/0x90)
[    0.728982] [<803505fc>] (__driver_attach) from [<8034e930>] (bus_for_each_dev+0x6c/0xa0)
[    0.737381] [<8034e930>] (bus_for_each_dev) from [<8034fb88>] (bus_add_driver+0x148/0x1f0)
[    0.745804] [<8034fb88>] (bus_add_driver) from [<80350c00>] (driver_register+0x78/0xf8)
[    0.753880] [<80350c00>] (driver_register) from [<800097d0>] (do_one_initcall+0x8c/0x1d4)
[    0.762282] [<800097d0>] (do_one_initcall) from [<80987dac>] (kernel_init_freeable+0x144/0x1e4)
[    0.771061] [<80987dac>] (kernel_init_freeable) from [<806d9c7c>] (kernel_init+0x8/0xe8)
[    0.779285] [<806d9c7c>] (kernel_init) from [<8000f628>] (ret_from_fork+0x14/0x2c)
[    0.786981] Code: e3520000 e5e32001 1afffffb e12fff1e (e4d03001)

Signed-off-by: Robin Gong <b38343@freescale.com>
Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Chages for V2:
- Reorder patch series
- Add platform boot up information on kernel error
- Move gpr_index to imx_pinctrl_soc_info
Changes for V3:
- Rename grp_index to group_index
Changes for V4: Resend

 drivers/pinctrl/freescale/pinctrl-imx.c | 3 +--
 drivers/pinctrl/freescale/pinctrl-imx.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index d7b98ba..b9c6deb 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -580,7 +580,6 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	struct device_node *child;
 	struct imx_pmx_func *func;
 	struct imx_pin_group *grp;
-	static u32 grp_index;
 	u32 i = 0;
 
 	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
@@ -599,7 +598,7 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 
 	for_each_child_of_node(np, child) {
 		func->groups[i] = child->name;
-		grp = &info->groups[grp_index++];
+		grp = &info->groups[info->group_index++];
 		imx_pinctrl_parse_groups(child, grp, info, i++);
 	}
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 49e55d3..2a5fe72 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -78,6 +78,7 @@ struct imx_pinctrl_soc_info {
 	struct imx_pin_reg *pin_regs;
 	struct imx_pin_group *groups;
 	unsigned int ngroups;
+	unsigned int group_index;
 	struct imx_pmx_func *functions;
 	unsigned int nfunctions;
 	unsigned int flags;
-- 
2.1.4

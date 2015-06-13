From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 Jun 2015 19:45:51 +0200 (CEST)
Subject: usb: phy: phy-mxs-usb: suspend to RAM causes NULL pointer dereference
Message-ID: <1882113151.65839.1434217551960.JavaMail.open-xchange@oxbsltgw09.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

triggering suspend to RAM via sysfs on a i.MX28 causes a NULL pointer
dereference. This
regression seems to be introduced with commit efdbd3a5d6e
("usb: phy: mxs: do not set PWD.RXPWD1PT1 for low speed connection"):

root at duckbill:/sys/power# echo mem > state
[   83.677575] PM: Syncing filesystems ... done.
[   83.872011] Freezing user space processes ... (elapsed 0.006 seconds) done.
[   83.886817] Freezing remaining freezable tasks ... (elapsed 0.003 seconds)
done.
[   83.909215] Unable to handle kernel NULL pointer dereference at virtual
address 0000017c
[   83.917520] pgd = c6d88000
[   83.920277] [0000017c] *pgd=46ed9831, *pte=00000000, *ppte=00000000
[   83.926795] Internal error: Oops: 17 [#1] ARM
[   83.931191] Modules linked in:
[   83.934306] CPU: 0 PID: 435 Comm: bash Not tainted
4.0.0-rc4-next-20150320-gb8f4f66-dirty #163
[   83.942940] Hardware name: Freescale MXS (Device Tree)
[   83.948102] task: c4954d00 ti: c6d20000 task.ti: c6d20000
[   83.953544] PC is at regmap_read+0x10/0x5c
[   83.957695] LR is at mxs_phy_get_vbus_status+0x40/0x58
[   83.962865] pc : [<c0350a10>]    lr : [<c03d8ac4>]    psr: 60000013
[   83.962865] sp : c6d21d20  ip : 00800000  fp : 00000002
[   83.974368] r10: c0340180  r9 : c07c15b0  r8 : 00000002
[   83.979615] r7 : c06c6ad4  r6 : 00000000  r5 : 000001c0  r4 : 00000000
[   83.986166] r3 : 00000000  r2 : c6d21d34  r1 : 000001c0  r0 : 000001c0
[   83.992718] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   83.999876] Control: 0005317f  Table: 46d88000  DAC: 00000015
[   84.005644] Process bash (pid: 435, stack limit = 0xc6d20190)
[   84.011413] Stack: (0xc6d21d20 to 0xc6d22000)
[   84.015813] 1d20: c7833f10 00000001 00000000 c03d8ac4 00000002 c00601c8
00001074 c03d8ca4
[   84.024030] 1d40: c0537268 60000013 c7a6bc10 c7aea010 c7a6bc10 00001074
c06c6ad4 c03d924c
[   84.032245] 1d60: c7aea010 c03d93dc c7a6bc10 c0fcf05c c07e165c c03401ac
c7a6bc10 c0348818
[   84.040459] 1d80: 00000000 c0051864 60000013 c07c15d0 00000000 c7a6bc10
c0fcf05c c7a6bc10
[   84.048674] 1da0: c0fcf05c c7a6bc44 00000002 00000000 c07c1564 c03494d0
c07c1590 00536bb0
[   84.056888] 1dc0: c7a6bc10 c0fcf05c 00000000 c07c1564 00000000 c0349c14
00000000 c07e1684
[   84.065102] 1de0: 8061885f 00000013 8061885f 00000013 00000000 c005dec4
00000000 00000002
[   84.073316] 1e00: c0f91cc0 00000003 c0f91cc0 c07e1684 c069b6d8 c069b6fc
c069b6fc c07e3d18
[   84.081529] 1e20: 00000000 c00599f8 00000003 00000000 00000000 c07a275c
60000013 00000004
[   84.089741] 1e40: 00000001 00000000 00000000 00000000 00000000 00000000
00000000 c07e1684
[   84.097956] 1e60: c07e1678 c069b6fc c6d20000 c07e3d18 00000000 c005e178
c06e4fbc c6d21e9c
[   84.106168] 1e80: 00000002 c053539c 00000000 00000003 00000000 c07e1684
c069b6d8 c069b6fc
[   84.114383] 1ea0: c069b6fc c07e3d18 00000000 c005a358 00000000 00000001
00000000 c07e1468
[   84.122596] 1ec0: 00000000 c0054efc 00000000 00000000 00000000 c0165f00
00000000 60000013
[   84.130812] 1ee0: c6d8c5c0 00000003 00000003 c0f91cc4 00000004 c6d20000
c0696b14 c0058d1c
[   84.139027] 1f00: c6d15b80 00000004 c6d8c5c0 c6d8c5c0 c6d15b8c c6d20000
c6d21f88 c02c7b38
[   84.147240] 1f20: c6d15b80 c0166da4 c6d15b80 01f8e408 00000004 c0165f74
00000000 00000000
[   84.155455] 1f40: 00000004 c6c39120 00000004 01f8e408 c6d21f88 c000f648
00000000 c010090c
[   84.163671] 1f60: c6e17da0 c6c39120 c6c39120 c6c39120 c6c39120 00000004
01f8e408 c000f648
[   84.171884] 1f80: 00000000 c0100b10 00000000 00000000 b6ef5b40 00000004
01f8e408 b6ef5b40
[   84.180097] 1fa0: 00000004 c000f460 00000004 01f8e408 00000001 01f8e408
00000004 00000000
[   84.188311] 1fc0: 00000004 01f8e408 b6ef5b40 00000004 00000004 01f8e408
00000004 00000000
[   84.196525] 1fe0: 00000000 bec9595c b6e2143c b6e7716c 60000010 00000001
00000000 00000000
[   84.204762] [<c0350a10>] (regmap_read) from [<c03d8ac4>]
(mxs_phy_get_vbus_status+0x40/0x58)
[   84.213258] [<c03d8ac4>] (mxs_phy_get_vbus_status) from [<c03d8ca4>]
(mxs_phy_suspend+0x54/0x120)
[   84.222185] [<c03d8ca4>] (mxs_phy_suspend) from [<c03d924c>]
(ci_controller_suspend+0x40/0x60)
[   84.230847] [<c03d924c>] (ci_controller_suspend) from [<c03d93dc>]
(ci_suspend+0x7c/0xbc)
[   84.239081] [<c03d93dc>] (ci_suspend) from [<c03401ac>]
(platform_pm_suspend+0x2c/0x54)
[   84.247145] [<c03401ac>] (platform_pm_suspend) from [<c0348818>]
(dpm_run_callback+0x48/0x12c)
[   84.255809] [<c0348818>] (dpm_run_callback) from [<c03494d0>]
(__device_suspend+0x12c/0x370)
[   84.264294] [<c03494d0>] (__device_suspend) from [<c0349c14>]
(dpm_suspend+0x134/0x2fc)
[   84.272350] [<c0349c14>] (dpm_suspend) from [<c00599f8>]
(suspend_devices_and_enter+0x8c/0x6e4)
[   84.281094] [<c00599f8>] (suspend_devices_and_enter) from [<c005a358>]
(pm_suspend+0x308/0x434)
[   84.289836] [<c005a358>] (pm_suspend) from [<c0058d1c>]
(state_store+0x80/0xcc)
[   84.297192] [<c0058d1c>] (state_store) from [<c02c7b38>]
(kobj_attr_store+0x18/0x1c)
[   84.304979] [<c02c7b38>] (kobj_attr_store) from [<c0166da4>]
(sysfs_kf_write+0x48/0x4c)
[   84.313046] [<c0166da4>] (sysfs_kf_write) from [<c0165f74>]
(kernfs_fop_write+0xe0/0x188)
[   84.321282] [<c0165f74>] (kernfs_fop_write) from [<c010090c>]
(vfs_write+0xb8/0x1e8)
[   84.329074] [<c010090c>] (vfs_write) from [<c0100b10>] (SyS_write+0x44/0x88)
[   84.336178] [<c0100b10>] (SyS_write) from [<c000f460>]
(ret_fast_syscall+0x0/0x48)
[   84.343791] Code: e92d4070 e1a04000 e1a05001 e1a00001 (e594117c)
[   84.350165] ---[ end trace 6acb90b2c2dd8be9 ]---

The following patch fixed the issue for me, but i'm not sure that is the right
fix
for this issue since there are more platforms involved.

-----------------------------------%<----------------------------------------------
[PATCH] usb: phy: phy-mxs-usb: fix oops on suspend to RAM

This patch avoids the oops in mxs_phy_get_vbus_status() by aborting
since there is no syscon available.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: efdbd3a5d6e ("usb: phy: mxs: do not set PWD.RXPWD1PT1 for low speed
connection")
CC: <stable@vger.kernel.org> # 4.0
---
 drivers/usb/phy/phy-mxs-usb.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 8f7cb06..3fcc048 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -217,6 +217,9 @@ static bool mxs_phy_get_vbus_status(struct mxs_phy *mxs_phy)
 {
 	unsigned int vbus_value;
 
+	if (!mxs_phy->regmap_anatop)
+		return false;
+
 	if (mxs_phy->port_id == 0)
 		regmap_read(mxs_phy->regmap_anatop,
 			ANADIG_USB1_VBUS_DET_STAT,
-- 
1.7.9.5

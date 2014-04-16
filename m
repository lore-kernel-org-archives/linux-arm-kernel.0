From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Apr 2014 22:43:16 -0300
Subject: USB OTG support on mx27pdk
Message-ID: <CAOMZO5BcTP=fvYDE8EU2Y2Syn=QqbPd4zaQ96mSfy-mgLEjOmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to add USBOTG support to mx27pdk with the following dts patch:

--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -78,6 +78,14 @@
        status = "okay";
 };

+&usbotg {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_usbotg>;
+       dr_mode = "otg";
+       phy_type = "ulpi";
+       status = "okay";
+};
+
 &iomuxc {
        imx27-pdk {
                pinctrl_cspi2: cspi2grp {
@@ -121,5 +129,22 @@
                                MX27_PAD_UART1_RTS__UART1_RTS 0x0
                        >;
                };
+
+               pinctrl_usbotg: usbotggrp {
+                       fsl,pins = <
+                               MX27_PAD_USBOTG_NXT__USBOTG_NXT 0x0
+                               MX27_PAD_USBOTG_STP__USBOTG_STP 0x0
+                               MX27_PAD_USBOTG_DIR__USBOTG_DIR 0x0
+                               MX27_PAD_USBOTG_CLK__USBOTG_CLK 0x0
+                               MX27_PAD_USBOTG_DATA0__USBOTG_DATA0 0x0
+                               MX27_PAD_USBOTG_DATA1__USBOTG_DATA1 0x0
+                               MX27_PAD_USBOTG_DATA2__USBOTG_DATA2 0x0
+                               MX27_PAD_USBOTG_DATA3__USBOTG_DATA3 0x0
+                               MX27_PAD_USBOTG_DATA4__USBOTG_DATA4 0x0
+                               MX27_PAD_USBOTG_DATA5__USBOTG_DATA5 0x0
+                               MX27_PAD_USBOTG_DATA6__USBOTG_DATA6 0x0
+                               MX27_PAD_USBOTG_DATA7__USBOTG_DATA7 0x0
+                       >;
+               };
        };
 }


However on kernel boot the following is seen:


ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-mxc: Freescale On-Chip EHCI Host driver
usbcore: registered new interface driver usb-storage
10024000.usb supply vbus not found, using dummy regulator
Unhandled fault: external abort on non-linefetch (0x808) at 0xf4424184
Internal error: : 808 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.15.0-rc1-26325-g971f9fd-dirty #64
task: c7829aa0 ti: c7836000 task.ti: c7836000
PC is at ci_hdrc_probe+0x3a4/0x634
LR is at ci_hdrc_probe+0x100/0x634
pc : [<c036cc78>]    lr : [<c036c9d4>]    psr: 60000013
sp : c7837d48  ip : 00000001  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : c791b6c0
r7 : c7945000  r6 : f4424000  r5 : c7945010  r4 : c794e010
r3 : f4424184  r2 : 00000000  r1 : 8c000004  r0 : 0c000004
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: a0004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc78361c0)
Stack: (0xc7837d48 to 0xc7838000)
7d40:                   00000000 c012e294 c7945010 c06f471c c073dc90 c06f471c
7d60: 00000000 c02b9d84 c02b9d6c c7945010 00000000 c02b8874 c02b8a1c 00000000
7d80: c7945010 c02b8a1c c78bc010 c02b6fcc c7828c7c c7a150d4 c7945010 c7945044
7da0: c7945010 c02b8744 c7945010 c06e6780 c7945010 c02b7e58 c7945010 00000000
7dc0: c7945018 c02b6440 c7829aa0 c06cd748 c791b6c0 c7945010 00000000 00000002
7de0: c7945000 c7945010 c7945000 00000002 c7893340 c02b9f28 10024000 00000000
7e00: 00000000 c7837e34 c7945000 c036d1d4 00000000 00000000 c78bc010 c78bc000
7e20: 00000000 00000091 c7875670 c036e358 c7836000 c78a8aa0 00000100 00000000
7e40: c7881b90 00000003 0000000a 00000003 00000000 c793b9c0 00000000 c78bc010
7e60: c06f48c4 c073dc90 c06f48c4 c7836000 c06a4aa0 c02b9d84 c02b9d6c c78bc010
7e80: 00000000 c02b8874 00000000 c78bc010 c06f48c4 c78bc044 00000000 c02b8a18
7ea0: 00000000 c06f48c4 c02b898c c02b7070 c7828c6c c78905b0 c06f48c4 c7943ee0
7ec0: c06e6780 c02b8050 c05ff4b8 c024a414 c06f48c4 c06f48c4 00000006 c06b21c4
7ee0: c0707240 c02b9088 00000000 c06bdd8c 00000006 c0008974 c7866280 c01236c0
7f00: c070f434 c7866280 c04c9900 0000004f 00000000 00000000 00000000 c01239f4
7f20: 60000053 c06cec64 c7ffc890 c04ec5c0 00000091 c0034300 c064db3c 00000006
7f40: c7ffc897 00000006 c06cec3c c06bdd8c 00000006 c06b21c4 c0707240 c0679480
7f60: 00000091 c06b21d0 00000000 c0679af0 00000006 00000006 c0679480 ffffffff
7f80: c7837f9c c003f8c0 00000000 c04b8dd0 00000000 00000000 00000000 00000000
7fa0: 00000000 c04b8dd8 00000000 c00095b0 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c036cc78>] (ci_hdrc_probe) from [<c02b9d84>] (platform_drv_probe+0x18/0x48)
[<c02b9d84>] (platform_drv_probe) from [<c02b8874>] (driver_probe_device+0x104/)
[<c02b8874>] (driver_probe_device) from [<c02b6fcc>] (bus_for_each_drv+0x48/0x9)
[<c02b6fcc>] (bus_for_each_drv) from [<c02b8744>] (device_attach+0x74/0x80)
[<c02b8744>] (device_attach) from [<c02b7e58>] (bus_probe_device+0x88/0xb0)
[<c02b7e58>] (bus_probe_device) from [<c02b6440>] (device_add+0x3e0/0x4e4)
[<c02b6440>] (device_add) from [<c02b9f28>] (platform_device_add+0xac/0x20c)
[<c02b9f28>] (platform_device_add) from [<c036d1d4>] (ci_hdrc_add_device+0x198/)
[<c036d1d4>] (ci_hdrc_add_device) from [<c036e358>] (ci_hdrc_imx_probe+0x1b4/0x)
[<c036e358>] (ci_hdrc_imx_probe) from [<c02b9d84>] (platform_drv_probe+0x18/0x4)
[<c02b9d84>] (platform_drv_probe) from [<c02b8874>] (driver_probe_device+0x104/)
[<c02b8874>] (driver_probe_device) from [<c02b8a18>] (__driver_attach+0x8c/0x90)
[<c02b8a18>] (__driver_attach) from [<c02b7070>] (bus_for_each_dev+0x5c/0x8c)
[<c02b7070>] (bus_for_each_dev) from [<c02b8050>] (bus_add_driver+0xd8/0x1d8)
[<c02b8050>] (bus_add_driver) from [<c02b9088>] (driver_register+0x78/0xf4)
[<c02b9088>] (driver_register) from [<c0008974>] (do_one_initcall+0xf8/0x15c)
[<c0008974>] (do_one_initcall) from [<c0679af0>] (kernel_init_freeable+0xec/0x1)
[<c0679af0>] (kernel_init_freeable) from [<c04b8dd8>] (kernel_init+0x8/0xec)
[<c04b8dd8>] (kernel_init) from [<c00095b0>] (ret_from_fork+0x14/0x24)
Code: e3520000 1a000003 e3c004d2 e1801001 (e5831000)
---[ end trace 4042b4d525025a88 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


Does anyone know if USB otg is functional on any mx27 hardware with 3.15-rc1?


Thanks,

Fabio Estevam

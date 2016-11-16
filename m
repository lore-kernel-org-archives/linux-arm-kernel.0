From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 16 Nov 2016 09:45:35 -0800
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove skeleton.dtsi'
Message-ID: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

my 'sabrelite' and 'imx25-pdk' qemu boot tests are failing in linux-next.

Bisect for the sabrelite failure points to commit 'ARM: dts: imx: Remove skeleton.dtsi'.

Bisect log is attached. Complete test logs are at
http://kerneltests.org/builders/qemu-arm-next/builds/571/steps/qemubuildcommand/logs/stdio

Boot log for imx25-pdk:

qemu-system-arm: findnode_nofail Couldn't find node /chosen: FDT_ERR_NOTFOUND

Boot log for sabrelite:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc5-next-20161116 (groeck at jupiter.roeck-us.net) (gcc version 4.9.2 (GCC) ) #1 SMP Tue Nov 15 22:34:35 PST 2016
[    0.000000] CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt:Machine model: Freescale i.MX6 DualLite SABRE Lite Board
[    0.000000] earlycon: ec_imx21 at MMIO 0x021e8000 (options '')
[    0.000000] bootconsole [ec_imx21] enabled
[    0.000000] INITRD: 0x14000000+0x00501600 is not a memory region - disabling initrd
[    0.000000] cma: Failed to reserve 64 MiB
[    0.000000] Memory policy: Data cache writeback

[ stuck here until aborted ]

Build is imx_v6_v7_defconfig and multi_v7_defconfig with imx6dl-sabrelite.dtb,
and imx_v4_v5_defconfig with imx25-pdk.dtb.

Any idea what might be wrong ?

Thanks,
Guenter

-------
# bad: [56c0dbc6eced261af328afd3335d62234bc56513] Add linux-next specific files for 20161116
# good: [a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6] Linux 4.9-rc5
git bisect start 'HEAD' 'v4.9-rc5'
# bad: [56abc46730bb1c5ffd960c71ae089cb713e85e47] Merge remote-tracking branch 'drm/drm-next'
git bisect bad 56abc46730bb1c5ffd960c71ae089cb713e85e47
# bad: [c0d79c892333b32ddae50bbadd885413b51f7252] Merge remote-tracking branch 'dlm/next'
git bisect bad c0d79c892333b32ddae50bbadd885413b51f7252
# bad: [4763d380325df1d74bf3891b00fd318d4a44feee] Merge remote-tracking branch 'renesas/next'
git bisect bad 4763d380325df1d74bf3891b00fd318d4a44feee
# good: [19be51760fbe79fc5926c455546971bd1412b9cf] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good 19be51760fbe79fc5926c455546971bd1412b9cf
# bad: [c07b71c4ddd300095d39b74da58f0e70b7931f1d] Merge remote-tracking branch 'mvebu/for-next'
git bisect bad c07b71c4ddd300095d39b74da58f0e70b7931f1d
# bad: [242a001e48b78f190d18242132cab73527ca06a4] Merge branch 'zte/dt64' into for-next
git bisect bad 242a001e48b78f190d18242132cab73527ca06a4
# bad: [c201369d4aa5f05b8a37d6d1eeabf248c7086454] ARM: dts: imx6ull: add imx6ull support
git bisect bad c201369d4aa5f05b8a37d6d1eeabf248c7086454
# good: [9daee307694027eac4b10baa9cd3f2070f7459ba] ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
git bisect good 9daee307694027eac4b10baa9cd3f2070f7459ba
# good: [67cb5d52ea2c3ae35d637ab79a46cd452d1c7d41] ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
git bisect good 67cb5d52ea2c3ae35d637ab79a46cd452d1c7d41
# good: [c4479f6f57a0821aae4f6ab6a91a23625d6b35a0] ARM: dts: add new compatible string for i.MX6QP mmdc
git bisect good c4479f6f57a0821aae4f6ab6a91a23625d6b35a0
# bad: [7f107887d1995c819389f292828097cac4ec4396] ARM: dts: imx: Remove skeleton.dtsi
git bisect bad 7f107887d1995c819389f292828097cac4ec4396
# good: [425dd2773ed07d1ba21d4ada0f9a9abc85b75151] ARM: dts: imx6q-utilite-pro: i2c1 is muxed
git bisect good 425dd2773ed07d1ba21d4ada0f9a9abc85b75151
# first bad commit: [7f107887d1995c819389f292828097cac4ec4396] ARM: dts: imx: Remove skeleton.dtsi

From: nriley@opto22.com (Nick Riley)
Date: Fri, 26 Jun 2015 11:15:57 -0700
Subject: i.MX6Q IPU HDMI Detection
Message-ID: <CAGEW0VCdLDaqDOHv0nvR4J5th9YYhx5bLXdfsa8_g6rVyOHZ3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a SABRESD board based off the i.MX6Q CPU I've been using to
test HDMI monitors with.  When I power-up the SABRESD, most monitors
will not display any video (console).  Only the Samsung monitor in the
list below works on power-up.  But if I hot-swap the HDMI cable, the
other monitors will detect a signal.  And if the resolution is
supported it will display video.

I have also tested this with a Freescale Linux kernel 3.14.28_1.0.0_ga
found here, "http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/".
Using this kernel all the monitors I've tested work as expected.

Any help to get this resolved with the Mainline Linux kernel is
appreciated.  Thanks.


My setup:

U-Boot Version: U-Boot 2014.04-08650-g5b983bd from Freescale Yocto build (fido)

Mainline Linux Kernel Version: 4.0.6

RFS Tested: core-image-x11 from Freescale Yocto build (fido),
linaro-utopic-alip-20150319-701, and linaro-utopic-nano-20141122-688.

Linux Command Line: console=ttymxc0,115200 root=/dev/mmcblk0p2
rootwait rw video=mxcfb0:dev=hdmi,1920x1080M@,if=RGB24
elevator=deadline


List of Monitors Tested:
Samsung Model No: 2243BWT, Resolution 1680x1050
Dell Model No: P2314T, Resolution 1920x1080
Viewsonic Model No: VG2039M-LED, Resolution 1600x900
Acer Model No: FT200HQL, Resolution 1600x900
Acer Model No: B223W, Resolution 1680x1050
Asus Model No: VH202T, Resolution 1600x900
LG Model No: W2442PAT Resolution 1920x1080


Debug output from "drivers/gpu/ipu-v3/ipu-di.c" using Dell Monitor
P2314T from power-up:
root at imx6qsabresd:~# dmesg | grep ipu
[    1.448829] imx-ipuv3 2400000.ipu: DI0 base: 0x02640000 remapped to c08c2000
[    1.448889] imx-ipuv3 2400000.ipu: DI1 base: 0x02648000 remapped to c08ce000
[    1.450755] imx-ipuv3 2400000.ipu: IPUv3H probed
[    1.455795] imx-ipuv3 2800000.ipu: DI0 base: 0x02a40000 remapped to c096e000
[    1.455852] imx-ipuv3 2800000.ipu: DI1 base: 0x02a48000 remapped to c0976000
[    1.473130] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops
ipu_crtc_ops)
[    1.480824] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops
ipu_crtc_ops)
[    1.488508] imx-drm display-subsystem: bound imx-ipuv3-crtc.4 (ops
ipu_crtc_ops)
[    1.496118] imx-drm display-subsystem: bound imx-ipuv3-crtc.5 (ops
ipu_crtc_ops)
[    1.596352] imx-ipuv3 2400000.ipu: disp 0: panel size = 1920 x 1080
[    1.596381] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
24000000Hz Needed 148500000Hz
[    1.596483] imx-ipuv3 2400000.ipu:   IPU clock can give 132000000
with divider 2, error -11.8%
[    1.596744] imx-ipuv3 2400000.ipu: Want 148500000Hz IPU 264000000Hz
DI 148500000Hz using DI, 148500000Hz
[    1.634226] imx-ipuv3 2400000.ipu: disp 1: panel size = 1024 x 768
[    1.634248] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
49500000Hz Needed 65000000Hz
[    1.634278] imx-ipuv3 2400000.ipu: Want 65000000Hz IPU 264000000Hz
DI 49500000Hz using DI, 49500000Hz
[    1.713976] imx-ipuv3 2800000.ipu: IPUv3H probed


Debug output from "drivers/gpu/ipu-v3/ipu-di.c" using Dell Monitor
P2314T after hot-swap:
root at imx6qsabresd:~# dmesg | grep ipu
[    1.448829] imx-ipuv3 2400000.ipu: DI0 base: 0x02640000 remapped to c08c2000
[    1.448889] imx-ipuv3 2400000.ipu: DI1 base: 0x02648000 remapped to c08ce000
[    1.450755] imx-ipuv3 2400000.ipu: IPUv3H probed
[    1.455795] imx-ipuv3 2800000.ipu: DI0 base: 0x02a40000 remapped to c096e000
[    1.455852] imx-ipuv3 2800000.ipu: DI1 base: 0x02a48000 remapped to c0976000
[    1.473130] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops
ipu_crtc_ops)
[    1.480824] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops
ipu_crtc_ops)
[    1.488508] imx-drm display-subsystem: bound imx-ipuv3-crtc.4 (ops
ipu_crtc_ops)
[    1.496118] imx-drm display-subsystem: bound imx-ipuv3-crtc.5 (ops
ipu_crtc_ops)
[    1.596352] imx-ipuv3 2400000.ipu: disp 0: panel size = 1920 x 1080
[    1.596381] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
24000000Hz Needed 148500000Hz
[    1.596483] imx-ipuv3 2400000.ipu:   IPU clock can give 132000000
with divider 2, error -11.8%
[    1.596744] imx-ipuv3 2400000.ipu: Want 148500000Hz IPU 264000000Hz
DI 148500000Hz using DI, 148500000Hz
[    1.634226] imx-ipuv3 2400000.ipu: disp 1: panel size = 1024 x 768
[    1.634248] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
49500000Hz Needed 65000000Hz
[    1.634278] imx-ipuv3 2400000.ipu: Want 65000000Hz IPU 264000000Hz
DI 49500000Hz using DI, 49500000Hz
[    1.713976] imx-ipuv3 2800000.ipu: IPUv3H probed
[   83.917518] imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
[   83.923713] imx-ipuv3 2400000.ipu: disp 0: panel size = 1024 x 768
[   83.923763] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
454999992Hz Needed 65000000Hz
[   83.923862] imx-ipuv3 2400000.ipu: Want 65000000Hz IPU 264000000Hz
DI 454999992Hz using DI, 454999992Hz
[   87.767442] imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
[   88.837239] imx-ipuv3 2400000.ipu: Timeout waiting for DMFC FIFOs to clear
[   88.844214] imx-ipuv3 2400000.ipu: disp 0: panel size = 1920 x 1080
[   88.844236] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
64999999Hz Needed 148500000Hz
[   88.844256] imx-ipuv3 2400000.ipu:   IPU clock can give 132000000
with divider 2, error -11.8%
[   88.844319] imx-ipuv3 2400000.ipu: Want 148500000Hz IPU 264000000Hz
DI 129999997Hz using DI, 129999997Hz
[   88.881781] imx-ipuv3 2400000.ipu: disp 1: panel size = 1024 x 768
[   88.881804] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI
129999997Hz Needed 65000000Hz
[   88.881830] imx-ipuv3 2400000.ipu: Want 65000000Hz IPU 264000000Hz
DI 129999997Hz using DI, 129999997Hz

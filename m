From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 10 Sep 2013 07:42:04 -0700
Subject: [PATCH 1/2] ARM: dts: mx6: Add mx6solo support
In-Reply-To: <CAOMZO5D8VW=M_DW69p+p512Uw9eySt+PoM-iWN=m3jXb0tfvaw@mail.gmail.com>
 (Fabio Estevam's message of "Mon, 9 Sep 2013 18:24:16 -0300")
References: <1378688408-8689-1-git-send-email-festevam@gmail.com>
 <20130909150823.GB5815@S2101-09.ap.freescale.net>
 <CAOMZO5Ab9qVsQica-x3091YPhttqpbr_NL=A2ddzL5znuDtAUw@mail.gmail.com>
 <CAOCHtYhJjxBL1AY0dxc+FofXqRT25g8yaO+Z6d09mfkJWT+i+A@mail.gmail.com>
 <CAOMZO5D8VW=M_DW69p+p512Uw9eySt+PoM-iWN=m3jXb0tfvaw@mail.gmail.com>
Message-ID: <877geohh6r.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

> On Mon, Sep 9, 2013 at 1:19 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
>
>>> Ok, I made this test and it booted fine.
>>>
>>> So I will change U-boot so that it searches for imx6dl-wandboard.dtb
>>> instead of imx6s-wandboard.dtb.
>>
>> Since there is no WiFi/Bluetooth on the "solo" vs the wandboard dual
>> lite, we should really still have a separate solo dtb file..
>
> I think we could still represent the im6solo-wandboard using the
> imx6dl-wandboard.dts.
>
> In the case of lack of bcm4329 populated on a mx6solo board, the SDHC3
> port will just not probe bcm4329 without any negative effect, right?

I've noticed in my auto build/boot[1] that booting a wandboard solo with
imx6dl-wandboard.dtb actually faults[2].  Just disabling usdhc2[3] makes
it boot fine.

This only happens on current linus/HEAD.  v3.11 boots fine as does
linux-next (as of next-20130910.)  

Kevin

P.S. Thanks to Fabio Estevam and the folks at TexhNexion for donating
     Wandboards for my automated build/boot farm.  As you'll see in the
     build/boot reports[1], A wandboard solo, dual and quad are now part
     of the regular boot testing.

[1] build/root reports available here:
    http://lists.linaro.org/pipermail/kernel-build-reports/2013-September/thread.html

[2]
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: no vqmmc regulator found
mmc0: no vmmc regulator found
mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc] using ADMA
mmc1: no vqmmc regulator found
mmc1: no vmmc regulator found
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 80004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.0+ #1
task: 9f868000 ti: 9f86a000 task.ti: 9f86a000
PC is at wake_up_process+0xc/0x48
LR is at sdhci_irq+0x74c/0x9f8
pc : [<8004ea48>]    lr : [<8042bb98>]    psr: 60000193
sp : 9f86bb88  ip : 9f86bba0  fp : 9f86bb9c
r10: 9f8079c0  r9 : 00000100  r8 : 00000037
r7 : 00000000  r6 : 00000000  r5 : 00000001  r4 : 9f9df800
r3 : 00000001  r2 : 00000002  r1 : 20000193  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 2f14004a  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0x9f86a240)
Stack: (0x9f86bb88 to 0x9f86c000)
bb80:                   00000001 9f9df800 9f86bbe4 9f86bba0 8042bb98 8004ea48
bba0: 00000000 9f80fe80 9f86bbcc 00000000 00000001 00000000 00000000 9f12a140
bbc0: 00000001 00000000 00000000 00000037 808257ff 9f8079c0 9f86bc1c 9f86bbe8
bbe0: 8007ae8c 8042b458 80829bbc 00004027 9f86bc14 9f8079c0 00000001 9f86a000
bc00: 00000037 00000000 9f8079f4 00000037 9f86bc34 9f86bc20 8007b020 8007ae44
bc20: 9f8079c0 00000001 9f86bc4c 9f86bc38 8007e1c8 8007afe0 00000037 807dcd8c
bc40: 9f86bc64 9f86bc50 8007a808 8007e138 00000180 807e6bb8 9f86bc8c 9f86bc68
bc60: 8000f1d8 8007a7ec 000000a0 f400010c 807e6d04 9f86bcb0 f4000100 60000013
bc80: 9f86bcac 9f86bc90 800085d8 8000f190 805c1aac 60000013 ffffffff 9f86bce4
bca0: 9f86bd04 9f86bcb0 80012c40 800085b4 9f807a14 60000013 00000007 00000000
bcc0: 9f8079c0 9f12a140 9f807a14 00000080 60000013 9f8079f4 00000037 9f86bd04
bce0: 9f86bd08 9f86bcf8 8007c67c 805c1aac 60000013 ffffffff 9f86bd44 9f86bd08
bd00: 8007c67c 805c1a8c 00000000 000080d0 00003ede 00000001 9f86bd34 9f12a140
bd20: 9f8079c0 8042b44c 00000080 00000037 00000000 9f9dfac0 9f86bd74 9f86bd48
bd40: 8007c9b4 8007c460 00000080 00000000 9f9dfc00 9f9dfac0 9f9df800 9f9dfbec
bd60: 9f86a000 00000800 9f86bda4 9f86bd78 8042cec8 8007c914 9f128f40 9f9dfac0
bd80: 9f126990 9f9dfac0 80ccf124 9f904000 9f824080 807cf5ec 9f86bdd4 9f86bda8
bda0: 8042e5d4 8042c848 9f86bdc4 9f86bdb8 8012d604 80875df8 9f904010 00000000
bdc0: 808175f8 807bb0b8 9f86bde4 9f86bdd8 80301c48 8042e348 9f86be04 9f86bde8
bde0: 803008f0 80301c34 9f904010 808175f8 9f904044 00000000 9f86be24 9f86be08
be00: 80300a9c 803007f0 9f83b55c 00000000 808175f8 80300a08 9f86be4c 9f86be28
be20: 802fed34 80300a14 9f83b55c 9f9030b4 9f83b570 808175f8 9f126300 80805548
be40: 9f86be5c 9f86be50 803003e4 802fece4 9f86be8c 9f86be60 802fff24 803003d0
be60: 80740bfc 80825980 9f86be8c 808175f8 00000006 80825980 8078d46c 807bb0b8
be80: 9f86bea4 9f86be90 80301160 802ffe54 807db588 00000006 9f86beb4 9f86bea8
bea0: 80301e64 803010ec 9f86bec4 9f86beb8 807bb0d0 80301e20 9f86bf54 9f86bec8
bec0: 80008898 807bb0c4 9f86bf0c 9f86bed8 805c145c 00000000 00100100 807f33fc
bee0: 9f86bf0c 9f86bef0 8078d400 80277164 8078d46c 80cd132d 805daf18 000000bd
bf00: 9f86bf54 9f86bf10 80040a8c 8078d478 00000000 00000006 00000006 8078a57c
bf20: 00000000 8073581c 9f86bf54 807db588 00000006 80825980 8078d46c 000000bd
bf40: 807cf5e0 807cf5ec 9f86bf94 9f86bf58 8078dc10 800087b0 00000006 00000006
bf60: 8078d46c 00000000 00000000 00000000 805b6c10 00000000 00000000 00000000
bf80: 00000000 00000000 9f86bfac 9f86bf98 805b6c20 8078db18 ffffffff 00000000
bfa0: 00000000 9f86bfb0 8000e978 805b6c1c 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Backtrace: 
[<8004ea3c>] (wake_up_process+0x0/0x48) from [<8042bb98>] (sdhci_irq+0x74c/0x9f8)
 r4:9f9df800 r3:00000001
[<8042b44c>] (sdhci_irq+0x0/0x9f8) from [<8007ae8c>] (handle_irq_event_percpu+0x54/0x19c)
[<8007ae38>] (handle_irq_event_percpu+0x0/0x19c) from [<8007b020>] (handle_irq_event+0x4c/0x6c)
[<8007afd4>] (handle_irq_event+0x0/0x6c) from [<8007e1c8>] (handle_fasteoi_irq+0x9c/0x170)
 r5:00000001 r4:9f8079c0
[<8007e12c>] (handle_fasteoi_irq+0x0/0x170) from [<8007a808>] (generic_handle_irq+0x28/0x38)
 r5:807dcd8c r4:00000037
[<8007a7e0>] (generic_handle_irq+0x0/0x38) from [<8000f1d8>] (handle_IRQ+0x54/0xb8)
 r4:807e6bb8 r3:00000180
[<8000f184>] (handle_IRQ+0x0/0xb8) from [<800085d8>] (gic_handle_irq+0x30/0x64)
 r8:60000013 r7:f4000100 r6:9f86bcb0 r5:807e6d04 r4:f400010c
r3:000000a0
[<800085a8>] (gic_handle_irq+0x0/0x64) from [<80012c40>] (__irq_svc+0x40/0x54)
Exception stack(0x9f86bcb0 to 0x9f86bcf8)
bca0:                                     9f807a14 60000013 00000007 00000000
bcc0: 9f8079c0 9f12a140 9f807a14 00000080 60000013 9f8079f4 00000037 9f86bd04
bce0: 9f86bd08 9f86bcf8 8007c67c 805c1aac 60000013 ffffffff
 r7:9f86bce4 r6:ffffffff r5:60000013 r4:805c1aac
[<805c1a80>] (_raw_spin_unlock_irqrestore+0x0/0x30) from [<8007c67c>] (__setup_irq+0x228/0x4b4)
[<8007c454>] (__setup_irq+0x0/0x4b4) from [<8007c9b4>] (request_threaded_irq+0xac/0x138)
[<8007c908>] (request_threaded_irq+0x0/0x138) from [<8042cec8>] (sdhci_add_host+0x68c/0xba4)
[<8042c83c>] (sdhci_add_host+0x0/0xba4) from [<8042e5d4>] (sdhci_esdhc_imx_probe+0x298/0x508)
[<8042e33c>] (sdhci_esdhc_imx_probe+0x0/0x508) from [<80301c48>] (platform_drv_probe+0x20/0x24)
 r8:807bb0b8 r7:808175f8 r6:00000000 r5:9f904010 r4:80875df8
[<80301c28>] (platform_drv_probe+0x0/0x24) from [<803008f0>] (driver_probe_device+0x10c/0x224)
[<803007e4>] (driver_probe_device+0x0/0x224) from [<80300a9c>] (__driver_attach+0x94/0x98)
 r7:00000000 r6:9f904044 r5:808175f8 r4:9f904010
[<80300a08>] (__driver_attach+0x0/0x98) from [<802fed34>] (bus_for_each_dev+0x5c/0x90)
 r6:80300a08 r5:808175f8 r4:00000000 r3:9f83b55c
[<802fecd8>] (bus_for_each_dev+0x0/0x90) from [<803003e4>] (driver_attach+0x20/0x28)
 r6:80805548 r5:9f126300 r4:808175f8
[<803003c4>] (driver_attach+0x0/0x28) from [<802fff24>] (bus_add_driver+0xdc/0x264)
[<802ffe48>] (bus_add_driver+0x0/0x264) from [<80301160>] (driver_register+0x80/0xfc)
 r8:807bb0b8 r7:8078d46c r6:80825980 r5:00000006 r4:808175f8
[<803010e0>] (driver_register+0x0/0xfc) from [<80301e64>] (__platform_driver_register+0x50/0x64)
 r5:00000006 r4:807db588
[<80301e14>] (__platform_driver_register+0x0/0x64) from [<807bb0d0>] (sdhci_esdhc_imx_driver_init+0x18/0x20)
[<807bb0b8>] (sdhci_esdhc_imx_driver_init+0x0/0x20) from [<80008898>] (do_one_initcall+0xf4/0x154)
[<800087a4>] (do_one_initcall+0x0/0x154) from [<8078dc10>] (kernel_init_freeable+0x104/0x1d0)
[<8078db0c>] (kernel_init_freeable+0x0/0x1d0) from [<805b6c20>] (kernel_init+0x10/0xec)
[<805b6c10>] (kernel_init+0x0/0xec) from [<8000e978>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:ffffffff
Code: e89da800 e1a0c00d e92dd818 e24cb004 (e5903000) 
---[ end trace a890b0bf17e153b1 ]---

[3]
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index a55113e..8d80181 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -126,7 +126,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2_2>;
 	non-removable;
-	status = "okay";
+	status = "disabled";
 };
 
 &usdhc3 {

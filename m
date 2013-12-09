From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Mon, 9 Dec 2013 07:10:34 +0000
Subject: [PATCH] ARM: dts: vf610: make pinctrl nodes board specific
In-Reply-To: <1386571837-16299-1-git-send-email-shawn.guo@linaro.org>
References: <1386571837-16299-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <c605b6ebe1df4c79a9cbce61e9e0c96a@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Data: Monday, December 09, 2013 2:51 PM + 800

>To: linux-arm-kernel at lists.infradead.org
>Cc: Lu Jingchang-B35083; Duan Fugang-B38611; Shawn Guo
>Subject: [PATCH] ARM: dts: vf610: make pinctrl nodes board specific
>
>Currently, all pinctrl setting nodes are defined in <soc>.dtsi, so that boards
>that share the same pinctrl setting do not have to define it time and time
>again in <board>.dts.  However, along with the devices and use cases being
>added continuously, the pinctrl setting nodes under iomuxc becomes more than
>expected.  This bloats device tree blob for particular board unnecessarily
>since only a small subset of those pinctrl setting nodes will be used by the
>board.  It impacts not only the DTB file size but also the run-time device tree
>lookup efficiency.
>
>The patch provides a solution to avoid this device tree bloating problem while
>still keeping boards share the common pinctrl setting data by using DTC macro
>support.  It creates <soc>-pingrp.h and move all those pinctrl setting data
>into there as macro definitions.  The <board>.dts will instead define the
>pinctrl setting nodes that are necessary for the board by referring to the
>macros in <soc>-pingrp.h, so that only the pinctrl setting data that will be
>used by the board will get compiled into the DTB for the board.
>
>With the changes, the pinctrl setting nodes becomes local to particular board,
>and it makes no sense to continue numbering the setting for given peripheral.
>Thus, all the pinctrl phandler name gets updated to have only peripheral name
>in there.
>
>Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>---
>This should have been done in the patch series [1], but somehow got missed in
>the first place.  So add one more patch to take care of VF610.
>
>[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/277649
>
> arch/arm/boot/dts/vf610-cosmic.dts |   16 +++-
> arch/arm/boot/dts/vf610-twr.dts    |   34 +++++--
> arch/arm/boot/dts/vf610.dtsi       |  172 +-----------------------------------
> 3 files changed, 44 insertions(+), 178 deletions(-)
>
>diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/vf610-
>cosmic.dts
>index c42e4f9..432960a 100644
>--- a/arch/arm/boot/dts/vf610-cosmic.dts
>+++ b/arch/arm/boot/dts/vf610-cosmic.dts
>@@ -36,12 +36,24 @@
> &fec1 {
> 	phy-mode = "rmii";
> 	pinctrl-names = "default";
>-	pinctrl-0 = <&pinctrl_fec1_1>;
>+	pinctrl-0 = <&pinctrl_fec1>;
> 	status = "okay";
> };
>
>+&iomuxc {
>+	vf610-cosmic {
>+		pinctrl_fec1: fec1grp {
>+			fsl,pins = <VF610_FEC1_PINGRP1>;
>+		};
>+
>+		pinctrl_uart1: uart1grp {
>+			fsl,pins = <VF610_UART1_PINGRP1>;
>+		};
>+	};
>+};
>+
Keep things in alphabetical order...

> &uart1 {
> 	pinctrl-names = "default";
>-	pinctrl-0 = <&pinctrl_uart1_1>;
>+	pinctrl-0 = <&pinctrl_uart1>;
> 	status = "okay";
> };

Other is fine.

From: phdm@macq.eu (Philippe De Muyter)
Date: Mon, 10 Feb 2014 01:15:47 +0100
Subject: imx6qdl, weim ranges and gpr1
Message-ID: <20140210001547.GA28084@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello linux on i.mx6 experts,

on our i.mx6q/dl-based custom hardware we have used the weim interface to
connect some peripherals.  Our weim dts description looks like that:

&weim {
	compatible = "fsl,imx6q-weim";
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_weim_sram_1>;
	clocks = <&clks 196>;
	reg = <0x021b8000 0x4000>;
	#address-cells = <2>;
	#size-cells = <1>;
	ranges = <0 0 0x08000000 0x04000000>, /* 64Mb for CS0 */
		<1 0 0x0c000000 0x04000000>; /* 64Mb for CS1 */
	status = "okay";

	...
};

Actually, to achieve this mapping, I must configure some bits in IOMUXC_GPR1,
like that:
	regmap_update_bits(gpr, IOMUXC_GPR1, 0xfff, 0x1b);

Would it be possible to set the IOMUXC_GPR1 bits automagically, based on the
dts description ? Where should that go, in drivers/bus/imx-weim.c or in
arch/arm/mach-imx/mach-imx6q.c ?  Also, I do not know how to retrieve
the 'ranges' property of the weim description.

Thanks in advance

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Feb 2014 23:10:30 +0800
Subject: imx6qdl, weim ranges and gpr1
In-Reply-To: <20140210001547.GA28084@frolo.macqel>
References: <20140210001547.GA28084@frolo.macqel>
Message-ID: <20140210151027.GP9628@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 01:15:47AM +0100, Philippe De Muyter wrote:
> Hello linux on i.mx6 experts,
> 
> on our i.mx6q/dl-based custom hardware we have used the weim interface to
> connect some peripherals.  Our weim dts description looks like that:
> 
> &weim {
> 	compatible = "fsl,imx6q-weim";
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_weim_sram_1>;
> 	clocks = <&clks 196>;
> 	reg = <0x021b8000 0x4000>;
> 	#address-cells = <2>;
> 	#size-cells = <1>;
> 	ranges = <0 0 0x08000000 0x04000000>, /* 64Mb for CS0 */
> 		<1 0 0x0c000000 0x04000000>; /* 64Mb for CS1 */
> 	status = "okay";
> 
> 	...
> };
> 
> Actually, to achieve this mapping, I must configure some bits in IOMUXC_GPR1,
> like that:
> 	regmap_update_bits(gpr, IOMUXC_GPR1, 0xfff, 0x1b);
> 
> Would it be possible to set the IOMUXC_GPR1 bits automagically, based on the
> dts description ?

It's possible, I think.

> Where should that go, in drivers/bus/imx-weim.c or in
> arch/arm/mach-imx/mach-imx6q.c ?

I prefer to drivers/bus/imx-weim.c.

> Also, I do not know how to retrieve
> the 'ranges' property of the weim description.

Just read it as an array of integers.  I will post a patch for it
tomorrow.  And please help test it.

Shawn

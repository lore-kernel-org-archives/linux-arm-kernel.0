From: jonas@microbit.se (Jonas Andersson)
Date: Wed, 22 May 2013 08:52:45 +0200
Subject: imx53 cspi clock problem
Message-ID: <519C6B3D.3030106@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

i have found a problem when using the cspi port in a imx53 soc. I am 
using kernel 3.10-rc2. This is the dts defenition:

cspi: cspi at 63fc0000 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
	reg = <0x63fc0000 0x4000>;
	interrupts = <38>;
	clocks = <&clks 55>, <&clks 0>;
	clock-names = "ipg", "per";
	status = "disabled";
};

then in the driver spi-imx.c:

spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);

clk_get_rate() will return the rate 0. In function mx31_config, this line:

reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
	MX31_CSPICTRL_DR_SHIFT;

will always configure the port for full speed (16.7 MHz in my system).

This "per" clock rate should be around 67MHz.

Jonas

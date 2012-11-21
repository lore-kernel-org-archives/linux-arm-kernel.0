From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Nov 2012 16:18:57 +0100
Subject: [PATCH v2] ARM: mx5: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1353431133-3643-1-git-send-email-festevam@gmail.com>
References: <1353431133-3643-1-git-send-email-festevam@gmail.com>
Message-ID: <20121121151857.GT10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 03:05:33PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Removed duplicated clock entries and clk_max
> - Fix imx51/imx53 names in the explanation of fsl,<soc>-ccm
> - Fix sdhc clocks
> 
>  .../devicetree/bindings/clock/imx5-clock.txt       |  191 ++++++++++++++++++++
>  arch/arm/boot/dts/imx51.dtsi                       |   39 ++++
>  arch/arm/boot/dts/imx53.dtsi                       |   48 +++++
>  arch/arm/mach-imx/clk-imx51-imx53.c                |   26 +--
>  arch/arm/mach-imx/imx51-dt.c                       |   28 +--
>  arch/arm/mach-imx/mach-imx53.c                     |   31 +---
>  6 files changed, 293 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
> new file mode 100644
> index 0000000..50380aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
> @@ -0,0 +1,191 @@
> +* Clock bindings for Freescale i.MX5
> +
> +Required properties:
> +- compatible: Should be "fsl,<soc>-ccm" , where <soc> can be imx51 or imx53
> +- reg: Address and length of the register set
> +- interrupts: Should contain CCM interrupt
> +- #clock-cells: Should be <1>
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  The following is a full list of i.MX5
> +clocks and IDs.
> +
> +	Clock			ID
> +	---------------------------
> +	dummy			0
> +	ckil			1
> +	osc			2
> +	ckih1			3
> +	ckih2			4
> +	ahb			5
> +	ipg			6
> +	axi_a			7
> +	axi_b			8
> +	uart_pred		9
> +	uart_root		10
> +	esdhc_a_pred		11
> +	esdhc_b_pred		12
> +	esdhc_c_s		13
> +	esdhc_d_s		14
> +	emi_sel			15
> +	emi_slow_podf		16
> +	nfc_podf		17
> +	ecspi_pred		18
> +	ecspi_podf		19
> +	usboh3_pred		20
> +	usboh3_podf		21
> +	usb_phy_pred		22
> +	usb_phy_podf		23
> +	cpu_podf		24
> +	di_pred			25
> +	tve_di			26
> +	tve_s			27
> +	uart1_ipg_gate		28
> +	uart1_per_gate		29
> +	uart2_ipg_gate		30
> +	uart2_per_gate		31
> +	uart3_ipg_gate		32
> +	uart3_per_gate		33
> +	i2c1_gate		34
> +	i2c2_gate		35
> +	gpt_ipg_gate		36
> +	pwm1_ipg_gate		37
> +	pwm1_hf_gate		38
> +	pwm2_ipg_gate		39
> +	pwm2_hf_gate		40
> +	gpt_hf_gate		41
> +	fec_gate		42
> +	usboh3_per_gate		43
> +	esdhc1_ipg_gate		44
> +	esdhc2_ipg_gate		45
> +	esdhc3_ipg_gate		46
> +	esdhc4_ipg_gate		47
> +	ssi1_ipg_gate		48
> +	ssi2_ipg_gate		49
> +	ssi3_ipg_gate		50
> +	ecspi1_ipg_gate		51
> +	ecspi1_per_gate		52
> +	ecspi2_ipg_gate		53
> +	ecspi2_per_gate		54
> +	cspi_ipg_gate		55
> +	sdma_gate		56
> +	emi_slow_gate		57
> +	ipu_s			58
> +	ipu_gate		59
> +	nfc_gate		60
> +	ipu_di1_gate		61
> +	vpu_s			62
> +	vpu_gate		63
> +	vpu_reference_gate	64
> +	uart4_ipg_gate		65
> +	uart4_per_gate		66
> +	uart5_ipg_gate		67
> +	uart5_per_gate		68
> +	tve_gate		69
> +	tve_pred		70
> +	esdhc1_per_gate		71
> +	esdhc2_per_gate		72
> +	esdhc3_per_gate		73
> +	esdhc4_per_gate		74
> +	usb_phy_gate		75
> +	hsi2c_gate		76
> +	mipi_hsc1_gate		77
> +	mipi_hsc2_gate		78
> +	mipi_esc_gate		79
> +	mipi_hsp_gate		80
> +	ldb_di1_div_3_5		81
> +	ldb_di1_div		82
> +	ldb_di0_div_3_5		83
> +	ldb_di0_div		84
> +	ldb_di1_gate		85
> +	can2_serial_gate	86
> +	can2_ipg_gate		87
> +	i2c3_gate		88
> +	lp_apm			89
> +	periph_apm		100

After 89 the next number is 90 ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

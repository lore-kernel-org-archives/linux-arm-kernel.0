From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 13:37:41 -0600
Subject: [PATCH v3] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170220152727.31892-1-andrew.smirnov@gmail.com>
References: <20170220152727.31892-1-andrew.smirnov@gmail.com>
Message-ID: <20170227193741.psngihpnsfhwhkh3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 07:27:27AM -0800, Andrey Smirnov wrote:
> Add code allowing for control of various power domains managed by GPCv2
> IP block found in i.MX7 series of SoCs. Power domains covered by this
> patch are:
> 
>     - PCIE PHY
>     - MIPI PHY
>     - USB HSIC PHY
>     - USB OTG1/2 PHY
> 
> Support for any other power domain controlled by GPC is not present, and
> can be added at some later point.
> 
> Testing of this code was done against a PCIe driver.
> 
> Cc: yurovsky at gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since v2 (see [v2]):
> 
> 	- Fix a critical bug where incorrect state of a bit was
>           expected in a busy wait loop (bit set instead of bit
>           cleared) imx7_gpc_pu_pgc_sw_pxx_req()
> 
> 	- Add missing step (setting of PCR in GPC_PGC_nCTRL) in power
>           down procedure
> 
> Changes since v1 (see [v1]):
> 
> 	- Various small DT bindings description fixes as per feedback
>           from Rob Herring
> 
> 
> [v1] https://lkml.org/lkml/2017/2/6/554
> [v2] https://lkml.org/lkml/2017/2/13/489
> 
>  .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  71 ++++
>  drivers/soc/imx/Makefile                           |   2 +-
>  drivers/soc/imx/gpcv2.c                            | 397 +++++++++++++++++++++
>  include/dt-bindings/power/imx7-power.h             |  18 +
>  4 files changed, 487 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
>  create mode 100644 drivers/soc/imx/gpcv2.c
>  create mode 100644 include/dt-bindings/power/imx7-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
> new file mode 100644
> index 0000000..393f68a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
> @@ -0,0 +1,71 @@
> +Freescale i.MX General Power Controller v2
> +==========================================
> +
> +The i.MX7S/D General Power Control (GPC) block contains Power Gating
> +Control (PGC) for various power domains.
> +
> +Required properties:
> +
> +- compatible: Should be "fsl,imx7d-gpc"
> +
> +- reg: should be register base and length as documented in the
> +  datasheet
> +
> +- interrupts: Should contain GPC interrupt request 1
> +
> +Power domains contained within GPC node are generic power domain
> +providers, documented in
> +Documentation/devicetree/bindings/power/power_domain.txt, which are
> +described as subnodes of the power gating controller 'pgc' node,
> +which, in turn, is expected to contain the following:
> +
> +Required properties:
> +
> +- reg: Power domain index. Valid values are defined in
> +  include/dt-bindings/power/imx7-power.h
> +
> +- #power-domain-cells: Should be 0
> +
> +Optional properties:
> +
> +- power-supply: Power supply used to power the domain
> +
> +Example:
> +
> +	gpc: gpc at 303a0000 {
> +		compatible = "fsl,imx7d-gpc";
> +		reg = <0x303a0000 0x1000>;
> +		interrupt-controller;
> +		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
> +
> +		pgc {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			pgc_pcie_phy: pgc-pcie-phy-domain {

power-domain at ...

> +				#power-domain-cells = <0>;
> +
> +				reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
> +				power-supply = <&reg_1p0d>;
> +			};
> +		};
> +	};
> +
> +
> +Specifying power domain for IP modules
> +======================================
> +
> +IP cores belonging to a power domain should contain a 'power-domains'
> +property that is a phandle for PGC node representing the domain.
> +
> +Example of a device that is part of the PCIE_PHY power domain:
> +
> +	pcie: pcie at 0x33800000 {

Drop the '0x'

With that, for the binding:

Acked-by: Rob Herring <robh@kernel.org>

> +	      reg = <0x33800000 0x4000>,
> +	            <0x4ff00000 0x80000>;
> +		/* ... */
> +		power-domains = <&pgc_pcie_phy>;
> +		/* ... */
> +	};

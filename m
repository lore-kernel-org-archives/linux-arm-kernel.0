From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 24 Jul 2018 18:52:32 +0200
Subject: [PATCH v3 1/2] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
In-Reply-To: <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
Message-ID: <1532451152.32306.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 24.07.2018, 19:14 +0300 schrieb Leonard Crestez:
> This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> 
> That commit followed the reference manual but unfortunately the imx7d
> manual is incorrect.
> 
> Tested with ath9k pcie card and confirmed internally.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/boot/dts/imx7d.dtsi | 12 ++++++++----
> ?1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 7cbc2ffa4b3a..7234e8330a57 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -124,14 +124,18 @@
> > ?		num-lanes = <1>;
> > ?		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > ?		interrupt-names = "msi";
> > ?		#interrupt-cells = <1>;
> > ?		interrupt-map-mask = <0 0 0 0x7>;
> > -		interrupt-map = <0 0 0 1 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> > -				<0 0 0 2 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > -				<0 0 0 3 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > -				<0 0 0 4 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> > +		/*
> > +		?* Reference manual lists pci irqs incorrectly
> > +		?* Real hardware ordering is same as imx6: D+MSI, C, B, A
> > +		?*/
> > +		interrupt-map = <0 0 0 1 &intc GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +				<0 0 0 2 &intc GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +				<0 0 0 3 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +				<0 0 0 4 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > ?		clocks = <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
> > ?			?<&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
> > ?			?<&clks IMX7D_PCIE_PHY_ROOT_CLK>;
> > ?		clock-names = "pcie", "pcie_bus", "pcie_phy";
> > ?		assigned-clocks = <&clks IMX7D_PCIE_CTRL_ROOT_SRC>,

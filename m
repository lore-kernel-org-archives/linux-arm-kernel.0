From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 08 Jan 2018 11:43:52 +0100
Subject: [PATCH v3] PCI: imx6: Add PHY reference clock source support
In-Reply-To: <1515073977-10153-1-git-send-email-ilya@compulab.co.il>
References: <CAOMZO5AFC9dxhsQjmRrDA7Z3KMkEemryKOBmQhXm19NXKxHkKQ@mail.gmail.com>
 <1515073977-10153-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1515408232.12538.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 04.01.2018, 15:52 +0200 schrieb Ilya Ledvich:
> i.MX7D variant of the IP can use either Crystal Oscillator input
> or internal clock input as a Reference Clock input for PCIe PHY.
> Add support for an optional property 'fsl,pcie-phy-refclk-internal'.
> If present then an internal clock input is used as PCIe PHY
> reference clock source. By default an external oscillator input
> is still used.
> 
> Verified on Compulab SBC-iMX7 Single Board Computer.

Sorry to get in late here, but I would rather have the external clock
input modeled as a real clock and only use the internal clock if that
isn't present.

Are you even sure that the i.MX7 clock you mention isn't the already
documented "pcie_bus" clock? This one is also allowed to be sourced
externally on the i.MX6.

Regards,
Lucas

> Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
> ---
> changes since V2:
> 	add a vendor prefix 'fsl' to a new property
> 
> ?Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
> ?drivers/pci/dwc/pci-imx6.c???????????????????????????????| 8
> +++++++-
> ?2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt 
> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 7b1e48b..1591a6a 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -50,6 +50,11 @@ Additional required properties for imx7d-pcie:
> ?	???????- "pciephy"
> ?	???????- "apps"
> ?
> +Additional optional properties for imx7d-pcie:
> +- fsl,pcie-phy-refclk-internal: If present then an internal PLL
> input is used
> +??as PCIe PHY reference clock source. By default an external
> oscillator input
> +??is used.
> +
> ?Example:
> ?
> ?	pcie at 0x01000000 {
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index b734835..36812d3 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -61,6 +61,7 @@ struct imx6_pcie {
> ?	u32			tx_swing_low;
> ?	int			link_gen;
> ?	struct regulator	*vpcie;
> +	bool			pciephy_refclk_sel;
> ?};
> ?
> ?/* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -474,7 +475,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie
> *imx6_pcie)
> ?	switch (imx6_pcie->variant) {
> ?	case IMX7D:
> ?		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
> -				???IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> 0);
> +				???IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				???imx6_pcie->pciephy_refclk_sel ?
> +				???IMX7D_GPR12_PCIE_PHY_REFCLK_SEL :
> 0);
> ?		break;
> ?	case IMX6SX:
> ?		regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
> @@ -840,6 +843,9 @@ static int imx6_pcie_probe(struct platform_device
> *pdev)
> ?		imx6_pcie->vpcie = NULL;
> ?	}
> ?
> +	imx6_pcie->pciephy_refclk_sel =
> +		of_property_read_bool(node, "fsl,pcie-phy-refclk-
> internal");
> +
> ?	platform_set_drvdata(pdev, imx6_pcie);
> ?
> ?	ret = imx6_add_pcie_port(imx6_pcie, pdev);

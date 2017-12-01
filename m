From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Dec 2017 18:21:22 -0200
Subject: [PATCH 8/8] PCIe: imx6: imx7d: add support for phy refclk source
In-Reply-To: <20171130201434.14122-9-tyler@opensourcefoundries.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
 <20171130201434.14122-9-tyler@opensourcefoundries.com>
Message-ID: <CAOMZO5Cxavb+iXdxH=JiWzP4VVo-ue0PU-LjBE6kD1VBPgW_0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 6:14 PM,  <tyler@opensourcefoundries.com> wrote:
> From: Tyler Baker <tyler@opensourcefoundries.com>
>
> In the i.MX7D the PCIe PHY can use either externel oscillator or
> internal PLL as a reference clock source.
> Add support for the PHY Reference Clock source including
> device tree property phy-ref-clk.
> External oscillator is used as a default reference clock source.
>
> Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
> Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>

Please submit this one to the PCI list and PCI maintainers.

As you are adding a new property you should update
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt.

> ---
>  drivers/pci/dwc/pci-imx6.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index b734835..e935db4 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -45,6 +45,7 @@ enum imx6_pcie_variants {
>  struct imx6_pcie {
>         struct dw_pcie          *pci;
>         int                     reset_gpio;
> +       u32                     phy_refclk;

Could this be bool instead?

>         bool                    gpio_active_high;
>         struct clk              *pcie_bus;
>         struct clk              *pcie_phy;
> @@ -474,7 +475,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>         switch (imx6_pcie->variant) {
>         case IMX7D:
>                 regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -                                  IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
> +                                  BIT(5), imx6_pcie->phy_refclk ? BIT(5) : 0);
>                 break;
>         case IMX6SX:
>                 regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> @@ -733,6 +734,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         if (IS_ERR(pci->dbi_base))
>                 return PTR_ERR(pci->dbi_base);
>
> +       /* Fetch PHY Reference Clock */
> +       if (of_property_read_u32(node, "phy-ref-clk", &imx6_pcie->phy_refclk))

You could use of_property_read_bool instead.

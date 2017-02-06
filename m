From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 06 Feb 2017 16:33:37 +0100
Subject: [PATCH v3 3/3] PCI: imx6: Add code to support i.MX7D
In-Reply-To: <20170206151716.10381-4-andrew.smirnov@gmail.com>
References: <20170206151716.10381-1-andrew.smirnov@gmail.com>
 <20170206151716.10381-4-andrew.smirnov@gmail.com>
Message-ID: <1486395217.2275.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 06.02.2017, 07:17 -0800 schrieb Andrey Smirnov:
> Add various bits of code needed to support i.MX7D variant of the IP.
> 
> Cc: yurovsky at gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Two small comments inline, otherwise looks real good now.

> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 121 ++++++++++++++++-----
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  3 files changed, 105 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 83aeb1f..9f57759 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,7 +4,11 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
> +- compatible:
> +	- "fsl,imx6q-pcie"
> +	- "fsl,imx6sx-pcie",
> +	- "fsl,imx6qp-pcie"
> +	- "fsl,imx7d-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.

This misses an "Additional required properties for imx7d-pcie" section
listing the required reset handles.

> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 3ef8093..34a21c9 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c

[...]

>  static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>  	struct pcie_port *pp = &imx6_pcie->pp;
> @@ -381,6 +416,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  	}
>  
>  	switch (imx6_pcie->variant) {
> +	case IMX7D:
> +		reset_control_assert(imx6_pcie->apps_reset);

Can this reset assertion be moved into imx6_pcie_assert_core_reset()?
This may change the programming order slightly from the downstream
driver, but I guess that won't hurt if this is the equivalent of the
LTSSM enable signal.

Regards,
Lucas

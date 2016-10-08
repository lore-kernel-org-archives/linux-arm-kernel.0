From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 15:49:59 -0500
Subject: [PATCH v6 3/3] pci:add support aer/pme interrupts with none
 MSI/MSI-X/INTx mode
In-Reply-To: <1475226697-7709-3-git-send-email-po.liu@nxp.com>
References: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
 <1475226697-7709-1-git-send-email-po.liu@nxp.com>
 <1475226697-7709-3-git-send-email-po.liu@nxp.com>
Message-ID: <20161008204959.GA17455@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 05:11:37PM +0800, Po Liu wrote:
> On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
> When chip support the aer/pme interrupts with none MSI/MSI-X/INTx mode,
> maybe there is interrupt line for aer pme etc. Search the interrupt
> number in the fdt file. Then fixup the dev->irq with it.

Again, explain why you are breaking compatibility. Will an old dtb using 
"intr" still work with this change? It should normally. There are some 
exceptions, but you need to say what they are.

> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> changes for v6:
> 	- modify bindings for "aer""pme";
> 	- changing to the hood method to implement the aer pme interrupt;
> 	- add pme interrupt in the same way;
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     | 13 +++++--
>  arch/arm/kernel/bios32.c                           | 43 ++++++++++++++++++++++
>  arch/arm64/kernel/pci.c                            | 43 ++++++++++++++++++++++
>  drivers/pci/pcie/portdrv_core.c                    | 31 +++++++++++++++-
>  include/linux/pci.h                                |  1 +
>  5 files changed, 126 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 41e9f55..51ed49e 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -18,8 +18,12 @@ Required properties:
>  - reg: base addresses and lengths of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -  "intr": The interrupt that is asserted for controller interrupts
> +- interrupt-names: It could include the following entries:

"Could" is not strong enough. Every valid combination of interrupts 
should correspond to a specific compatible string. A given version of 
h/w either has these interrupts or not.

> +  "aer": Asserted for aer interrupt when chip support the aer interrupt with
> +		 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
> +  "pme": Asserted for pme interrupt when chip support the pme interrupt with
> +		 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
> +  ......
>  - fsl,pcie-scfg: Must include two entries.
>    The first entry must be a link to the SCFG device node
>    The second entry must be '0' or '1' based on physical PCIe controller index.

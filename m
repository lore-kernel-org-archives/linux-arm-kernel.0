From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Oct 2016 11:31:16 +0100
Subject: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
In-Reply-To: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20161026103101.GC19965@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 08:35:40PM +0800, Minghuan Lian wrote:
> 1. The different version of a SoC may have different MSI
> implementation. But compatible "fsl,<soc-name>-msi" can not describe
> the SoC version. 

Surely, "fsl,<soc-name>-<rev>-msi" can describe this?

If the hardware differs, it needs a new compatible string.

If there's some configuration value that varies across revisions (e.g.
number of slots), you can add a proeprty to describe that explciitly.

> The MSI driver will use SoC match interface to get
> SoC type and version instead of compatible string. So all MSI node
> can use the common compatible "fsl,ls-scfg-msi" and the original
> compatible is unnecessary.
> 
> 2. Layerscape SoCs may have one or several MSI controllers.
> In order to increase MSI interrupt number of a PCIe, the patch
> moves all MSI node into the parent node "msi-controller". So a
> PCIe can request MSI from all the MSI controllers.

This is not necessary, and does not represent a real block of hardware.
So NAK for this approach.

The msi-parent property can contain a list of MSI controllers. See the
examples in
Documentation/devicetree/bindings/interrupt-controller/msi.txt.
Likewise, the msi-map property can map to a number of MSI controllers.

If the core code can only consider one at a time, then that's an issue
to be addressed in core code, not one to be bodged around in bindings.

> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       | 57 +++++++++++++++++++---
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> index 9e38949..29f95fd 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> @@ -1,18 +1,28 @@
>  * Freescale Layerscape SCFG PCIe MSI controller
>  
> +Layerscape SoCs may have one or multiple MSI controllers.
> +Each MSI controller must be showed as a child node.
> +
>  Required properties:
>  
> -- compatible: should be "fsl,<soc-name>-msi" to identify
> -	      Layerscape PCIe MSI controller block such as:
> -              "fsl,1s1021a-msi"
> -              "fsl,1s1043a-msi"
> +- compatible: should be "fsl,ls-scfg-msi"

This breaks old DTBs, and throws away information which you describe
above as valuable. So another NAK for that.

> +- #address-cells: must be 2
> +- #size-cells: must be 2
> +- ranges: allows valid 1:1 translation between child's address space and
> +	  parent's address space
>  - msi-controller: indicates that this is a PCIe MSI controller node
> +
> +Required child node:
> +A child node must exist to represent the MSI controller.
> +The following are properties specific to those nodes:

Also, as above, the approach of gathering MSI controllers in this manner
is wrong.

Thanks,
Mark.

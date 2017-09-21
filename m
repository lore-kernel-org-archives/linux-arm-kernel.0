From: leoyang.li@nxp.com (Leo Li)
Date: Thu, 21 Sep 2017 18:36:47 +0000
Subject: [v5 04/12] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
In-Reply-To: <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-5-git-send-email-roy.pledge@nxp.com>
Message-ID: <AM4PR0401MB1699D419007FB551153BD9CD8F660@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Roy Pledge [mailto:roy.pledge at nxp.com]
> Sent: Monday, September 18, 2017 3:40 PM
> To: Leo Li <leoyang.li@nxp.com>; linuxppc-dev at lists.ozlabs.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Cc: oss at buserror.net; Madalin-cristian Bucur <madalin.bucur@nxp.com>;
> catalin.marinas at arm.com; linux at armlinux.org.uk; arnd at arndb.de;
> mark.rutland at arm.com; Roy Pledge <roy.pledge@nxp.com>
> Subject: [v5 04/12] dt-bindings: soc/fsl: Update reserved memory binding for
> QBMan
> 
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatible with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Hi Rob and Mark,

Would you help to review this binding patch and ACK if it is ok?

Regards,
Leo

> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++++++++++++++-
> -----
>  2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> index 47ac834..48eed14 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> @@ -65,8 +65,8 @@ to the respective BMan instance
>  BMan Private Memory Node
> 
>  BMan requires a contiguous range of physical memory used for the backing
> store
> -for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/allocated
> as a
> -node under the /reserved-memory node
> +for BMan Free Buffer Proxy Records (FBPR). This memory is reserved/allocated
> as
> +a node under the /reserved-memory node.
> 
>  The BMan FBPR memory node must be named "bman-fbpr"
> 
> @@ -75,7 +75,9 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,bman-fbpr"
> +	Definition:	PPC platforms: Must include "fsl,bman-fbpr"
> +			ARM platforms: Must include "shared-dma-pool"
> +				       as well as the "no-map" property
> 
>  The following constraints are relevant to the FBPR private memory:
>  	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB to
> @@ -100,10 +102,10 @@ The example below shows a BMan FBPR dynamic
> allocation memory node
>  		ranges;
> 
>  		bman_fbpr: bman-fbpr {
> -			compatible = "fsl,bman-fbpr";
> -			alloc-ranges = <0 0 0x10 0>;
> +			compatible = "shared-mem-pool";
>  			size = <0 0x1000000>;
>  			alignment = <0 0x1000000>;
> +			no-map;
>  		};
>  	};
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/qman.txt
> b/Documentation/devicetree/bindings/soc/fsl/qman.txt
> index 556ebb8..ee96afd 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/qman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/qman.txt
> @@ -60,6 +60,12 @@ are located at offsets 0xbf8 and 0xbfc
>  	Value type:	<prop-encoded-array>
>  	Definition:	Reference input clock. Its frequency is half of the
>  			platform clock
> +- memory-regions
> +	Usage:		Required for ARM
> +	Value type:	<phandle array>
> +	Definition:	List of phandles referencing the QMan private memory
> +			nodes (described below). The qman-fqd node must be
> +			first followed by qman-pfdr node. Only used on ARM
> 
>  Devices connected to a QMan instance via Direct Connect Portals (DCP) must
> link
>  to the respective QMan instance
> @@ -74,7 +80,9 @@ QMan Private Memory Nodes
> 
>  QMan requires two contiguous range of physical memory used for the backing
> store
>  for QMan Frame Queue Descriptor (FQD) and Packed Frame Descriptor Record
> (PFDR).
> -This memory is reserved/allocated as a nodes under the /reserved-memory
> node
> +This memory is reserved/allocated as a node under the /reserved-memory
> node.
> +
> +For additional details about reserved memory regions see reserved-memory.txt
> 
>  The QMan FQD memory node must be named "qman-fqd"
> 
> @@ -83,7 +91,9 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,qman-fqd"
> +	Definition:	PPC platforms: Must include "fsl,qman-fqd"
> +			ARM platforms: Must include "shared-dma-pool"
> +				       as well as the "no-map" property
> 
>  The QMan PFDR memory node must be named "qman-pfdr"
> 
> @@ -92,7 +102,9 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,qman-pfdr"
> +	Definition:	PPC platforms: Must include "fsl,qman-pfdr"
> +			ARM platforms: Must include "shared-dma-pool"
> +				       as well as the "no-map" property
> 
>  The following constraints are relevant to the FQD and PFDR private memory:
>  	- The size must be 2^(size + 1), with size = 11..29. That is 4 KiB to
> @@ -117,16 +129,16 @@ The example below shows a QMan FQD and a PFDR
> dynamic allocation memory nodes
>  		ranges;
> 
>  		qman_fqd: qman-fqd {
> -			compatible = "fsl,qman-fqd";
> -			alloc-ranges = <0 0 0x10 0>;
> +			compatible = "shared-dma-pool";
>  			size = <0 0x400000>;
>  			alignment = <0 0x400000>;
> +			no-map;
>  		};
>  		qman_pfdr: qman-pfdr {
> -			compatible = "fsl,qman-pfdr";
> -			alloc-ranges = <0 0 0x10 0>;
> +			compatible = "shared-dma-pool";
>  			size = <0 0x2000000>;
>  			alignment = <0 0x2000000>;
> +			no-map;
>  		};
>  	};
> 
> --
> 2.7.4

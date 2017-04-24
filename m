From: oss@buserror.net (Scott Wood)
Date: Sun, 23 Apr 2017 20:09:57 -0500
Subject: [PATCH v2 03/11] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
In-Reply-To: <1492634930-10765-4-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
 <1492634930-10765-4-git-send-email-roy.pledge@nxp.com>
Message-ID: <1492996197.25397.12.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-19 at 16:48 -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatiable with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
> ?Documentation/devicetree/bindings/soc/fsl/bman.txt | 11 ++++++-----
> ?Documentation/devicetree/bindings/soc/fsl/qman.txt | 18 +++++++++++-------
> ?2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> index 47ac834..3cd1e2c 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> @@ -65,8 +65,8 @@ to the respective BMan instance
> ?BMan Private Memory Node
> ?
> ?BMan requires a contiguous range of physical memory used for the backing
> store
> -for BMan Free Buffer Proxy Records (FBPR). This memory is
> reserved/allocated as a
> -node under the /reserved-memory node
> +for BMan Free Buffer Proxy Records (FBPR). This memory is
> reserved/allocated as
> +a node under the /reserved-memory node.
> ?
> ?The BMan FBPR memory node must be named "bman-fbpr"
> ?
> @@ -75,7 +75,8 @@ PROPERTIES
> ?- compatible
> ?	Usage:		required
> ?	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,bman-fbpr"
> +	Definition:	PPC platforms: Must include "fsl,bman-fbpr"
> +			ARM platforms: Must include "shared-dma-pool"
> ?
> ?The following constraints are relevant to the FBPR private memory:
> ?	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB
> to
> @@ -100,10 +101,10 @@ The example below shows a BMan FBPR dynamic allocation
> memory node
> ?		ranges;
> ?
> ?		bman_fbpr: bman-fbpr {
> -			compatible = "fsl,bman-fbpr";
> -			alloc-ranges = <0 0 0x10 0>;
> +			compatible = "shared-mem-pool";
> ?			size = <0 0x1000000>;
> ?			alignment = <0 0x1000000>;
> +			no-map;
> ?		};
> ?	};
> ?

The requirement for using no-map with shared-mem-pool should be explicitly
stated, not just in the example.

-Scott

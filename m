From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Jan 2017 09:26:13 -0600
Subject: [PATCH v4 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1483536954-27203-3-git-send-email-appanad@xilinx.com>
References: <1483536954-27203-1-git-send-email-appanad@xilinx.com>
 <1483536954-27203-3-git-send-email-appanad@xilinx.com>
Message-ID: <20170104152613.hhdptwsyg73ev3dz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 07:05:53PM +0530, Kedareswara rao Appana wrote:
> When VDMA is configured for more than one frame in the h/w
> for example h/w is configured for n number of frames and user
> Submits n number of frames and triggered the DMA using issue_pending API.
> In the current driver flow we are submitting one frame at a time
> but we should submit all the n number of frames at one time as the h/w
> Is configured for n number of frames.

Please fix run-on sentences, capitalization, and word wrapping.

> 
> This patch fixes this issue.
> 
> Reviewed-by: Jose Abreu <joabreu@synopsys.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v4:
> ---> Add Check for framestore configuration on Transmit case as well
>      as suggested by Jose Abreu.
> ---> Modified the dev_dbg checks to dev_warn checks as suggested
>      by Jose Abreu. 
> Changes for v3:
> ---> Added Checks for frame store configuration. If frame store
>      Configuration is not present at the h/w level and user
>      Submits less frames added debug prints in the driver as relevant.
> Changes for v2:
> ---> Fixed race conditions in the driver as suggested by Jose Abreu
> ---> Fixed unnecessray if else checks in the vdma_start_transfer
>      as suggested by Laurent Pinchart.
> 
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  2 +
>  drivers/dma/xilinx/xilinx_dma.c                    | 79 +++++++++++++++-------
>  2 files changed, 58 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfa..1f65e09 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -66,6 +66,8 @@ Optional child node properties:
>  Optional child node properties for VDMA:
>  - xlnx,genlock-mode: Tells Genlock synchronization is
>  	enabled/disabled in hardware.
> +- xlnx,fstore-config: Tells Whether Frame Store Configuration is
> +	enabled/disabled in hardware.

What's the default (when not present)? That should be the most 
common case. Looks like the code treats this as bool, but that's 
not clear here. The name is not clear what it is doing. Enabling or 
disabling the feature?


>  Optional child node properties for AXI DMA:
>  -dma-channels: Number of dma channels in child node.
>  

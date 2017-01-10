From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 23:35:40 -0600
Subject: [PATCH v5 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <1483771530-8545-3-git-send-email-appanad@xilinx.com>
References: <1483771530-8545-1-git-send-email-appanad@xilinx.com>
 <1483771530-8545-3-git-send-email-appanad@xilinx.com>
Message-ID: <20170110053540.qiowb4pfmwvwpkte@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 12:15:29PM +0530, Kedareswara rao Appana wrote:
> When VDMA is configured for more than one frame in the h/w
> for example h/w is configured for n number of frames and user
> Submits n number of frames and triggered the DMA using issue_pending API.
> In the current driver flow we are submitting one frame at a time
> but we should submit all the n number of frames at one time as the h/w
> Is configured for n number of frames.
> 
> This patch fixes this issue.
> 
> Reviewed-by: Jose Abreu <joabreu@synopsys.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v5:
> ---> Updated xlnx,fstore-config property to xlnx,fstore-enable
>      and updated description as suggested by Rob.
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

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/dma/xilinx/xilinx_dma.c                    | 78 +++++++++++++++-------
>  2 files changed, 57 insertions(+), 23 deletions(-)

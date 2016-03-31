From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Mar 2016 09:42:09 -0500
Subject: [PATCH v2 4/8] drm/fsl-dcu: add extra clock for pixel clock
In-Reply-To: <1459216802-32094-5-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
 <1459216802-32094-5-git-send-email-stefan@agner.ch>
Message-ID: <20160331144209.GA28867@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 06:59:58PM -0700, Stefan Agner wrote:
> The Vybrid DCU variant has two independent clock inputs, one
> for the registers (IPG bus clock) and one for the pixel clock.
> Support this distinction in the DCU DRM driver while staying
> backward compatible with devices providing only a single clock
> (e.g. LS1021a SoC's).

I'd suspect that both have 2 clocks, just the LS1021a either didn't 
model the IPG clock or connects both to the same source. The driver 
should support both, but all the dts's should be updated to have 2 
clocks.

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/display/fsl,dcu.txt |  4 ++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c            |  2 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c             | 16 +++++++++++++++-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h             |  1 +
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,dcu.txt b/Documentation/devicetree/bindings/display/fsl,dcu.txt
> index ebf1be9..f299e1e 100644
> --- a/Documentation/devicetree/bindings/display/fsl,dcu.txt
> +++ b/Documentation/devicetree/bindings/display/fsl,dcu.txt
> @@ -11,6 +11,10 @@ Required properties:
>  - big-endian		Boolean property, LS1021A DCU registers are big-endian.
>  - fsl,panel:		The phandle to panel node.
>  
> +Optional properties:
> +- clocks:		Second handle for pixel clock.
> +- clock-names:		Second name "pix" for pixel clock.

Document these in one place and just add a note that LS1021a only has 1 
clock.

> +
>  Examples:
>  dcu: dcu at 2ce0000 {
>  	compatible = "fsl,ls1021a-dcu";
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c

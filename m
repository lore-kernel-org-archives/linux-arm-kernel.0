From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 10:13:56 -0500
Subject: [PATCH v2 6/6] fsl_pmc: update device bindings
In-Reply-To: <20180411063551.30368-6-ran.wang_1@nxp.com>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
 <20180411063551.30368-6-ran.wang_1@nxp.com>
Message-ID: <20180416151356.r7si6higfrovl53l@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 02:35:51PM +0800, Ran Wang wrote:
> From: Li Yang <leoli@freescale.com>

Needs a commit msg and the subject should give some indication of what 
the update is. And also start with "dt-bindings: ..."

> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - new file
> 
>  .../devicetree/bindings/powerpc/fsl/pmc.txt        |   59 +++++++++++--------
>  1 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> index 07256b7..f1f749f 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
> @@ -9,15 +9,20 @@ Properties:
>  
>    "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
>    compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
> -  whose PMC is compatible, and implies deep-sleep capability.
> +  whose PMC is compatible, and implies deep-sleep capability and
> +  wake on user defined packet(wakeup on ARP).
> +
> +  "fsl,p1022-pmc" should be listed for any chip whose PMC is
> +  compatible, and implies lossless Ethernet capability during sleep.
>  
>    "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
>    compatible; all statements below that apply to "fsl,mpc8548-pmc" also
>    apply to "fsl,mpc8641d-pmc".
>  
>    Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
> -  bit assignments are indicated via the sleep specifier in each device's
> -  sleep property.
> +  bit assignments are indicated via the clock nodes.  Device which has a
> +  controllable clock source should have a "fsl,pmc-handle" property pointing
> +  to the clock node.
>  
>  - reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
>    is the PMC block, and the second resource is the Clock Configuration
> @@ -33,31 +38,35 @@ Properties:
>    this is a phandle to an "fsl,gtm" node on which timer 4 can be used as
>    a wakeup source from deep sleep.
>  
> -Sleep specifiers:
> +Clock nodes:
> +The clock nodes are to describe the masks in PM controller registers for each
> +soc clock.
> +- fsl,pmcdr-mask: For "fsl,mpc8548-pmc"-compatible devices, the mask will be
> +  ORed into PMCDR before suspend if the device using this clock is the wake-up
> +  source and need to be running during low power mode; clear the mask if
> +  otherwise.
>  
> -  fsl,mpc8349-pmc: Sleep specifiers consist of one cell.  For each bit
> -  that is set in the cell, the corresponding bit in SCCR will be saved
> -  and cleared on suspend, and restored on resume.  This sleep controller
> -  supports disabling and resuming devices at any time.
> +- fsl,sccr-mask: For "fsl,mpc8349-pmc"-compatible devices, the corresponding
> +  bit specified by the mask in SCCR will be saved and cleared on suspend, and
> +  restored on resume.
>  
> -  fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
> -  which will be ORed into PMCDR upon suspend, and cleared from PMCDR
> -  upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
> -  This sleep controller only supports disabling devices during system
> -  sleep, or permanently.
> -
> -  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
> -  first of which will be ORed into DEVDISR (and the second into
> -  DEVDISR2, if present -- this cell should be zero or absent if the
> -  hardware does not have DEVDISR2) upon a request for permanent device
> -  disabling.  This sleep controller does not support configuring devices
> -  to disable during system sleep (unless supported by another compatible
> -  match), or dynamically.

You seem to be breaking backwards compatibility with this change. I 
doubt that is okay on these platforms.


> +- fsl,devdisr-mask: Contain one or two cells, depending on the availability of
> +  DEVDISR2 register.  For compatible devices, the mask will be ORed into DEVDISR
> +  or DEVDISR2 when the clock should be permenently disabled.
>  
>  Example:
>  
> -	power at b00 {
> -		compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
> -		reg = <0xb00 0x100 0xa00 0x100>;
> -		interrupts = <80 8>;
> +	power at e0070 {
> +		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
> +		reg = <0xe0070 0x20>;
> +
> +		etsec1_clk: soc-clk at 24 {
> +			fsl,pmcdr-mask = <0x00000080>;
> +		};
> +		etsec2_clk: soc-clk at 25 {
> +			fsl,pmcdr-mask = <0x00000040>;
> +		};
> +		etsec3_clk: soc-clk at 26 {
> +			fsl,pmcdr-mask = <0x00000020>;
> +		};
>  	};
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

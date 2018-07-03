From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 14:59:32 -0600
Subject: [PATCH 4/8] dt-bindings: add bindings for TI PRU as remoteproc
In-Reply-To: <20180623210810.21232-5-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <20180623210810.21232-5-david@lechnology.com>
Message-ID: <20180703205932.GA28054@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 23, 2018 at 04:08:06PM -0500, David Lechner wrote:
> This adds a new binding for the TI Programmable Runtime Unit (PRU)
> as a remoteproc device.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/remoteproc/ti_pru_rproc.txt      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> new file mode 100644
> index 000000000000..0e80a8db46d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> @@ -0,0 +1,51 @@
> +TI Programmable Realtime Unit (PRU)
> +===================================
> +
> +Some TI Sitara SoCs contain a Programmable Realtime Unit subsystem with two
> +processor cores that can be used for hard-realtime tasks.
> +
> +
> +Required properties:
> +--------------------
> +The following are the mandatory properties:
> +
> +- compatible:		Should be one of the following,
> +			    "ti,da850-pru-rproc" for AM18xx/OMAPL138 SoCs
> +			    "ti,am3352-pru-rproc" for AM355x SoCs
> +
> +- reg:			Should contain the memory region for the PRUSS
> +
> +- interrupts: 		Should contain the interrupt number used to receive the
> +			virtualqueue kick interrupts from the PRU (i.e.
> +			PRU_EVTOUT0 and PRU_EVTOUT1)
> +
> +- interrupt-names	Should contain "pru0-vq", "pru1-vq"
> +
> +Optional properties:
> +--------------------
> +
> +- power-domains:	A phandle to the power domain that powers the PRUSS

Only for da850?

> +
> +- ti,hwmods:		Name of the hwmod associated to the PRUSS, which is
> +			typically "pruss"

Only for am3352?

typically? You should enumerate possible values.

> +
> +Example:
> +--------
> +
> +	// AM18xx
> +	pru_rproc: cpu at 30000 {

cpu is reserved for cpu nodes.

> +		compatible = "ti,da850-pru-rproc";
> +		reg = <0x30000 0x10000>;
> +		interrupts = <3>, <4>;
> +		interrupt-names = "pru0-vq", "pru1-vq";
> +		power-domains = <&psc0 13>;
> +	};
> +
> +	// AM335x
> +	pru_rproc: cpu at 4a300000 {
> +		compatible = "ti,am3352-pru-rproc";
> +		reg = <0x4a300000 0x80000>;
> +		interrupts = <20>, <21>;
> +		interrupt-names = "pru0-vq", "pru1-vq";
> +		ti,hwmods = "pruss";
> +	};

Really need 2 examples?

> -- 
> 2.17.1
> 

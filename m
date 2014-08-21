From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Thu, 21 Aug 2014 13:15:05 +0200
Subject: [PATCH v4] coresight: bindings for coresight drivers
In-Reply-To: <1408554698-24459-1-git-send-email-mathieu.poirier@linaro.org>
References: <1408554698-24459-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <53F5D4B9.5060305@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 20.08.2014 19:11, schrieb mathieu.poirier at linaro.org:
> From: Pratik Patel <pratikp@codeaurora.org>
> 
> Coresight IP blocks allow for the support of HW assisted tracing
> on ARM SoCs.  Bindings for the currently available blocks are
> presented herein.
> 
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 205 +++++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> new file mode 100644
> index 0000000..2ee594d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -0,0 +1,205 @@
> +* CoreSight Components
> +
> +CoreSight components are compliant with the ARM CoreSight architecture
> +specification and can be connected in various topologies to suit a particular
> +SoCs tracing needs. These trace components can generally be classified as sinks,
> +links and sources. Trace data produced by one or more sources flows through the
> +intermediate links connecting the source to the currently selected sink. Each
> +CoreSight component device should use these properties to describe its hardware
> +characteristcs.
> +
> +Required properties for all components *except* non-configurable replicators:
> +
> +- compatible : name of the component used for driver matching.  Possible values
> +include: "arm,coresight-etb10", "arm,coresight-tpiu", "arm,coresight-tmc",
> +"arm,coresight-funnel", and "arm,coresight-etm3x".  All of these have to
> +be supplemented with "arm,primecell" as drivers are using the AMBA bus
> +interface.  Since non-configurable replicators don't show up on the AMBA
> +bus they don't need to be post-fixed with "arm,primecell".

I think this document would be much easier to read if you indented these
paragraphs below "name" here. That way the actual property names would
stand out more when looking up a particular property.

> +
> +- reg : physical base address and length of the register set(s) of the component.
> +
> +- clocks : the clock associated to this component.
> +
> +- clock-names: the name of the clock as referenced by the code.  Since we are
> +using the AMBA framework, the name should be "apb_pclk".
> +
> +- ports or port: The representation of the component's port layout using the
> +generic DT graph presentation found in "bindings/graph.txt".
> +
> +Non-configurable replicators:
> +
> +- compatible: currently supported value is "arm-replicator".  Since non-configurable
> +replicators don't show up on the AMBA hey don't need to be post-fixed with
> +"arm,primecell".
> +
> +- id: a unique number that will identify this replicator.
> +
> +- ports or port: same as above.
> +
> +Optional properties for Sinks:
> +
> +- coresight-default-sink: must be specified for one of the sink devices that is
> +intended to be made the default sink. Other sink devices must not have this
> +specified. Not specifying this property on any of the sinks is invalid.
> +
> +Optional properties for ETM/PTMs:
> +
> +- arm,cp14: must be present if the system accesses ETM/PTM management registers
> +via co-processor 14.
> +
> +- arm,cp14: access to ETM/PTM management registers is made via cp14.
> +
> +- cpu: the cpu phandle this ETM/PTM is affined to. When omitted the source is
> +considered to belong to CPU0.
> +
> +Optional property for TMC:
> +
> +- arm,buffer-size: size of contiguous buffer space for TMC ETR (embedded trace router)
> +
> +
> +Example:
> +
> +1. Sinks
> +	etb: etb at 20010000 {
> +		compatible = "arm,coresight-etb10", "arm,primecell";
> +		reg = <0 0x20010000 0 0x1000>;

You seem to be using two address cells (and two size cells). In that
case, I believe I read it were convention to use etb at 0,20010000?

Regards,
Andreas

> +
> +		coresight-default-sink;
> +		clocks = <&oscclk6a>;
> +		clock-names = "apb_pclk";
> +		port {
> +			etb_in_port: endpoint at 0 {
> +				slave-mode;
> +				remote-endpoint = <&replicator_out_port0>;
> +			};
> +		};
> +	};
[snip]


-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 16 Aug 2013 13:47:18 -0500
Subject: [PATCH v2] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <4698B009-124E-4D51-868B-336F80A7D7F8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 16, 2013, at 12:19 PM, Punit Agrawal wrote:

> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated view
> of the bus traffic between the various components connected to the CCI.
> 
> Extend the existing CCI driver to support the PMU by registering a perf
> backend for it.
> 
> Document the device tree binding to describe the CCI PMU.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
> 
> Hi, 
> 
> This is the second version of the CCI PMU driver. The changes incorporate review
> comments on device tree bindings and corresponding update to the driver.
> 
> Cheers,
> Punit
> 
> Will, I've dropped your reviewed-by tag due to the changes. Let me know if you are
> ok with the changes and I'll add the tag.
> 
> Changes since v1:
> * Dropped requirement for node name.
> * Dropped compatible strings for different revisions - rely on peripheral id
>  register to provide the revision.
> * Change interrupt bindings to require overflow interrupt per counter.
> 
> Documentation/devicetree/bindings/arm/cci.txt |   44 ++
> drivers/bus/arm-cci.c                         |  628 +++++++++++++++++++++++++
> 2 files changed, 672 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
> index 92d36e2..7cf35bc 100644
> --- a/Documentation/devicetree/bindings/arm/cci.txt
> +++ b/Documentation/devicetree/bindings/arm/cci.txt
> @@ -79,6 +79,40 @@ specific to ARM.
> 				    corresponding interface programming
> 				    registers.
> 
> +	- CCI PMU node
> +
> +		Parent node must be CCI interconnect node.
> +
> +		A CCI pmu node must contain the following properties:
> +
> +		- compatible
> +			Usage: required
> +			Value type: <string>
> +			Definition: must be "arm,cci-400-pmu"
> +
> +		- reg:
> +			Usage: required
> +			Value type: <prop-encoded-array>
> +			Definition: the base address and size of the
> +				    corresponding interface programming
> +				    registers.
> +
> +		- interrupts:
> +			Usage: required
> +			Value type: <prop-encoded-array>
> +			Definition: comma-separated list of counter overflow
> +				    interrupts, one per counter. The interrupts
> +				    must be specified starting with the cycle
> +				    counter overflow interrupt, followed by
> +				    counter0 overflow interrupt, counter1
> +				    overflow interrupt,..., counterN overflow
> +				    interrupt.
> +
> +				    The CCI PMU has an interrupt signal for each
> +				    counter. Typically, the number of
> +				    interrupts will be equal to the number of
> +				    counters.
> +
> * CCI interconnect bus masters
> 
> 	Description: masters in the device tree connected to a CCI port
> @@ -163,6 +197,16 @@ Example:
> 			interface-type = "ace";
> 			reg = <0x5000 0x1000>;
> 		};
> +
> +		pmu at 9000 {
> +			 compatible = "arm,cci-400-pmu,rev0";

drop the ',rev0'

> +			 reg = <0x9000 0x5000>;
> +			 interrupts = <0 101 4>,
> +				      <0 102 4>,
> +				      <0 103 4>,
> +				      <0 104 4>,
> +				      <0 105 4>;
> +		};
> 	};
> 
> This CCI node corresponds to a CCI component whose control registers sits

[snip]

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

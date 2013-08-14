From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 15:06:26 -0600
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <520BF152.1020704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 03:19 AM, Punit Agrawal wrote:
> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated view
> of the bus traffic between the various components connected to the CCI.
> 
> Extend the existing CCI driver to support the PMU by registering a perf
> backend for it.
> 
> Document the device tree binding to describe the CCI PMU.

> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt

> +	- CCI PMU node
> +
> +		Node name must be "pmu".

I don't think the binding should require the node to have a particular
name; node names shouldn't be interpret/used/relied-upon by drivers.

> +		Parent node must be CCI interconnect node.
> +
> +		A CCI pmu node must contain the following properties:
> +
> +		- compatible
> +			Usage: required
> +			Value type: <string>
> +			Definition: must be set to one of
> +				    "arm,cci-400-pmu"
> +				    "arm,cci-400-pmu,rev0"
> +				    "arm,cci-400-pmu,rev1"

What is the first entry in this list for; why wouldn't you always use
one of the two versioned compatible values?

The use of , before revN is a little unusual; I would have expected
arm,cci-400-pmu-rev0, but this isn't a big deal.

> +		- interrupts:
> +			Usage: required
> +			Value type: <prop-encoded-array>
> +			Definition: comma-separated list of unique PMU
> +				    interrupts

Is there more than one interrupt? The text seems to imply that. If so,
what are they, and which order must they appear?

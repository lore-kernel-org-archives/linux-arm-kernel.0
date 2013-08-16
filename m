From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 12:31:57 -0600
Subject: [PATCH v2] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <520E701D.6040006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 11:19 AM, Punit Agrawal wrote:
> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated view
> of the bus traffic between the various components connected to the CCI.
> 
> Extend the existing CCI driver to support the PMU by registering a perf
> backend for it.

I think this binding addresses my comments, thanks. Just one comment below:

> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt

> +		- reg:
> +			Usage: required
> +			Value type: <prop-encoded-array>

> +		- interrupts:
> +			Usage: required
> +			Value type: <prop-encoded-array>

That makes it sound like the layout/content of those two properties is
the same. That's not true; one is an array of (base, size) cells, and
the other is of (phandle, args*) cells. The difference between the data
being phandles-vs-integers seems important.

Perhaps says:

Value type: Integer cells. Array of register entries, each expressed as
a pair of cells, containing base and size.

Value type: Integer cells. Array of interrupt specifier entries, as
defined in ../interrupt-controller/interupts.txt.

> +			Definition: comma-separated list of counter overflow

Oh, and lists of cells aren't necessarily comma-separated; comma is used
between <> but not inside <>, and there's no requirement that each
individual interrupt specifier be in its own <>, vs. just aggregating
all of them into a single <>.

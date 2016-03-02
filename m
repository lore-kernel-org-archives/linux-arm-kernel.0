From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Mar 2016 11:57:13 -0600
Subject: [RESPIN 5/6] dt-bindings: EXYNOS: Describe SROMc configuration
In-Reply-To: <1456389222-12738-6-git-send-email-pankaj.dubey@samsung.com>
References: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
 <1456389222-12738-6-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20160302175713.GB11155@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 02:03:41PM +0530, Pankaj Dubey wrote:
> From: Pavel Fedin <p.fedin@samsung.com>
> 
> Add documentation for new subnode properties, allowing bank configuration.
> Based on u-boot implementation, but heavily reworked.
> 
> Also, fix size of SROMc mapping in the example.

Fix it in the previous patch.

> CC: devicetree at vger.kernel.org
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  .../bindings/memory-controllers/exynos-srom.txt    | 73 +++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
> index 33886d5..e5c18df 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
> @@ -5,8 +5,77 @@ Required properties:
>  
>  - reg: offset and length of the register set
>  
> -Example:
> +Optional properties:
> +The SROM controller can be used to attach external peripherals. In this case
> +extra properties, describing the bus behind it, should be specified as below:
> +
> +- #address-cells: Must be set to 2 to allow device address translation.
> +		  Address is specified as (bank#, offset).
> +
> +- #size-cells: Must be set to 1 to allow device size passing
> +
> +- ranges: Must be set up to reflect the memory layout with four integer values
> +	  per bank:
> +		<bank-number> 0 <parent address of bank> <size>
> +
> +Sub-nodes:
> +The actual device nodes should be added as subnodes to the SROMc node. These
> +subnodes, except regular device specification, should contain the following

s/except/in addition to/

> +properties, describing configuration of the relevant SROM bank:
> +
> +Required properties:
> +- reg: bank number, base address (relative to start of the bank) and size of
> +       the memory mapped for the device. Note that base address will be
> +       typically 0 as this is the start of the bank.
> +
> +- samsung,srom-timing : array of 6 integers, specifying bank timings in the
> +                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> +                        Each value is specified in cycles and has the following
> +                        meaning and valid range:
> +                        Tacp : Page mode access cycle at Page mode (0 - 15)
> +                        Tcah : Address holding time after CSn (0 - 15)
> +                        Tcoh : Chip selection hold on OEn (0 - 15)
> +                        Tacc : Access cycle (0 - 31, the actual time is N + 1)
> +                        Tcos : Chip selection set-up before OEn (0 - 15)
> +                        Tacs : Address set-up before CSn (0 - 15)
> +
> +Optional properties:
> +- reg-io-width : data width in bytes (1 or 2). If omitted, default of 1 is used.
> +
> +- samsung,srom-page-mode : page mode configuration for the bank:
> +			   0 - normal (one data)
> +			   1 - four data
> +			   If omitted, default of 0 is used.

Make this a bool instead.

Rob

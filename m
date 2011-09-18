From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 18 Sep 2011 00:30:26 -0600
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <1316017900-19918-6-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
Message-ID: <20110918063026.GH3523@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 11:31:40AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds gic initialization using device tree data. The initialization
> functions are intended to be called by a generic OF interrupt
> controller parsing function once the right pieces are in place.
> 
> PPIs are handled using 3rd cell of interrupts properties to specify the cpu
> mask the PPI is assigned to.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   53 ++++++++++++++++++++++++
>  arch/arm/common/gic.c                         |   55 +++++++++++++++++++++++--
>  arch/arm/include/asm/hardware/gic.h           |   10 +++++
>  3 files changed, 114 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> new file mode 100644
> index 0000000..6c513de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -0,0 +1,53 @@
> +* ARM Generic Interrupt Controller
> +
> +ARM SMP cores are often associated with a GIC, providing per processor
> +interrupts (PPI), shared processor interrupts (SPI) and software
> +generated interrupts (SGI).
> +
> +Primary GIC is attached directly to the CPU and typically has PPIs and SGIs.
> +Secondary GICs are cascaded into the upward interrupt controller and do not
> +have PPIs or SGIs.
> +
> +Main node required properties:
> +
> +- compatible : should be one of:
> +	"arm,cortex-a9-gic"
> +	"arm,arm11mp-gic"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source.  The type shall be a <u32> and the value shall be 3.
> +
> +  The 1st cell is the interrupt number. 0-15 are reserved for SGIs. 16-31 are
> +  for PPIs.
> +
> +  The 2nd cell is the level-sense information, encoded as follows:
> +                    1 = low-to-high edge triggered
> +                    2 = high-to-low edge triggered
> +                    4 = active high level-sensitive
> +                    8 = active low level-sensitive
> +
> +  Only values of 1 and 4 are valid for GIC 1.0 spec.
> +
> +  The 3rd cell contains the mask of the cpu number for the interrupt source.
> +  The cpu mask is only valid for PPIs and shall be 0 for SPIs. This value shall
> +  be 0 for PPIs.

THe binding looks good, but I really think the first cell should be
the mask; followed by the irq number in the 2nd and the flags in the
3rd.  That would better match with existing practice.

> +
> +- reg : Specifies base physical address(s) and size of the GIC registers. The
> +  first 2 values are the GIC distributor register base and size. The 2nd 2

... first region is the GIC distributor...

... The 2nd region is the GIC cpu ...


I've only looked at the code changes superficially, but it looks good
to me.

g.

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Sep 2011 18:46:54 +0100
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <1316017900-19918-6-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
Message-ID: <4E70E88E.4090503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/11 17:31, Rob Herring wrote:
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
     ^^^^^^^^^^^^^

Typo here ? The way I understand it, it should read "For PPIs, this
value shall be the mask of the possible CPU numbers for the interrupt
source" (or something to similar effect...).

	M.
-- 
Jazz is not dead. It just smells funny...

From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Sep 2014 18:37:34 +0100
Subject: [V8 2/2] irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)
In-Reply-To: <1411230698-8081-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411230698-8081-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411230698-8081-3-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140922173734.GO3290@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

This looks good, I just have a few fixups that would be nice to apply
below.

On Sat, Sep 20, 2014 at 05:31:38PM +0100, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> ARM GICv2m specification extends GICv2 to support MSI(-X) with
> a new set of register frame. This patch introduces support for
> the non-secure GICv2m register frame. Currently, GICV2m is available
> in certain version of GIC-400.
> 
> The patch introduces a new property in ARM gic binding, the v2m subnode.
> It is optional.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Acked-by: Marc Zyngier <Marc.Zyngier@arm.com>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> Cc: Will Deacon <Will.Deacon@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |  55 ++++
>  arch/arm64/Kconfig                            |   1 +
>  drivers/irqchip/Kconfig                       |   5 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-gic-common.c              |  12 +
>  drivers/irqchip/irq-gic-common.h              |   4 +
>  drivers/irqchip/irq-gic-v2m.c                 | 356 ++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic.c                     |  82 +++---
>  drivers/irqchip/irq-gic.h                     |  54 ++++
>  9 files changed, 540 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic-v2m.c
>  create mode 100644 drivers/irqchip/irq-gic.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index c7d2fa1..38b2156 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -96,3 +96,58 @@ Example:
>                       <0x2c006000 0x2000>;
>                 interrupts = <1 9 0xf04>;
>         };
> +
> +
> +* GICv2m extension for MSI/MSI-x support (Optional)
> +
> +Certain revision of GIC-400 supports MSI/MSI-x via V2M register frame.
> +This is enabled by specifying v2m sub-node.

It looks like this was missed when the binding was updated for multiple
frames, so:

s/revision/revisions/
s/frame/frame(s)/
s/sub-node/sub-node(s)/

> +
> +Required properties:
> +
> +- compatible        : The value here should be "arm,gic-v2m-frame".

- compatible: should contain "arm,gic-v2m-frame".

> +
> +- msi-controller    : Identifies the node as an MSI controller.
> +
> +- reg               : GICv2m MSI interface register base and size
> +
> +Optional properties:
> +
> +- arm,msi-base-spi  : Specify base SPI the MSI frame.
> +                      The SPI base value can be from 32 to 1019.
> +
> +- arm,msi-num-spi   : Returns the number of contiguous SPIs assigned
> +                     to the frame.
> +
> +Note: "arm,msi-base-spi" and "arm,msi-num-spi" are used mainly for
> +       providing HW workaround in the case where the MSI_TYPER register
> +       is corrupted.

s/num-spi/num-spis/ please

Can we get rid of the note and reword this like:

- arm,msi-base-spi: When the MSI_TYPER register contains an incorrect
                    value, this property should contain the SPI base of
		    the MSI frame, overriding the HW value.

- arm,msi-num-spis: When the MSI_TYPER register contains an incorrect
                    value, this property should contain the number of
                    SPIs assigned to the frame, overriding the HW value.

I realise it's a little redundant, but it's very easy to miss usage
constraints in notes.

With that, for the binding:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

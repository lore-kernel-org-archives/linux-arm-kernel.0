From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Jun 2014 16:26:51 +0100
Subject: [PATCH RFC v1 1/2] documentation/iommu: Add description of
 Hisilicon System MMU binding
In-Reply-To: <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <1401975430-2648-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20140605152651.GB31564@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 05, 2014 at 02:37:09PM +0100, Zhen Lei wrote:
> This patch adds a description of the device tree binding for the Hisilicon
> System MMU architecture.

Similarly to my comments regarding the code, if this is a variant of the
ARM SMMU architecture, then it almost certainly makes sense to express
this as a delta againsts the ARM SMMU binding.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../devicetree/bindings/iommu/hisilicon,smmu.txt   | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt b/Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
> new file mode 100644
> index 0000000..a2b2f23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
> @@ -0,0 +1,70 @@
> +* Hisilicon System MMU Architecture Implementation
> +
> +Hisilicon SoCs may contain an implementation of the Hisilicon System Memory
> +Management Unit Architecture, which can be used to provide 1 or 2 stages
> +of address translation to bus masters external to the CPU.
> +
> +The SMMU may also raise interrupts in response to various fault
> +conditions.
> +
> +** System MMU required properties:
> +
> +- compatible    : Should be one of:
> +
> +                        "hisilicon,smmu-v1"
> +
> +                  depending on the particular implementation and/or the
> +                  version of the architecture implemented.

One of one possibilities?

Are we expecting further variants?

> +
> +- reg           : Base address and size of the SMMU.
> +
> +- #global-interrupts : The number of global interrupts exposed by the
> +                       device.
> +
> +- interrupts    : Interrupt list, with the first #global-irqs entries
> +                  corresponding to the global interrupts and exactly one
> +                  following entry corresponding to context interrupt.
> +
> +- smmu-masters  : A list of phandles to device nodes representing bus
> +                  masters for which the SMMU can provide a translation
> +                  and their corresponding StreamIDs (see example below).
> +
> +** System MMU optional properties:
> +
> +- smmu-cb-memtype   : A list of StreamIDs which not translate address but
> +                  translate attributes. The StreamIDs list here can not be
> +                  used for map(translation) mode again.
> +                  StreamID first, then the type list below:
> +                  1, cahceable, WBRAWA, Normal outer and inner write-back
> +                  2, non-cacheable, Normal outer and inner non-cacheable
> +                  3, device, nGnRE
> +                  others, bypass

This sounds like configuration rather than device description.

What is this for?

Why is this necessary?

> +
> +- smmu-bypass-vmid  : Specify which context bank is used for bypass mode.
> +                  If omit, vmid=255 is default.

Likewise, for all the points against smmu-cb-memtype.

> +
> +Example:
> +
> +        smmu {

Nit: missing unit-address;

> +                compatible = "hisilicon,smmu-v1";
> +                reg = <0x40040000 0x1000>;
> +                #global-interrupts = <1>;
> +
> +                /*
> +                 * Global and context faults may use the same interrupt, if
> +                 * only one exist.
> +                 */

That comment sounds like it should be in the description of the
interrupts property, not the example.

> +                interrupts = <0 188 4>,
> +                             <0 188 4>; /* The last is the context interrupt */
> +
> +                /*
> +                 * StreamID = 0 is bypass and force cacheable(WBRAWA).
> +                 */
> +                smmu-cb-memtype = <0x0 1>;

Why?

Cheers,
Mark.

> +
> +                /*
> +                 * Two DMA controllers, each with exactly one StreamID.
> +                 */
> +                smmu-masters = <&dma0 0x0001>,
> +                               <&dma1 0x0002>;
> +        };
> --
> 1.8.0
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

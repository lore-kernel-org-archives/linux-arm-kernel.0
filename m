From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 1 Mar 2016 11:01:07 +0000
Subject: [PATCH 7/8] ARM64: dts: amlogic: Extend GXBaby GIC node
In-Reply-To: <1456789465-2962-8-git-send-email-afaerber@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-8-git-send-email-afaerber@suse.de>
Message-ID: <56D57673.8030702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 29/02/16 23:44, Andreas F?rber wrote:
> Add GICH and GICV resources for HYP mode - guess based on other vendors.

Do you know if the firmware allows the kernel to be entered in EL2
(which is the arm64 name for HYP)?
So can we run kvm?
If you have a booted kernel, can you grep for "EL2" and "kvm" in the dmesg?

Also you should merge this patch into 3/8, same for 8/8.

> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 0ae089bd1806..5088ae3ff653 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -117,7 +117,9 @@
>  		gic: interrupt-controller at c4301000 {
>  			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";

I think "arm,gic-400" is the name to use here these days, especially for
arm64.

>  			reg = <0x0 0xc4301000 0 0x1000>,
> -			      <0x0 0xc4302000 0 0x0100>;
> +			      <0x0 0xc4302000 0 0x0100>,

Please use 0x2000 for the size here. I guess this is really the GIC-400
from ARM, and in this case this is the right size, [1] is the reference
here. This will enable EOI mode 1 for KVM.

Cheers,
Andre.

[1]
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/CHDIFAEE.html

> +			      <0x0 0xc4304000 0 0x2000>,
> +			      <0x0 0xc4306000 0 0x2000>;
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9
>  				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> 

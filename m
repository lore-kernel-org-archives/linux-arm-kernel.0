From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 16 Mar 2016 16:35:08 +0000
Subject: [STLinux Kernel] [PATCH v5 7/7] ARM: STiH407: Move over to using
 the 'reserved-memory' API for obtaining DMA memory
In-Reply-To: <1452602781-22424-8-git-send-email-lee.jones@linaro.org>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
 <1452602781-22424-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20160316163508.GA8396@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, 12 Jan 2016, Lee Jones wrote:

> Doing so saves quite a bit of code in the driver.
> 
> For more information on the 'reserved-memory' bindings see:
> 
>   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 46 +++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 15c20b6..27b8efc 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -15,6 +15,36 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gp0_reserved: rproc at 40000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x40000000 0x01000000>;
> +			no-map;
> +		};
> +
> +		gp1_reserved: rproc at 41000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x41000000 0x01000000>;
> +			no-map;
> +		};
> +
> +		audio_reserved: rproc at 42000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x42000000 0x01000000>;
> +			no-map;
> +		};
> +
> +		dmu_reserved: rproc at 43000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x43000000 0x01000000>;
> +			no-map;
> +		};

I don't believe these reserved memory ranges are correct for audio_reserved and dmu_reserved.

For example my vid_firmware-stih407.elf is linked at 0x41c00000 base address and my
audio_firmware-bd-stih407.elf is linked at 0x40c00000.

So with all the st231 rproc nodes enabled I guess it would still work. But
currently I think st231_gp0 is reserving the memory region for st231_audio,
and st231-gp1 is reserving the memory region for st231_dmu.

regards,

Peter.

From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 15:47:48 -0500
Subject: [PATCH v2 3/5] dt-bindings: Add documentation for GM20B GPU
In-Reply-To: <1458010724-10945-4-git-send-email-acourbot@nvidia.com>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
 <1458010724-10945-4-git-send-email-acourbot@nvidia.com>
Message-ID: <20160318204748.GA20243@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 11:58:42AM +0900, Alexandre Courbot wrote:
> GM20B's definition is mostly similar to GK20A's, but requires an
> additional clock.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  .../devicetree/bindings/gpu/nvidia,gk20a.txt       | 27 ++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

One nit below.

> 
> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
> index 1e3748337319..d9ad6b87fbbc 100644
> --- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
> +++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
> @@ -1,9 +1,10 @@
> -NVIDIA GK20A Graphics Processing Unit
> +NVIDIA Tegra Graphics Processing Units
>  
>  Required properties:
>  - compatible: "nvidia,<gpu>"
>    Currently recognized values:
>    - nvidia,gk20a
> +  - nvidia,gm20b
>  - reg: Physical base address and length of the controller's registers.
>    Must contain two entries:
>    - first entry for bar0
> @@ -19,6 +20,9 @@ Required properties:
>  - clock-names: Must include the following entries:
>    - gpu
>    - pwr
> +If the compatible string is "nvidia,gm20b", then the following clock
> +is also required:
> +  - ref
>  - resets: Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
>  - reset-names: Must include the following entries:
> @@ -27,7 +31,7 @@ Required properties:
>  Optional properties:
>  - iommus: A reference to the IOMMU. See ../iommu/iommu.txt for details.
>  
> -Example:
> +Example for GK20A:
>  
>  	gpu at 0,57000000 {
>  		compatible = "nvidia,gk20a";
> @@ -45,3 +49,22 @@ Example:
>  		iommus = <&mc TEGRA_SWGROUP_GPU>;
>  		status = "disabled";
>  	};
> +
> +Example for GM20B:
> +
> +	gpu at 0,57000000 {

Drop the comma and leading zero.

> +		compatible = "nvidia,gm20b";
> +		reg = <0x0 0x57000000 0x0 0x01000000>,
> +		      <0x0 0x58000000 0x0 0x01000000>;
> +		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "stall", "nonstall";
> +		clocks = <&tegra_car TEGRA210_CLK_GPU>,
> +			 <&tegra_car TEGRA210_CLK_PLL_P_OUT5>,
> +			 <&tegra_car TEGRA210_CLK_PLL_G_REF>;
> +		clock-names = "gpu", "pwr", "ref";
> +		resets = <&tegra_car 184>;
> +		reset-names = "gpu";
> +		iommus = <&mc TEGRA_SWGROUP_GPU>;
> +		status = "disabled";
> +	};
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

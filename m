From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Oct 2014 11:51:11 +0100
Subject: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
In-Reply-To: <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
Message-ID: <20141024105111.GD24265@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> Device tree regions described by /memreserve/ entries are not available in
> /proc/device-tree, and hence are not available to user space utilities that use
> /proc/device-tree.  In order for these regions to be available, convert any
> arm64 DTS files using /memreserve/ entries to use reserved-memory nodes.

The limitation here is in the kernel (and a partially in userspace), so
modifying the dts files is a workaround rather than a fix.

It's perfectly valid for people to remain using /memreserve/, so this
isn't sufficient. There are also existing DTBs using /memreserve/ which
we can't rely on being modified to use reserved-memory.

I think we need to expose memreserves to userspace somehow, potentially
along with other DTB header fields. Grant, ideas?

Are other architectures not affected by this limitation?

> This change is required for kexec re-boot to work properly when a user does not
> specify a second stage DTB via the kexec --dtb option.  When the --dtb option is
> not specified kexec will prepare the second stage DTB using data from
> /proc/device-tree.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/boot/dts/foundation-v8.dts  | 13 +++++++++++--
>  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 13 +++++++++++--
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/foundation-v8.dts b/arch/arm64/boot/dts/foundation-v8.dts
> index 4a06090..2b76c2d 100644
> --- a/arch/arm64/boot/dts/foundation-v8.dts
> +++ b/arch/arm64/boot/dts/foundation-v8.dts
> @@ -6,8 +6,6 @@
>  
>  /dts-v1/;
>  
> -/memreserve/ 0x80000000 0x00010000;
> -
>  / {
>  	model = "Foundation-v8A";
>  	compatible = "arm,foundation-aarch64", "arm,vexpress";
> @@ -64,6 +62,17 @@
>  		      <0x00000008 0x80000000 0 0x80000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		firmware-memory at 0x80000000 {
> +			no-map;
> +			reg = <0x0 0x80000000 0x0 0x00010000>;
> +		};
> +	};
> +

For the spin-table code at present we currently permit cacheable
mappings (that's part of the definition of /memreserve/), so it's not
strictly necessary to have no-map. Until recently we accessed the
cpu-release-addr through a cacheable mapping, and I don't know what
other spin-table users (e.g. Xen) do.

Linux should be able to handle this from now on, however.

Thanks,
Mark.

>  	gic: interrupt-controller at 2c001000 {
>  		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> index 572005e..0f80807 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> @@ -9,8 +9,6 @@
>  
>  /dts-v1/;
>  
> -/memreserve/ 0x80000000 0x00010000;
> -
>  / {
>  	model = "RTSM_VE_AEMv8A";
>  	compatible = "arm,rtsm_ve,aemv8a", "arm,vexpress";
> @@ -67,6 +65,17 @@
>  		      <0x00000008 0x80000000 0 0x80000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		firmware-memory at 0x80000000 {
> +			no-map;
> +			reg = <0x0 0x80000000 0x0 0x00010000>;
> +		};
> +	};
> +
>  	gic: interrupt-controller at 2c001000 {
>  		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

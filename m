From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 Jan 2015 16:46:32 +0000
Subject: [PATCH] arm64: Add L2 cache topology to ARM Ltd boards/models
In-Reply-To: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
References: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20150121164632.GK5044@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 12:02:30PM +0000, Sudeep Holla wrote:
> Commit 5d425c18653731af6 ("arm64: kernel: add support for cpu cache
> information") adds cacheinfo support for ARM64. Since there's no
> architectural way of detecting the cpus that share particular cache,
> device tree can be used and the core cacheinfo already supports the
> same.

This still leaves the possibility that misleading information is exposed
for systems from other vendors. I've made a quick attempt to Cc the
authors of other arm64 dts here.

Given that in the absence of these nodes we can't derive a complete view
of the cache hierarchy, shouldn't we only expose the cacheinfo when we
have these nodes and can therefore produce correct values?

I can imagine that future dts are likely to appear without these nodes,
and I imagine that we won't spot all of those cases. We also have
existing DTBs to take into account.

Thanks,
Mark.

> 
> This patch adds the L2 cache topology on Juno board, FVP/RTSM and
> foundation models.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/boot/dts/arm/foundation-v8.dts  |  8 ++++++++
>  arch/arm64/boot/dts/arm/juno.dts           | 14 ++++++++++++++
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts |  8 ++++++++
>  3 files changed, 30 insertions(+)
> 
> Hi Arnd/Olof,
> 
> Though this patch and commit 5d425c18653731af6 ("arm64: kernel: add
> support for cpu cache information") which is in -next(via arm64) are
> dependent to provide desired functionality, then can go indepedently
> if you think there could be conflicts if this change is taken via arm64.
> If not, Catalin can pick up with your acks after the review.
> 
> Regards,
> Sudeep
> 
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
> index 27f32962e55c..4eac8dcea423 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
> @@ -34,6 +34,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
> @@ -41,6 +42,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
>  		};
>  		cpu at 2 {
>  			device_type = "cpu";
> @@ -48,6 +50,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
>  		};
>  		cpu at 3 {
>  			device_type = "cpu";
> @@ -55,6 +58,11 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index cb3073e4e7a8..15dafbb24426 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -39,6 +39,7 @@
>  			reg = <0x0 0x0>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			next-level-cache = <&A57_L2>;
>  		};
>  
>  		A57_1: cpu at 1 {
> @@ -46,6 +47,7 @@
>  			reg = <0x0 0x1>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			next-level-cache = <&A57_L2>;
>  		};
>  
>  		A53_0: cpu at 100 {
> @@ -53,6 +55,7 @@
>  			reg = <0x0 0x100>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
>  		};
>  
>  		A53_1: cpu at 101 {
> @@ -60,6 +63,7 @@
>  			reg = <0x0 0x101>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
>  		};
>  
>  		A53_2: cpu at 102 {
> @@ -67,6 +71,7 @@
>  			reg = <0x0 0x102>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
>  		};
>  
>  		A53_3: cpu at 103 {
> @@ -74,6 +79,15 @@
>  			reg = <0x0 0x103>;
>  			device_type = "cpu";
>  			enable-method = "psci";
> +			next-level-cache = <&A53_L2>;
> +		};
> +
> +		A57_L2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +
> +		A53_L2: l2-cache1 {
> +			compatible = "cache";
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> index efc59b3baf63..20addabbd127 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> @@ -37,6 +37,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
>  		};
>  		cpu at 1 {
>  			device_type = "cpu";
> @@ -44,6 +45,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
>  		};
>  		cpu at 2 {
>  			device_type = "cpu";
> @@ -51,6 +53,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
>  		};
>  		cpu at 3 {
>  			device_type = "cpu";
> @@ -58,6 +61,11 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "spin-table";
>  			cpu-release-addr = <0x0 0x8000fff8>;
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
>  		};
>  	};
>  
> -- 
> 1.9.1
> 
> 

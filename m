From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Jan 2015 11:41:42 +0100
Subject: [PATCH v2 04/21] ARM: tegra: update DTs to expose legacy
 interrupt controller
In-Reply-To: <1420652576-22309-5-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108104141.GF1987@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 05:42:39PM +0000, Marc Zyngier wrote:
> Describe the legacy interrupt controller in every tegra DTSI files,
> and make it the parent of most interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 16 +++++++++++++++-
>  arch/arm/boot/dts/tegra124.dtsi | 16 +++++++++++++++-
>  arch/arm/boot/dts/tegra20.dtsi  | 15 ++++++++++++++-
>  arch/arm/boot/dts/tegra30.dtsi  | 16 +++++++++++++++-
>  4 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index 4296b53..f70bed0 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -8,7 +8,7 @@
>  
>  / {
>  	compatible = "nvidia,tegra114";
> -	interrupt-parent = <&gic>;
> +	interrupt-parent = <&ictlr>;

Maybe name the label "lic" because that's the more common name for this
controller? Same for the other DTSI files.

> @@ -134,6 +134,19 @@
>  		      <0x50046000 0x2000>;
>  		interrupts = <GIC_PPI 9
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupt-parent = <&gic>;

Is this allowed? It makes the GIC its own parent. I guess we need it to
stop a loop from GIC -> LIC -> GIC, but it doesn't look quite right.

> +	};
> +
> +	ictlr: interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra114-ictlr", "nvidia,tegra-ictlr";

As previously discussed, I think the second string should be
"nvidia,tegra30-ictlr".

> +		reg = <0x60004000 64>,

I think the first entry should be 256 bytes long since there's another
block of 192 bytes of registers that's part of the interrupt controller,
albeit maybe not related to the functionality of the interrupt chip. But
they're still part of the same hardware block.

> +		      <0x60004100 64>,

According to the TRM there are 4 more registers in this block, so this
should be 80 in size.

> +		      <0x60004200 64>,
> +		      <0x60004300 64>,
> +		      <0x60004400 64>;

I'd prefer all of these to be hexadecimal.

> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
>  	};
>  
>  	timer at 60005000 {
> @@ -766,5 +779,6 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>  			<GIC_PPI 10
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		interrupt-parent = <&gic>;

Why does this get to have a non-default parent?

>  	};
>  };
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
[...]
> @@ -190,6 +191,18 @@
>  		status = "disabled";
>  	};
>  
> +	ictlr: interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra124-ictlr", "nvidia,tegra-ictlr";

Same as for Tegra114.

> +		reg = <0x0 0x60004000 0x0 0x40>,
> +		      <0x0 0x60004100 0x0 0x40>,
> +		      <0x0 0x60004200 0x0 0x40>,
> +		      <0x0 0x60004300 0x0 0x40>,
> +		      <0x0 0x60004400 0x0 0x40>;

According to the TRM, entries 1-4 should be 0x100 bytes. Even the first
entry could be 0x100 bytes long since there are additional registers in
there. While they may not be directly relevant to the interrupt chip, I
think it would make sense to include them here because they are part of
the same hardware block.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 8acf5d8..ab2f004 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -7,7 +7,7 @@
>  
>  / {
>  	compatible = "nvidia,tegra20";
> -	interrupt-parent = <&intc>;
> +	interrupt-parent = <&ictlr>;

I wonder if we shouldn't rename the intc label to gic for consistency.
Could be in a follow-up patch though, and something that I can easily do
after this patch set.

>  
>  	host1x at 50000000 {
>  		compatible = "nvidia,tegra20-host1x", "simple-bus";
> @@ -142,6 +142,7 @@
>  
>  	timer at 50004600 {
>  		compatible = "arm,cortex-a9-twd-timer";
> +		interrupt-parent = <&intc>;
>  		reg = <0x50040600 0x20>;
>  		interrupts = <GIC_PPI 13
>  			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> @@ -154,6 +155,7 @@
>  		       0x50040100 0x0100>;
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
>  	};
>  
>  	cache-controller at 50043000 {
> @@ -165,6 +167,17 @@
>  		cache-level = <2>;
>  	};
>  
> +	ictlr: interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra20-ictlr", "nvidia,tegra-ictlr";

As discussed previously, I think the second compatible should be
dropped.

> +		reg = <0x60004000 64>,
> +		      <0x60004100 64>,
> +		      <0x60004200 64>,
> +		      <0x60004300 64>;

Same comments as for Tegra114, except the quinary controller which
doesn't exist on Tegra20.

> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
> +	};
> +
>  	timer at 60005000 {
>  		compatible = "nvidia,tegra20-timer";
>  		reg = <0x60005000 0x60>;

Why doesn't the Tegra timer get to keep the GIC as parent like for
Tegra114 and Tegra124? Instead I see that the Cortex-A9 TWD timer gets
to keep the parent instead.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
[...]
> @@ -228,6 +228,7 @@
>  	timer at 50004600 {
>  		compatible = "arm,cortex-a9-twd-timer";
>  		reg = <0x50040600 0x20>;
> +		interrupt-parent = <&intc>;
>  		interrupts = <GIC_PPI 13
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		clocks = <&tegra_car TEGRA30_CLK_TWD>;
> @@ -239,6 +240,7 @@
>  		       0x50040100 0x0100>;
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
>  	};
>  
>  	cache-controller at 50043000 {
> @@ -250,6 +252,18 @@
>  		cache-level = <2>;
>  	};
>  
> +	ictlr: interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra30-ictlr", "nvidia,tegra-ictlr";

Should be "nvidia,tegra30-ictlr" only.

> +		reg = <0x60004000 64>,
> +		      <0x60004100 64>,
> +		      <0x60004200 64>,
> +		      <0x60004300 64>,
> +		      <0x60004400 64>;
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&intc>;
> +	};

This should be the same as for Tegra114.

> +
>  	timer at 60005000 {
>  		compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
>  		reg = <0x60005000 0x400>;

Like for Tegra20, the Tegra timer is now switched to the LIC as parent.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/6da51cd8/attachment-0001.sig>

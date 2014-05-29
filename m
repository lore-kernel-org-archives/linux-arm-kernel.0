From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 13:13:37 -0600
Subject: [PATCH v5 4/5] ARM: tegra: Add efuse and apbmisc bindings
In-Reply-To: <1401281677-32110-5-git-send-email-pdeschrijver@nvidia.com>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
 <1401281677-32110-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <538786E1.4030707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 06:54 AM, Peter De Schrijver wrote:
> Add efuse and apbmisc bindings for Tegra20, Tegra30, Tegra114 and Tegra124.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../devicetree/bindings/fuse/fuse-tegra.txt        |   30 ++++++++++++++++++++
>  .../devicetree/bindings/misc/nvidia,apbmisc.txt    |   13 ++++++++

Please name these files according to the compatible value, like all the
other Tegra bindings. So, nvidia,tegra20-efuse.txt and
nvidia,tegra20-apbmisc.txt.

>  arch/arm/boot/dts/tegra114.dtsi                    |   12 ++++++++
>  arch/arm/boot/dts/tegra124.dtsi                    |   12 ++++++++
>  arch/arm/boot/dts/tegra20.dtsi                     |   12 ++++++++
>  arch/arm/boot/dts/tegra30.dtsi                     |   12 ++++++++

It's a bit odd to mix in the .dtsi changes in the same patch as the
binding doc.

> diff --git a/Documentation/devicetree/bindings/fuse/fuse-tegra.txt b/Documentation/devicetree/bindings/fuse/fuse-tegra.txt

> +- compatible : should be:
> +	"nvidia,tegra20-efuse"
> +	"nvidia,tegra30-efuse"
> +	"nvidia,tegra114-efuse"
> +	"nvidia,tegra124-efuse"
> +  Details:
> +  nvidia,tegra20-efuse: Tegra20 requires using APB DMA to read the fuse data
> +	due to a hardware bug. Tegra20 also lacks certain information which is
> +	available in later generations such as fab code, lot code, wafer id,..
> +  nvidia,tegra30-efuse, nvidia,tegra114-efuse and nvidia,tegra124-efuse:
> +	The differences between these SoCs are the size of the efuse array,
> +	the location of the spare (OEM programmable) bits and the location of
> +	the speedo data.

I suppose it doesn't hurt, but I don't think we need any of the
"Details" section here.

> +- clocks: Should contain a pointer to the fuse clock.

Please require clock-names so we don't need a mix of index-/name-based
lookups in the future. Please follow the same wording as existing Tegra
binding docs that use clocks. For example:

- clocks : Must contain an entry for each entry in clock-names.
  See ../clocks/clock-bindings.txt for details.
- clock-names : Must include the following entries:
  - d_audio
  - apbif

Are there no PMC reset signals fed into the fuse block?

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +        apbmisc at 0x70000800 {

The unit address in the DT nod name should not contain "0x". Same for
other .dtsi files.

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +	apbmisc at 0x70000800 {

Tegra124 uses #address-cells=<2>, so the unit address in the node name
needs to follow that. Hence, apbmisc at 0,70000800.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> @@ -236,6 +236,12 @@
>  		interrupt-controller;
>  	};
>  
> +        apbmisc at 0x70000800 {
> +		compatible = "nvidia,tegra20-apbmisc";

Indentation looks odd here. Mix of TABs/spaces perhaps?

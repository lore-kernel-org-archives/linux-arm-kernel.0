From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 14:58:23 -0600
Subject: [RFC 2/4] ARM: tegra: Add legacy interrupt controller nodes
In-Reply-To: <1403888329-24755-2-git-send-email-thierry.reding@gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <1403888329-24755-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <53ADDAEF.2070805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 10:58 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add device tree nodes for the legacy interrupt controller so that the
> driver can get the register ranges from device tree rather than hard-
> coding them.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra20-ictlr";
> +		reg = <0x60004000 0x40   /* primary controller */
> +		       0x60004100 0x40   /* secondary controller */
> +		       0x60004200 0x40   /* tertiary controller */
> +		       0x60004300 0x40   /* quaternary controller */
> +		       0x60004400 0x40>; /* quinary controller */
> +	};

The quinary controller doesn't exist on Tegra20.

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

> +	interrupt-controller at 60004000 {
> +		compatible = "nvidia,tegra20-ictlr";

At the least, each SoC should have an SoC-specific compatible value in
addition to the base Tegra20 value in case we need to differentiate them
in the future.

I'd be tempted to only include the SoC-specific value and omit the
Tegra20-specific value so we don't have to care whether they're really
100% backwards-compatible, but it's probably safe to say they're all
Tegra20 compatible (or all Tegra30 compatible given the 4-vs-5
controllers difference).

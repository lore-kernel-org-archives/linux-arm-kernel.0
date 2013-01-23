From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 17:33:20 -0700
Subject: [PATCH 2/2] ARM: tegra: add clocks properties to USB PHY nodes
In-Reply-To: <1358900903-27654-2-git-send-email-swarren@wwwdotorg.org>
References: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
 <1358900903-27654-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50FF2FD0.2090003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 05:28 PM, Stephen Warren wrote:
> The patch to add USB PHY nodes to device tree was written before Tegra
> supported the clocks property in device tree. Now that it does, add the
> required clocks properties to these nodes.
> 
> This will allow all clk_get_sys() calls in tegra_usb_phy.c to be replaced
> by clk_get(phy->dev, clock_name), as part of converting the PHY driver to
> a platform driver.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +		clocks = <&tegra_car 22>, <&tegra_car 127>;
> +		clock-names = "utmi", "pll_u";
...
> +		clocks = <&tegra_car 94>, <&tegra_car 127>;
> +		clock-names = "ulpi", "pll_u";

Hmmm. Thinking about that first clock more, if we name it just "phy" in
both the UTMI and ULPI PHY nodes, we could make tegra_phy_init() perform
the clk_get() for all PHY types, and use the same clock name everywhere,
and hence remove the type-specific clk_get()s from tegra_phy_init() and
utmip_pad_open().

Venu, will this work for other chips such as Tegra30/Tegra114 and so on
into the future, or do chips after Tegra20 introduce any new clocks, and
hence break this scheme?

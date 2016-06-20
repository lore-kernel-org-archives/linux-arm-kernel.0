From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 20 Jun 2016 18:34:03 +0530
Subject: [PATCH v2 08/11] Documentation: phy: Let the rockchip eMMC PHY
 get an exported card clock
In-Reply-To: <1465859076-4868-9-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-9-git-send-email-dianders@chromium.org>
Message-ID: <5767E9C3.40009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 14 June 2016 04:34 AM, Douglas Anderson wrote:
> As of an earlier change in this series ("Documentation: mmc:
> sdhci-of-arasan: Add ability to export card clock") the SDHCI driver
> used on Rockchip SoCs can now expose its clock.  Let's now specify that
> the PHY can use it.
> 
> Letting the PHY get access to this clock means it can adjust
> phyctrl_frqsel field appropriately.  Although the Rockchip PHY appears
> slightly different than the reference Arasan one, you can see that the
> Arasan datasheet [1] had it defined as:
>   Select the frequency range of DLL operation:
>   3b'000 => 200MHz to 170 MHz
>   3b'001 => 170MHz to 140 MHz
>   3b'010 => 140MHz to 110 MHz
>   3b'011 => 110MHz to 80MHz
>   3b'100 => 80MHz to 50 MHz
>   3b'101 => 275Mhz to 250MHz
>   3b'110 => 250MHz to 225MHz
>   3b'111 => 225MHz to 200MHz
> 
> On the Rockchip version of the PHY we have less granularity but the idea
> is the same.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes in v2:
> - List out clocks and clock names (Rob)
> 
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index 555cb0f40690..e3ea55763b0a 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -7,6 +7,13 @@ Required properties:
>   - reg: PHY register address offset and length in "general
>     register files"
>  
> +Optional clocks using the clock bindings (see ../clock/clock-bindings.txt),
> +specified by name:
> + - clock-names: Should contain "emmcclk".  Although this is listed as optional
> +		(because most boards can get basic functionality without having
> +		access to it), it is strongly suggested.
> + - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
> +
>  Example:
>  
>  
> @@ -20,6 +27,8 @@ grf: syscon at ff770000 {
>  	emmcphy: phy at f780 {
>  		compatible = "rockchip,rk3399-emmc-phy";
>  		reg = <0xf780 0x20>;
> +		clocks = <&sdhci>;
> +		clock-names = "emmcclk";
>  		#phy-cells = <0>;
>  	};
>  };
> 

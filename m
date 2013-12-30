From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 30 Dec 2013 12:29:00 +0530
Subject: [PATCH V3 2/2] ARM: dts: Enable ahci sata and sata phy
In-Reply-To: <1386669911-17319-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1386669911-17319-1-git-send-email-yuvaraj.cd@samsung.com>
 <1386669911-17319-3-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <52C119B4.1010002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 10 December 2013 03:35 PM, Yuvaraj Kumar C D wrote:
> This patch adds dt entry for ahci sata controller and its
> corresponding phy controller.phy node has been added w.r.t
> new generic phy framework.
>
> Changes since V2:
> 	1.Used syscon interface to PMU handling.
> 	2.Changed "sata-phy-i2c" to "exynos-sataphy-i2c".
>
> Changes since V1:
> 	1.Minor changes to node name convention.
> 	2.Updated binding document.

Change history should be moved after '---'.
>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>   .../devicetree/bindings/ata/exynos-sata-phy.txt    |   19 ++++++++++++++-----
>   .../devicetree/bindings/ata/exynos-sata.txt        |   17 ++++++++++++-----
>   .../devicetree/bindings/ata/exynos_sataphy_i2c.txt |   12 ++++++++++++
>   arch/arm/boot/dts/exynos5250-arndale.dts           |    9 ++++++++-
>   arch/arm/boot/dts/exynos5250-smdk5250.dts          |    8 ++------
>   arch/arm/boot/dts/exynos5250.dtsi                  |   16 ++++++++++++----
>   6 files changed, 60 insertions(+), 21 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/ata/exynos_sataphy_i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt b/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
> index 37824fa..a679e17 100644
> --- a/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
> +++ b/Documentation/devicetree/bindings/ata/exynos-sata-phy.txt

IMO this documentation should be in 
Documentation/devicetree/bindings/phy and you could also use the 
existing exynos file.
> @@ -4,11 +4,20 @@ SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
>   Each SATA PHY controller should have its own node.
>
>   Required properties:
> -- compatible        : compatible list, contains "samsung,exynos5-sata-phy"
> +- compatible        : compatible list, contains "samsung,exynos5250-sata-phy"
>   - reg               : <registers mapping>
>
>   Example:
> -        sata at ffe07000 {
> -                compatible = "samsung,exynos5-sata-phy";
> -                reg = <0xffe07000 0x1000>;
> -        };
> +	sata_phy: sata-phy at 12170000 {
> +		compatible = "samsung,exynos5250-sata-phy";
> +		reg = <0x12170000 0x1ff>;
> +		clocks = <&clock 287>;
> +		clock-names = "sata_phyctrl";
> +		#phy-cells = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		sataphy-pmu {
> +			reg = <0x10040724 0x4>;
> +			};

alignment problem..
> +	};
> diff --git a/Documentation/devicetree/bindings/ata/exynos-sata.txt b/Documentation/devicetree/bindings/ata/exynos-sata.txt
> index 0849f10..918bff8 100644
> --- a/Documentation/devicetree/bindings/ata/exynos-sata.txt
> +++ b/Documentation/devicetree/bindings/ata/exynos-sata.txt
> @@ -8,10 +8,17 @@ Required properties:
>   - interrupts        : <interrupt mapping for SATA IRQ>
>   - reg               : <registers mapping>
>   - samsung,sata-freq : <frequency in MHz>
> +- phys              : as mentioned in phy-bindings.txt
> +- phy-names         : as mentioned in phy-bindings.txt

here too.. match it with existing properties..
>
>   Example:
> -        sata at ffe08000 {
> -                compatible = "samsung,exynos5-sata";
> -                reg = <0xffe08000 0x1000>;
> -                interrupts = <115>;
> -        };
> +	sata at 122f0000 {
> +		compatible = "snps,dwc-ahci";
> +		samsung,sata-freq = <66>;
> +		reg = <0x122f0000 0x1ff>;
> +		interrupts = <0 115 0>;
> +		clocks = <&clock 277>, <&clock 143>;
> +		clock-names = "sata", "sclk_sata";
> +		phys = <&sata_phy>;
> +		phy-names = "sata-phy";
> +	};
> diff --git a/Documentation/devicetree/bindings/ata/exynos_sataphy_i2c.txt b/Documentation/devicetree/bindings/ata/exynos_sataphy_i2c.txt
> new file mode 100644
> index 0000000..deabba9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/exynos_sataphy_i2c.txt

This should also be in /bindings/phy..

Cheers
Kishon

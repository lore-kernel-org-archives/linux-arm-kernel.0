From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Jun 2014 12:44:28 +0200
Subject: [PATCH v6 6/7] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1402914392-6028-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
 <1402914392-6028-7-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <539ECA8C.4010007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2014 12:26 PM, Antoine T?nart wrote:
> The BG2Q has an AHCI SATA controller. Add the corresponding nodes
> (AHCI, PHY) into its device tree.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 635a16a64cb4..3fb0d3935aec 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -303,6 +303,34 @@
>   			clock-names = "refclk";
>   		};
>
> +		ahci: sata at e90000 {
> +			compatible = "generic-ahci";
> +			reg = <0xe90000 0x1000>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&chip CLKID_SATA>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			sata0: sata-port at 0 {
> +				reg = <0>;
> +				phys = <&sata_phy 0>;
> +				status = "disabled";
> +			};
> +
> +			sata1: sata-port at 1 {
> +				reg = <1>;
> +				phys = <&sata_phy 1>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		sata_phy: phy at e900a0 {
> +			compatible = "marvell,berlin-sata-phy";
> +			reg = <0xe900a0 0x200>;

Antoine,

I guess you'll also need
	clocks = <&chip CLKID_SATA>;
here and corresponding code in the PHY driver.

If SATA PHY is accessing SATA registers, disabling the clock will
most likely lock-up the SoC.

Sebastian

> +			#phy-cells = <1>;
> +			status = "disabled";
> +		};
> +
>   		apb at fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
>

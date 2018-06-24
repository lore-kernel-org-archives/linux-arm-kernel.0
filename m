From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 24 Jun 2018 15:57:27 +0200
Subject: [PATCH 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
In-Reply-To: <20180613161314.14894-2-yixun.lan@amlogic.com>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
 <20180613161314.14894-2-yixun.lan@amlogic.com>
Message-ID: <20180624155727.322c02b2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

On Wed, 13 Jun 2018 16:13:13 +0000
Yixun Lan <yixun.lan@amlogic.com> wrote:

> From: Liang Yang <liang.yang@amlogic.com>
> 
> Add Amlogic NAND controller dt-bindings for Meson SoC,
> Current this driver support GXBB/GXL/AXG platform.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> new file mode 100644
> index 000000000000..eac9f9433d5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> @@ -0,0 +1,118 @@
> +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> +
> +This file documents the properties in addition to those available in
> +the MTD NAND bindings.
> +
> +Required properties:
> +- compatible : contains one of:
> +  - "amlogic,meson-gxl-nfc"
> +  - "amlogic,meson-axg-nfc"
> +- clocks     :
> +	A list of phandle + clock-specifier pairs for the clocks listed
> +	in clock-names.
> +
> +- clock-names: Should contain the following:
> +	"core" - NFC module gate clock
> +	"clkin0" - Parent clock of internal mux
> +	"clkin1" - Other parent clock of internal mux
> +
> +- pins     : Select pins which NFC need.
> +- nand_pins: Detail NAND pins information.
> +		nand_pins: nand {
> +			mux {
> +				groups = "emmc_nand_d0",
> +					"emmc_nand_d1",
> +					"emmc_nand_d2",
> +					"emmc_nand_d3",
> +					"emmc_nand_d4",
> +					"emmc_nand_d5",
> +					"emmc_nand_d6",
> +					"emmc_nand_d7",
> +					"nand_ce0",
> +					"nand_rb0",
> +					"nand_ale",
> +					"nand_cle",
> +					"nand_wen_clk",
> +					"nand_ren_wr";
> +				function = "nand";
> +			};
> +		};

Not sure, but I think you can drop the pinmux description.

> +
> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> +				controller port C
> +
> +Optional children nodes:
> +Children nodes represent the available nand chips.
> +
> +Optional properties:
> +- meson-nand-user-mode :
> +	only set 2 or 16 which mean the way of reading OOB bytes by NFC.

I haven't checked the driver but this prop looks like a reg field value
you're directly copying in the reg at init time. We usually avoid
exposing such details in the DT. I'm not even sure you should have a
property to select how you want to read OOB (need to check the driver
before giving a definitive answer on this aspect).

> +- meson-nand-ran-mode :
> +	setting 0 or 1, means disable/enable scrambler which keeps the balence
> +	of 0 and 1

You don't need that one. The NAND chip will tell you whether it requires
scrambling or not (see NAND_NEED_SCRAMBLING [1]).

> +
> +Other properties:
> +see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
> +
> +Example demonstrate on AXG SoC:
> +
> +	sd_emmc_c: mmc at 7000 {
> +		compatible = "simple-bus", "syscon";
> +		reg = <0x0 0x7000 0x0 0x800>;
> +		status = "okay";
> +	};
> +
> +	nand: nfc at 7800 {
> +		compatible = "amlogic,meson-axg-nfc";
> +		reg = <0x0 0x7800 0x0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +		status = "disabled";
> +		clocks = <&clkc CLKID_SD_EMMC_C>,
> +				<&clkc CLKID_SD_EMMC_C_CLK0>,
> +				<&clkc CLKID_FCLK_DIV2>;
> +		clock-names = "core", "clkin0", "clkin1";
> +		amlogic,mmc-syscon = <&sd_mmc_c>;
> +
> +		status = "okay";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&nand_pins>;
> +
> +		nand at 0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			nand-on-flash-bbt;
> +			nand-ecc-mode = "hw";
> +			nand-ecc-strength = <8>;
> +			nand-ecc-step-size = <1024>;
> +
> +			meson-nand-user-mode = <2>;
> +			meson-nand-ran-mode = <1>;
> +
> +			partition at 0 {
> +				label = "boot";
> +				reg = <0x00000000 0x00200000>;
> +				read-only;
> +			};
> +			partition at 200000 {
> +				label = "env";
> +				reg = <0x00200000 0x00400000>;
> +			};
> +			partition at 600000 {
> +				label = "system";
> +				reg = <0x00600000 0x00a00000>;
> +			};
> +			partition at 1000000 {
> +				label = "rootfs";
> +				reg = <0x01000000 0x03000000>;
> +			};
> +			partition at 4000000 {
> +				label = "media";
> +				reg = <0x04000000 0x8000000>;
> +			};

Partitions should be places in a "partitions" subnode:

			partitions {
				compatible = "fixed-partitions";

				...
			};

Also, I'm not sure you need to put that in your example.

> +		};
> +	};


Regards,

Boris

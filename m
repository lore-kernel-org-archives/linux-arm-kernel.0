From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 19 Jul 2018 18:07:25 +0800
Subject: [RFC PATCH v2 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
In-Reply-To: <20180719115751.34ff1a51@bbrezillon>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-2-yixun.lan@amlogic.com>
 <20180719115751.34ff1a51@bbrezillon>
Message-ID: <63bb7f53-81d2-fe98-9ae3-37aae7d8647c@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris:
 see my comments, thanks for the quick response

On 07/19/18 17:57, Boris Brezillon wrote:
> On Thu, 19 Jul 2018 17:46:11 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add Amlogic NAND controller dt-bindings for Meson SoC,
>> Current this driver support GXBB/GXL/AXG platform.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../bindings/mtd/amlogic,meson-nand.txt       | 95 +++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> new file mode 100644
>> index 000000000000..31f910dcd27a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> @@ -0,0 +1,95 @@
>> +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
>> +
>> +This file documents the properties in addition to those available in
>> +the MTD NAND bindings.
>> +
>> +Required properties:
>> +- compatible : contains one of:
>> +  - "amlogic,meson-gxl-nfc"
>> +  - "amlogic,meson-axg-nfc"
>> +- clocks     :
>> +	A list of phandle + clock-specifier pairs for the clocks listed
>> +	in clock-names.
>> +
>> +- clock-names: Should contain the following:
>> +	"core" - NFC module gate clock
>> +	"device" - device clock from eMMC sub clock controller
>> +
>> +- pins     : Select pins which NFC need.
>> +- nand_pins: Detail NAND pins information.
> 
> You should document pinctrl-0 and pinctrl-names, not pins and nand_pins.
> 
Ok, will fix this

>> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>> +				controller port C
> 
> Are you sure this is still needed, even after exposing MMC/NAND clks
> through the CCF?
> 
yes, the SD_EMMC_CLOCK register from eMMC space explore a few other bit
that not fit well into clock model, thus we still need to access them
from NAND driver, we know it's kind of ugly..

#define SD_EMMC_CLOCK                   0x00
#define   CLK_ALWAYS_ON                 BIT(28)
#define   CLK_SELECT_NAND BIT(31)
#define   CLK_DIV_MASK                  GENMASK(5, 0)

we probably could get rid of CLK_DIV_MASK, but need to keep other two


> You forgot
> - #address-cells
> - #size-cells
> - reg
> - interrupts
> - 
> 
will fix these
>> +
>> +Optional children nodes:
>> +Children nodes represent the available nand chips.
>> +
>> +Optional properties:
>> +- amlogic,nand-enable-scrambler: enable the NAND scrambler feature.
>> +	- (absent) = scrambler is disabled
>> +	- (present) = scrambler is enabled
> 
> I keep thinking this is not needed if you have the NAND chip properly
> defined (NAND_NEED_SCRAMBLING flag set in chip->options).
> 
Ok, we will try this flag
>> +
>> +
>> +Other properties:
>> +see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
>> +
>> +Example demonstrate on AXG SoC:
>> +
>> +	sd_emmc_c_clkc: mmc at 7000 {
>> +		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
>> +		reg = <0x0 0x7000 0x0 0x800>;
>> +		status = "okay";
>> +	};
>> +
>> +	nand: nfc at 7800 {
>> +		compatible = "amlogic,meson-axg-nfc";
>> +		reg = <0x0 0x7800 0x0 0x100>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +		status = "disabled";
>> +
>> +		clocks = <&clkc CLKID_SD_EMMC_C>,
>> +			<&sd_emmc_c_clkc CLKID_MMC_DIV>;
>> +		clock-names = "core", "device";
>> +		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>> +
>> +		status = "okay";
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&nand_pins>;
>> +
>> +		nand at 0 {
>> +			reg = <0>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			nand-on-flash-bbt;
>> +			nand-ecc-mode = "hw";
>> +			nand-ecc-strength = <8>;
>> +			nand-ecc-step-size = <1024>;
> 
> I'd recommend not forcing a specific ECC config in the example.
> 
Ok, will fix

>> +
>> +			amlogic,nand-enable-scrambler;
>> +
>> +			partition at 0 {
>> +				label = "boot";
>> +				reg = <0x00000000 0x00200000>;
>> +				read-only;
>> +			};
> 
> Blank line here.
will fix
> 
>> +			partition at 200000 {
>> +				label = "env";
>> +				reg = <0x00200000 0x00400000>;
>> +			};
>> +			partition at 600000 {
>> +				label = "system";
>> +				reg = <0x00600000 0x00a00000>;
>> +			};
>> +			partition at 1000000 {
>> +				label = "rootfs";
>> +				reg = <0x01000000 0x03000000>;
>> +			};
>> +			partition at 4000000 {
>> +				label = "media";
>> +				reg = <0x04000000 0x8000000>;
>> +			};
>> +		};
>> +	};
> 
> .
> 

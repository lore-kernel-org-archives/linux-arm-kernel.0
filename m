From: liang.yang@amlogic.com (Liang Yang)
Date: Mon, 10 Sep 2018 12:46:44 +0800
Subject: [RFC PATCH v3 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
In-Reply-To: <20180907141944.4dd4406b@bbrezillon>
References: <1536317831-58056-1-git-send-email-jianxin.pan@amlogic.com>
 <1536317831-58056-2-git-send-email-jianxin.pan@amlogic.com>
 <20180907141944.4dd4406b@bbrezillon>
Message-ID: <824dd234-30d6-d47d-8abd-352578b232f6@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi boric,

Thanks for your quick reply.

On 9/7/2018 8:19 PM, Boris Brezillon wrote:
> On Fri, 7 Sep 2018 18:57:10 +0800
> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> 
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add Amlogic NAND controller dt-bindings for Meson SoC,
>> Current this driver support GXBB/GXL/AXG platform.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>   .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 91 ++++++++++++++++++++++
>>   1 file changed, 91 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> new file mode 100644
>> index 0000000..655a778
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>> @@ -0,0 +1,91 @@
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
> You mean pinctrl-names and pinctrl-0, right? Not sure it's necessary to
> document that, but if you do, please use the correct DT prop names.
> 

I find no documentation for that in other xx_nand.txt; I will consider 
to remove it.

>> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
>> +				controller port C
>> +
>> +Optional children nodes:
>> +Children nodes represent the available nand chips.
>> +
>> +
>> +
> 
> One too many blank lines here.
> 
ok, i will remove it.

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
> Drop nand-ecc- props. I guess you have a sensible default value and I
> prefer when ECC requirements are directly extracted during chip
> detection. Defining that in the DT is a bad habit. The only one that
> could make sense (assuming you support it) is nand-ecc-maximize.
> 
ok, i will drop them.
we adopt auto detection during init stage, it works too.

>> +
>> +			amlogic,nand-enable-scrambler;
> 
> Please drop this property (it's not longer documented).
> 
em, we should have removed it when nfc driver never use it.

>> +
>> +			partition at 0 {
>> +				label = "boot";
>> +				reg = <0x00000000 0x00200000>;
>> +				read-only;
>> +			};
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
> 
> No need to define the partitions in your example, especially since they
> should be placed in a partitions subnode with a "fixed-partitions"
> compat.
>

ok, i will remove it.

>> +		};
>> +	};
> 
> .
> 

From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Dec 2016 10:52:42 +0100
Subject: [RFT PATCH] ARM64: dts: meson-gxbb: Add reserved memory zone and
 usable memory range
In-Reply-To: <09bb78ed-c8ec-d21f-d464-16e55c481d4e@gmx.de>
References: <20161212101801.28491-1-narmstrong@baylibre.com>
 <09bb78ed-c8ec-d21f-d464-16e55c481d4e@gmx.de>
Message-ID: <56869b90-6bee-f6ae-a7b1-884b4c0d72c0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2016 10:22 PM, Heinrich Schuchardt wrote:
> On 12/12/2016 11:18 AM, Neil Armstrong wrote:
>> The Amlogic Meson GXBB secure monitor uses part of the memory space, this
>> patch adds these reserved zones and redefines the usable memory range for
>> each boards.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  2 +-
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 21 +++++++++++++++++++++
>>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts     |  2 +-
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  2 +-
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi    |  2 +-
>>  .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts   |  2 +-
>>  .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts    |  2 +-
>>  .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts  |  2 +-
>>  .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts      |  2 +-
>>  .../arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts |  2 +-
>>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  2 +-
>>  11 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> index 7a078be..ac40b2d 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>> @@ -56,7 +56,7 @@
>>  
>>  	memory at 0 {
>>  		device_type = "memory";
>> -		reg = <0x0 0x0 0x0 0x80000000>;
>> +		reg = <0x0 0x1000000 0x0 0x7f000000>;
>>  	};
>>  
>>  	vddio_boot: regulator-vddio_boot {
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index fc033c0..e085588 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -55,6 +55,27 @@
>>  	#address-cells = <2>;
>>  	#size-cells = <2>;
>>  
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		secos: secos {
>> +			reg = <0x0 0x05300000 0x0 0x2000000>;
>> +			no-map;
>> +		};
> 
> Hello Neil,
> 
> In
> https://github.com/hardkernel/linux/blob/odroidc2-3.14.y/arch/arm64/boot/dts/meson64_odroidc2.dts
> the secos region does not exist. In linux-next I find no reference to
> the secos label. Where is the consumer of the region defined?
> 
>> +
>> +		pstore: pstore {
>> +			reg = <0x0 0x07300000 0x0 0x100000>;
>> +			no-map;
>> +		};
> 
> In
> https://github.com/hardkernel/linux/blob/odroidc2-3.14.y/arch/arm64/boot/dts/amlogic/gxbb_skt.dts
> and other files pstore uses a different position
> (reg = <0x0 0x20000000 0x0 0x100000>;).
> Why are we moving this?
> Should this region be marked
> compatible = "ramoops"; ?
> Cf. Documentation/devicetree/bindings/reserved-memory/ramoops.txt.
> 
> It would be nice if you could add a short description of each reserved
> area to the commit message.
> 
> Regards
> 
> Heinrich Schuchardt
> 
>> +
>> +		secmon: secmon {
>> +			reg = <0x0 0x10000000 0x0 0x200000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>>  	cpus {
>>  		#address-cells = <0x2>;
>>  		#size-cells = <0x0>;
> 
> 

Hi Heinrich,

Thanks for testing and for the report,
we are still struggling into finding what are these zones and how to label them correctly.

We need to identify the zones on all boards, the patch I provided works on a non-odroid-c2 and gxm and gxl boards.

Neil

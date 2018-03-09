From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Mar 2018 12:52:58 +0100
Subject: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
In-Reply-To: <5AA1F41B.5080104@samsung.com>
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
 <20180307172711.15697-1-s.nawrocki@samsung.com>
 <5AA1F41B.5080104@samsung.com>
Message-ID: <39965bce-a6f2-6202-5c3f-97e4446e97eb@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki,

On 03/09/2018 03:40 AM, Inki Dae wrote:
> 2018? 03? 08? 02:27? Sylwester Nawrocki ?(?) ? ?:
>> This property is required for specifying link between the HDMI IP block
>> and the SoC's audio subsystem.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 56626d1a4235..71d2ede118e3 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -700,6 +700,7 @@
>>  					"sclk_hdmiphy", "mout_hdmi";
>>  			samsung,syscon-phandle = <&pmu_system_controller>;
>>  			phy = <&hdmiphy>;
>> +			#sound-dai-cells = <0>;
> 
> This patch adds this property to hdmi device node which is bound by HDMI driver 
> of Exynos DRM. As we talked about this at other email thread, seems this property 
> is required mandatorily for Odroid XU3/4 board which uses Exynos5422.
> There may be something I'm missing so could you let me know how this property 
> is required?

It is required to properly interpret the list of DAI specified in the 'sound-dai'
property. If a device supports only one DAI it will have #sound-dai-cells = <0>
and the sound-dai property values in cpu<->codec link may look like this:

 cpu { ... }
 codec {
	 sound-dai = <&max98090>, <&hdmi>;
 };

When the CODEC support more DAIs it will have #sound-dai-cells = <1> and we can
additionally specify which DAI we exactly refer to, in this case DAI 0:

 cpu { ... }
 codec {
	sound-dai = <&max98095 0>, <&hdmi>;
 };

More details can be found in documentation of of_parse_phandle_with_args()
function.

The above refers to cpu/codec mapping like I2S0 -> [max9809x, hdmi], on Exynos5433
we have I2S0 -> wm5110 and I2S1 -> hdmi.


-- 
Regards,
Sylwester

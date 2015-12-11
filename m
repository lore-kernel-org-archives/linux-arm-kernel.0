From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 14:28:43 +0900
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <566A56DF.5040001@osg.samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu> <566A4A60.8060402@samsung.com>
 <20151211041349.GO3612@ubuntu> <566A4E82.3040203@samsung.com>
 <20151211043802.GP3612@ubuntu> <566A56DF.5040001@osg.samsung.com>
Message-ID: <566A5F0B.8040609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 13:53, Javier Martinez Canillas wrote:
> Hello Viresh,
> 
> On 12/11/2015 01:38 AM, Viresh Kumar wrote:
>> On 11-12-15, 13:18, Krzysztof Kozlowski wrote:
>>> We had such configuration before (before df09df6f9ac3). I don't see any
>>> benefit in what you described. Where is the "thing" to be fixed? It is
>>> mixed up. The contiguous ordering is easier to read and more natural.
>>
>> This is what you are doing today (keeping on one CPU per cluster to
>> simplify it):
>>
>> 		cpu0: cpu at 0 {
>> 			device_type = "cpu";
>> 			compatible = "arm,cortex-a15";
>> 			reg = <0x0>;
>> 			clock-frequency = <1800000000>;
>> 			cci-control-port = <&cci_control1>;
>> 		};
>>
>> 		cpu4: cpu at 100 {
>> 			device_type = "cpu";
>> 			compatible = "arm,cortex-a7";
>> 			reg = <0x100>;
>> 			clock-frequency = <1000000000>;
>> 			cci-control-port = <&cci_control0>;
>> 		};
>>
>>
>> Then you overwrite it with:
>>
>>                 &cpu0 {
>>                 	device_type = "cpu";
>>                 	compatible = "arm,cortex-a7";
>>                 	reg = <0x100>;
>>                 	clock-frequency = <1000000000>;
>>                 	cci-control-port = <&cci_control0>;
>>                 };
>>                 
>>                 &cpu4 {
>>                 	device_type = "cpu";
>>                 	compatible = "arm,cortex-a15";
>>                 	reg = <0x0>;
>>                 	clock-frequency = <1800000000>;
>>                 	cci-control-port = <&cci_control1>;
>>                 };
>>
>>
>> Don't you think this isn't the right way of solving problems?
>>
>> The DT overwrite feature isn't there to do such kind of stuff, though
>> it doesn't stop you from doing that.
>>
> 
> I still fail to understand why the override is not a good way to solve
> the issue.
>  
>> Either you should keep separate paths for both the SoCs, or can solve
> 
> There's no point IMHO to duplicate the HW description since is the only
> difference between the Exynos5422 and Exynos5800 SoCs AFAIK.

Actually I think there is no nice way of making this as separate paths.
As Javier's mentioned, there aren't many differences. Currently the CPU
ordering is the only difference in DT.

Making it as separate path would create hierarchy like:
 - exynos5420-based-board.dts
   \- include: exynos5420.dtsi
      \- include: exynos5.dtsi
   \- include: exynos5420-cpu.dtsi (the cpus are not in exynos5420.dtsi)

 - exynos5422-based-board.dts
   \- include: exynos5420.dtsi
      \- include: exynos5.dtsi
   \- include: exynos5422-cpu.dtsi (the cpus are not in exynos5420.dtsi)

which of course is okay... except we keep the definition of CPUs
completely outside of main Exynos5420 DTSI. Then we have to include both
DTSI for each new DTS.

Other idea is to create artificial "exynos5420-common":
 - exynos5420-based-board.dts
   \- include: exynos5420.dtsi
       \- include: exynos5420-common.dtsi
          \- include: exynos5.dtsi
       \- include: exynos5420-cpu.dtsi

 - exynos5422-based-board.dts
   \- include: exynos5422.dtsi
      \- include: exynos5420-common.dtsi
         \- include: exynos5.dtsi
      \- include: exynos5422-cpu.dtsi

This is also confusing...

Any third idea?

Best regards,
KRzysztof

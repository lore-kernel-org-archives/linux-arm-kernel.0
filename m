From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 11 Dec 2015 01:53:51 -0300
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <20151211043802.GP3612@ubuntu>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu> <566A4A60.8060402@samsung.com>
 <20151211041349.GO3612@ubuntu> <566A4E82.3040203@samsung.com>
 <20151211043802.GP3612@ubuntu>
Message-ID: <566A56DF.5040001@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Viresh,

On 12/11/2015 01:38 AM, Viresh Kumar wrote:
> On 11-12-15, 13:18, Krzysztof Kozlowski wrote:
>> We had such configuration before (before df09df6f9ac3). I don't see any
>> benefit in what you described. Where is the "thing" to be fixed? It is
>> mixed up. The contiguous ordering is easier to read and more natural.
> 
> This is what you are doing today (keeping on one CPU per cluster to
> simplify it):
> 
> 		cpu0: cpu at 0 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a15";
> 			reg = <0x0>;
> 			clock-frequency = <1800000000>;
> 			cci-control-port = <&cci_control1>;
> 		};
> 
> 		cpu4: cpu at 100 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a7";
> 			reg = <0x100>;
> 			clock-frequency = <1000000000>;
> 			cci-control-port = <&cci_control0>;
> 		};
> 
> 
> Then you overwrite it with:
> 
>                 &cpu0 {
>                 	device_type = "cpu";
>                 	compatible = "arm,cortex-a7";
>                 	reg = <0x100>;
>                 	clock-frequency = <1000000000>;
>                 	cci-control-port = <&cci_control0>;
>                 };
>                 
>                 &cpu4 {
>                 	device_type = "cpu";
>                 	compatible = "arm,cortex-a15";
>                 	reg = <0x0>;
>                 	clock-frequency = <1800000000>;
>                 	cci-control-port = <&cci_control1>;
>                 };
> 
> 
> Don't you think this isn't the right way of solving problems?
> 
> The DT overwrite feature isn't there to do such kind of stuff, though
> it doesn't stop you from doing that.
>

I still fail to understand why the override is not a good way to solve
the issue.
 
> Either you should keep separate paths for both the SoCs, or can solve

There's no point IMHO to duplicate the HW description since is the only
difference between the Exynos5422 and Exynos5800 SoCs AFAIK.

> it the way I suggested earlier.
>

As Krzysztof said, contiguous ordering is more natural and easier to
read and I agree with him.

> This came up because in the current series you are doing this:
> 
> 		cpu0: cpu at 0 {
> 			compatible = "arm,cortex-a15";
>                         operating-points-v2 = <&cpu0_opp_table>;
> 		};
> 
> 		cpu4: cpu at 100 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a7";
>                         operating-points-v2 = <&cpu1_opp_table>;
> 		};
> 
> 
> Then you overwrite it with:
> 
>                 &cpu0 {
>                 	compatible = "arm,cortex-a7";
>                         operating-points-v2 = <&cpu1_opp_table>;

But yes, I agree with you that the OPP tables names are misleading at the
very least for not saying wrong. So yes, either {cluster0,a7,kfc}_opp_table
as you suggest are much better possible names and the same for the a15 one.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

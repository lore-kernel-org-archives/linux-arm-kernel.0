From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 1 Jul 2014 10:49:47 +0300
Subject: [PATCH 4/6] ARM: tegra: Add soctherm and thermal zones to Tegra124
 device tree
In-Reply-To: <53B1CD20.3010008@wwwdotorg.org>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-5-git-send-email-mperttunen@nvidia.com>
 <53B1CD20.3010008@wwwdotorg.org>
Message-ID: <53B2681B.8020805@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inline.

On 30/06/14 23:48, Stephen Warren wrote:
> On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
>> This adds the soctherm thermal sensing and management unit to the
>> Tegra124 device tree along with the four thermal zones it exports.
>
>> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
>
>> +	thermal-zones {
>> +		cpu {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
>
> I think we should still define a polling delay so that if there's SW
> that doesn't support HW trip points/interrupts, it still knows how often
> it should reasonably check the sensor.
>
> Perhaps a delay of 0 is used to determine whether to use HW trip points
> vs polling (I haven't read patch 1 yet)? If so, I'd prefer not to do
> that. Rather, the driver should advertize its ability to provide HW trip
> points, and it would be up to the core to then make use of them. The DT
> should just describe the HW, not assume it can influence SW's choice of
> whether to use HW trip points.

Yes, a delay of 0 disables polling in the thermal core. (The hw trip 
code doesn't do anything with it) One way to fix this would be to export 
a rate changing function in the thermal core and have of-thermal set the 
polling rate to 0 or the value from device tree depending on if hw trip 
point programming succeeded or not. This would also be good for error 
handling, since if hw trip poing programming failed for whatever reason, 
we could still fall back to polling.

>
>> +	soctherm: soctherm at 0,700e2000 {
> ...
>> +		reset-names = "soctherm";
>> +
>> +		#thermal-sensor-cells = <1>;
>
> I don't see any real need for that blank line. If there was, there would
> probably be more blank lines in the big list of properties above.
>

The reasoning was that #thermal-sensor-cells as a cells-property is a 
bit different from the rest, so separate them. But I can remove the 
blank line just as well.

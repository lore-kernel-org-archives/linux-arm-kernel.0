From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 20 Dec 2013 12:23:28 +0530
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <52B355EC.9040306@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-2-git-send-email-treding@nvidia.com>
 <52B355EC.9040306@wwwdotorg.org>
Message-ID: <52B3E968.8090906@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 December 2013 01:54 AM, Stephen Warren wrote:
> On 12/19/2013 09:06 AM, Thierry Reding wrote:

> (Laxman, as an aside, I'm not sure why you're upstreaming patches that
> don't exactly match the existing kernel support for this board...)

I did not get this based on what context it is. Can you please elaborate 
where I am missing the stuff?


>
>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
>> +				sd0 {
>> +					regulator-name = "vdd_cpu";
>> +					regulator-min-microvolt = <700000>;
>> +					regulator-max-microvolt = <1350000>;
> Laxman's patch has:
>
>   					regulator-max-microvolt = <1400000>;

We have the Laguna platform on which Android and L4T is running fine. 
This is based on same PMIC used for Venice2. As we are running the more 
cpu stress on Laguna, I took this parameter from the Laguna Power tree 
where it is maximum 1.4V. Chrome have maximum as 1.35mV.



>
>> +					regulator-always-on;
>> +					ams,ext-control = <2>;
>> +				};
> Laxman's patch adds:
>
>   					regulator-min-microamp = <3500000>;
>   					regulator-max-microamp = <3500000>;
>   					regulator-boot-on;
>
> Those properties (with various values) are added to quite a few nodes; I
> won't bother pointing them out elsewhere.


All rails does not support the current configuration. SD0, SD1 and SD6 
supports this. We have configured these value on Laguna as per system 
eng recommendation for this rails. As the power tree s almost same, I 
configured same here for Venice2. SD0 and SD6 on 3500mA and SD1 is on 
2500mA.



>
>> +				sd1 {
> ...
>> +					regulator-max-microamp = <3500000>;
> Laxman's patch has:
>
>   					regulator-max-microamp = <2500000>;
>
> Laxman's patch adds the following node:
>
>   				sd3 {
>   					regulator-name = "vddio-ddr-2phase";
>   					regulator-min-microvolt = <1350000>;
>   					regulator-max-microvolt = <1350000>;
>   					regulator-always-on;
>   					regulator-boot-on;
>   				};
As per schematic, SD2 and SD3 make 2 phase supply for the DDR. I added 
SD3 so that it should not get disabled at time of unused regulator 
disabled by regulator framework.
>
>> +				sd6 {
> ...
>> +					regulator-min-microvolt = <800000>;
> Laxman's patch has:
>
>   					regulator-min-microvolt = <650000>;

Again from downstream Laguna platform.

>
>> +				ldo6 {
> ...
>> +					regulator-min-microvolt = <3300000>;
> Laxman's patch has:
>
>   					regulator-min-microvolt = <1800000>;
VDDIO SDMMC and I think it is for SD3.0 (UHS) which switches voltage 
from 3.3 to 1.8 on UHS mode by sdmmc driver.

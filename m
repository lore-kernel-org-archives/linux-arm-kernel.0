From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 12 Apr 2016 17:19:53 +0900
Subject: [PATCH v9 07/20] PM / devfreq: exynos: Update documentation for
 bus devices using passive governor
In-Reply-To: <570CA50A.3010505@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
 <1460347078-15175-8-git-send-email-cw00.choi@samsung.com>
 <570CA50A.3010505@samsung.com>
Message-ID: <570CAFA9.2060607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 04? 12? 16:34, Krzysztof Kozlowski wrote:
> On 04/11/2016 05:57 AM, Chanwoo Choi wrote:
>> This patch updates the documentation for passive bus devices and adds the
>> detailed example of Exynos3250.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 250 ++++++++++++++++++++-
>>  1 file changed, 247 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> index 78171b918e3f..03f13d38f1a1 100644
>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -8,22 +8,46 @@ of the bus in runtime. To monitor the usage of each bus in runtime,
>>  the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>  is able to measure the current load of sub-blocks.
>>  
>> +The Exynos SoC includes the various sub-blocks which have the each AXI bus.
>> +The each AXI bus has the owned source clock but, has not the only owned
>> +power line. The power line might be shared among one more sub-blocks.
>> +So, we can divide into two type of device as the role of each sub-block.
>> +There are two type of bus devices as following:
>> +- parent bus device
>> +- passive bus device
>> +
>> +Basically, parent and passive bus device share the same power line.
>> +The parent bus device can only change the voltage of shared power line
>> +and the rest bus devices (passive bus device) depend on the decision of
>> +the parent bus device. If there are three blocks which share the VDD_xxx
>> +power line, Only one block should be parent device and then the rest blocks
>> +should depend on the parent device as passive device.
>> +
>> +	VDD_xxx |--- A block (parent)
>> +		|--- B block (passive)
>> +		|--- C block (passive)
>> +
>>  There are a little different composition among Exynos SoC because each Exynos
>>  SoC has different sub-blocks. Therefore, shch difference should be specified
> 
> s/shch/such/

I'll fix it on patch2 because this typo happen on patch2.

> 
>>  in devicetree file instead of each device driver. In result, this driver
>>  is able to support the bus frequency for all Exynos SoCs.
>>  
>> -Required properties for bus device:
>> +Required properties for all bus devices:
>>  - compatible: Should be "samsung,exynos-bus".
>>  - clock-names : the name of clock used by the bus, "bus".
>>  - clocks : phandles for clock specified in "clock-names" property.
>>  - operating-points-v2: the OPP table including frequency/voltage information
>>    to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
>> +
>> +Required properties only for parent bus device:
>>  - vdd-supply: the regulator to provide the buses with the voltage.
>>  - devfreq-events: the devfreq-event device to monitor the current utilization
>>    of buses.
>>  
>> -Optional properties for bus device:
>> +Required properties only for passive bus device:
>> +- devfreq: the parent bus device.
>> +
>> +Optional properties only for parent bus device:
>>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>>  			the performance count against total cycle count.
>>  - exynos,voltage-tolerance: the percentage value for bus voltage tolerance
>> @@ -34,7 +58,20 @@ Example1:
>>  	power line (regulator). The MIF (Memory Interface) AXI bus is used to
>>  	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
> 
> s/regualtor/regulator/

ditto.

> 
> 
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks for your review.

Best Regards,
Chanwoo Choi

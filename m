From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 1 Jun 2016 16:12:34 -0500
Subject: [PATCH 1/2] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <20160519031559.GK24777@vireshk-i7>
References: <cover.1463609497.git.d-gerlach@ti.com>
 <f17fbc8acb1e903b9f175f49fe29563b83132faf.1463609497.git.d-gerlach@ti.com>
 <20160519031559.GK24777@vireshk-i7>
Message-ID: <574F4FC2.8010509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob/DT folks,
On 05/18/2016 10:15 PM, Viresh Kumar wrote:
> On 18-05-16, 18:30, Dave Gerlach wrote:
>> Add the device tree bindings document for the TI CPUFreq/OPP driver
>> on AM33xx and AM43xx SoCs. The operating-points-v2 binding allows us
>> to provide an opp-supported-hw property for each OPP to define when
>> it is available. This driver is responsible for reading and parsing
>> registers to determine which OPPs can be selectively enabled based
>> on the specific SoC in use by matching against the opp-supported-hw
>> data.
>
> Here and ...
>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>   .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 89 ++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>> new file mode 100644
>> index 000000000000..f719b2df2a1f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>> @@ -0,0 +1,89 @@
>> +Bindings for TI's CPUFreq driver
>> +================================
>> +
>> +The ti-cpufreq driver works with the operating-points-v2 binding described
>> +at [../opp/opp.txt] to make sure the proper OPPs for a platform get enabled
>> +and then creates a "cpufreq-dt" platform device to leverage the cpufreq-dt
>> +driver described in [cpufreq-dt.txt].
>> +
>> +Certain TI SoCs, like those in the am335x, am437x, am57xx, and dra7xx
>> +families support different OPPs depending on the silicon variant in use.
>> +The ti-cpufreq driver uses the revision and an efuse value from the SoC to
>> +provide the OPP framework with supported hardware information. This is used
>> +to determine which OPPs from the operating-points-v2 table get enabled. In
>> +order to maintain backwards compatilibity if this information is not present
>> +the "cpufreq-dt" platform device is still created to attempt to find an
>> +operating-points (v1) table, otherwise no OPPs will be available because
>> +safe OPPs cannot be determined.
>
> ... here..
>
> We shouldn't be talking about the drivers are going to use it, etc.
> This is a binding document, which should be independent of Linux
> kernel. It can be used by other Operating systems as well and so the
> implementation details should be just dropped.
>
>> +
>> +Required properties:
>> +--------------------
>> +In 'cpus' nodes:
>> +- operating-points-v2: Phandle to the operating-points-v2 table to use
>> +- ti,syscon-efuse: Syscon phandle, offset to efuse register, efuse register
>> +		   mask, and efuse register shift to get the relevant bits
>> +		   that describe OPP availability
>> +- ti,syscon-rev: Syscon and offset used to look up revision value on SoC
>
> These are proper sentences and so maybe a full-stop (.) at the end of
> each line ?
>
>> +
>> +In 'operating-points-v2' table:
>> +- opp-supported-hw: Two bitfields indicating:
>> +	1. Which revision of the SoC the OPP is supported by
>> +	2. Which eFuse bits indicate this OPP is available
>> +
>> +	A bitwise and is performed against these values and if any bit
>
>                    AND or &
>
>> +	matches, the OPP gets enabled.
>> +
>> +NOTE: Without the above, platform-device for "cpufreq-dt" is still created
>> +      but no determination of which OPPs should be available is done, but this
>> +      allows for use of a v1 operating-points table.
>
> Again, these are implementation details.. should be dropped.
>
>> +
>> +Example:
>> +--------
>> +
>> +/* From arch/arm/boot/dts/am4372.dtsi */
>> +cpus {
>> +	cpu: cpu at 0 {
>> +		...
>> +
>> +		operating-points-v2 = <&cpu0_opp_table>;
>> +
>> +		ti,syscon-efuse = <&scm_conf 0x610 0x3f 0>;
>> +		ti,syscon-rev = <&scm_conf 0x600>;
>
> @Rob: Can we add properties to the CPU node just like that ?

You may have missed this originally since it's buried in the thread, any 
comment here? Wondering if this is acceptable or if moving the 
properties is preferred.

Regards,
Dave

>
>> +
>> +		...
>> +	};
>> +};
>> +
>> +cpu0_opp_table: opp_table0 {
>> +	compatible = "operating-points-v2";
>
> Otherwise, you could have added above properties right here and added
> your own compatible string..
>
>> +	opp50 at 300000000 {
>> +		opp-hz = /bits/ 64 <300000000>;
>> +		opp-microvolt = <950000>;
>> +		opp-supported-hw = <0xFF 0x01>;
>> +		opp-suspend;
>> +	};
>> +
>> +	opp100 at 600000000 {
>> +		opp-hz = /bits/ 64 <600000000>;
>> +		opp-microvolt = <1100000>;
>> +		opp-supported-hw = <0xFF 0x04>;
>> +	};
>> +
>> +	opp120 at 720000000 {
>> +		opp-hz = /bits/ 64 <720000000>;
>> +		opp-microvolt = <1200000>;
>> +		opp-supported-hw = <0xFF 0x08>;
>> +	};
>> +
>> +	oppturbo at 800000000 {
>> +		opp-hz = /bits/ 64 <800000000>;
>> +		opp-microvolt = <1260000>;
>> +		opp-supported-hw = <0xFF 0x10>;
>> +	};
>> +
>> +	oppnitro at 1000000000 {
>> +		opp-hz = /bits/ 64 <1000000000>;
>> +		opp-microvolt = <1325000>;
>> +		opp-supported-hw = <0xFF 0x20>;
>
> so the first one is always FF ? Why have it then ?
>
>> +	};
>> +};
>

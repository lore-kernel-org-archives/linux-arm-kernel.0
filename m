From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 19 Dec 2013 15:42:28 +0000
Subject: [PATCH V4 3/3] cpufreq: imx6: Add device tree binding document
In-Reply-To: <52B300D4.4090309@arm.com>
References: <1387462609-13013-1-git-send-email-b20788@freescale.com>
 <1387462609-13013-3-git-send-email-b20788@freescale.com>,
 <52B300D4.4090309@arm.com>
Message-ID: <DAA70643-C5BE-404A-93A7-0CCDDE2C3050@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Sent from Anson's iPhone

> ? 2013?12?19??22:21?"Sudeep KarkadaNagesha" <Sudeep.KarkadaNagesha@arm.com> ???
> 
>> On 19/12/13 14:16, Anson Huang wrote:
>> This device tree binding document describes the imx6 cpufreq
>> DT bindings. This document lists all required and optional properties
>> for imx6 cpufreq.
>> 
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>> .../devicetree/bindings/cpufreq/cpufreq-imx6.txt   |   56 ++++++++++++++++++++
>> 1 file changed, 56 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
>> new file mode 100644
>> index 0000000..a14b895
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
>> @@ -0,0 +1,56 @@
>> +i.MX6 cpufreq driver
>> +-------------------
>> +
>> +i.MX6 SoC cpufreq driver for CPU frequency scaling.
>> +
>> +This binding doc defines properties that must be put in the /cpus/cpu at 0 node,
>> +please refer to Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
>> +for detail.
>> +
>> +Required properties:
>> +- operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt
>> +  for details.
>> +- clocks: Specify clocks that need to be used when cpu frequency is scaled,
>> +  refer to Documentation/devicetree/bindings/clock/clock-bindings.txt for
>> +  details.
>> +- clock-names: List of clock input name strings sorted in the same order as the
>> +  clocks property, refer to Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +  for details.
>> +- xxx-supply: Input voltage supply regulator, refer to
>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>> +  arm-supply: regulator node supplying arm.
>> +  pu-supply: regulator node supplying pu.
>> +  soc-supply: regulator node supplying soc.
>> +
>> +Optional properties:
>> +- fsl,soc-operating-points: Specify vddsoc/pu voltage settings that must
>> +  go with cpu0's operating-points.
>> +- clock-latency: Specify the possible maximum transition latency for clock,
>> +  in unit of nanoseconds.
>> +
> 
> Sorry if I am missing something obvious as I have not followed the previous
> versions and corresponding comments.
> 
> Should these SoC properties be part of cpu node ? If so which cpu or why cpu0 ?
yes, these properties are for cpufreq function, as on SMP system, all CPUs are running at same freq, cpufreq is tied to cpu0, so we put them in cpu0's node. 


> IIUC it's more a SoC properties which also influences ARM CPU OPPs. IOW other
> regulators may depend on pu/soc-supply. In that case it would be cleaner if that
> dependency is setup through regulators framework.

the truth is that arm power domain has no level shift with sic/pu domain, so when arm domain voltage is changed, soc/pu domain need to be changed too, more like multi OPP concept. there is no other regulators depend on soc/pu supply.

anson.
> 
>> +Examples:
>> +
>> +    cpu at 0 {
>> +        operating-points = <
>> +            /* kHz    uV */
>> +            1200000 1275000
>> +            996000  1250000
>> +            792000  1150000
>> +            396000  975000
>> +        >;
>> +        fsl,soc-operating-points = <
>> +            /* ARM kHz  SOC-PU uV */
>> +            1200000 1275000
>> +            996000    1250000
>> +            792000    1175000
>> +            396000    1175000
>> +        >;
>> +        clock-latency = <61036>; /* two CLK32 periods */
>> +        clocks = <&clks 104>, <&clks 6>, <&clks 16>,
>> +             <&clks 17>, <&clks 170>;
>> +        clock-names = "arm", "pll2_pfd2_396m", "step",
>> +                  "pll1_sw", "pll1_sys";
>> +        arm-supply = <&reg_arm>;
>> +        pu-supply = <&reg_pu>;
>> +        soc-supply = <&reg_soc>;
>> +    };
> 
> 
> 
> 

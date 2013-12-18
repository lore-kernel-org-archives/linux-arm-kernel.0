From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Wed, 18 Dec 2013 23:31:47 +0000
Subject: [PATCH V3 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
In-Reply-To: <20131218142157.GL6691@S2101-09.ap.freescale.net>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>,
 <20131218142157.GL6691@S2101-09.ap.freescale.net>
Message-ID: <43A4EB83-ED8F-43F8-A458-4AEEDA886008@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Sent from Anson's iPhone

> ? 2013?12?18??22:21?"Shawn Guo" <shawn.guo@linaro.org> ???
> 
>> On Wed, Dec 18, 2013 at 04:26:49PM -0500, Anson Huang wrote:
>> i.MX6Q needs to update vddarm, vddsoc/pu regulators when cpu freq
>> is changed, each setpoint has different voltage, so we need to
>> pass vddarm, vddsoc/pu's freq-voltage info from dts together.
>> 
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>> .../devicetree/bindings/cpufreq/cpufreq-imx6.txt   |   56 ++++++++++++++++++++
> 
> As I said in V2 review, the device tree binding doc change should be
> part of driver patch (patch #2 in this case) or a separate patch, but
> never be in the same patch as DTS change.

I missed that one, sorry for that, then I will send out a V4 patch set.
> 
> Shawn
> 
>> arch/arm/boot/dts/imx6q.dtsi                       |    7 +++
>> 2 files changed, 63 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
>> new file mode 100644
>> index 0000000..cf1c5f7
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
>> +  arm-supply: vddarm input.
>> +  pu-supply: vddpu input.
>> +  soc-supply: vddsoc input.
>> +
>> +Optional properties:
>> +- fsl,soc-operating-points: Specify vddsoc/pu voltage settings that must
>> +  go with cpu0's operating-points.
>> +- clock-latency: Specify the possible maximum transition latency for clock,
>> +  in unit of nanoseconds.
>> +
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
>> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
>> index e7e8332..021e0cb 100644
>> --- a/arch/arm/boot/dts/imx6q.dtsi
>> +++ b/arch/arm/boot/dts/imx6q.dtsi
>> @@ -30,6 +30,13 @@
>>                792000  1150000
>>                396000  975000
>>            >;
>> +            fsl,soc-operating-points = <
>> +                /* ARM kHz  SOC-PU uV */
>> +                1200000 1275000
>> +                996000    1250000
>> +                792000    1175000
>> +                396000    1175000
>> +            >;
>>            clock-latency = <61036>; /* two CLK32 periods */
>>            clocks = <&clks 104>, <&clks 6>, <&clks 16>,
>>                 <&clks 17>, <&clks 170>;
>> -- 
>> 1.7.9.5
> 

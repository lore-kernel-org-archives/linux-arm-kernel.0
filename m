From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 6 Feb 2017 19:17:46 +0100
Subject: [PATCH 0/2] scpi: RfC - Allow to ignore invalid SCPI DVFS clock
 rates
In-Reply-To: <bd6d2a14-a3e5-ddfb-ab7d-3b0835bcab62@baylibre.com>
References: <a4c725a9-2f79-a48b-b732-61e1fe31aba8@gmail.com>
 <bd6d2a14-a3e5-ddfb-ab7d-3b0835bcab62@baylibre.com>
Message-ID: <5fc3c64a-84cf-cb47-45a5-ea05f9fd8334@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.02.2017 um 10:27 schrieb Neil Armstrong:
> On 02/04/2017 10:03 PM, Heiner Kallweit wrote:
>> On the Odroid C2 (Amlogic S905GXBB) the firmware defines SCPI DVFS cpu
>> clock rates which make the system crash or at least unstable.
>> Therefore cpufreq can't be used on this system as of today.
>> Other systems might face similar issues with too optimistic SCPI SVFS
>> clock rates.
>>
>> This RfC patch series addresses this by allowing to define a max
>> frequency per clock via DT. All frequencies for the respective clock
>> exceeding this threshold will be ignored.
>>
>> Heiner Kallweit (2):
>>   clk: scpi: RfC - Allow to ignore invalid SCPI DVFS clock rates
>>   cpufreq: scpi: RfC - Allow to ignore invalid SCPI DVFS clock rates
>>
>>  Documentation/devicetree/bindings/arm/arm,scpi.txt |  7 +++++++
>>  drivers/clk/clk-scpi.c                             | 15 ++++++++++++++-
>>  drivers/cpufreq/scpi-cpufreq.c                     | 22 ++++++++++++++++++++++
>>  3 files changed, 43 insertions(+), 1 deletion(-)
>>
> 
> Hi Heiner,
> 
> Thanks for this pathset, I have an alternative patchset for this feature.
> 
> My patchset adds a maximum frequency in the cpu node, this permits cleanly specifying
> a max frequency per cluster and leave the SCPI code intact since it's only a protocol
> implementation.
> 
I also thought about this option. Right, it's simpler and most likely sufficient.
To me the other option seems to be more generic as it covers also potential similar
issues with other SCPI DVFS clocks and their consumers.

I'm fine with either option, I just want a working cpufreq on my Odroid C2 ..

Heiner

> Please find below a simpler implementation only touching the scpi-cpufreq code.
> 
> Anyway, Sudeep, could you give us your point of view about such changes ?
> 
> Neil
> 
> ----><--
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index a1bcfee..b813933 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -276,6 +276,14 @@ nodes to be present and contain the properties described below.
> 
>  			    where voltage is in uV, frequency is in MHz.
> 
> +	- arm,scpi-dvfs-max-freq
> +		Usage: optional
> +		Value type: <u32>
> +		Definition:
> +			Specifies the maximum DVFS frequency in Hz unit this
> +			CPU can support when the OPP tables are obtained via
> +			the SCP interface.
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
> 
>  	cpus {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 238fbea..881f20c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -137,6 +137,22 @@
>  	};
>  };
> 
> +&cpu0 {
> +	arm,scpi-dvfs-max-freq = <1536000000>;
> +};
> +
> +&cpu1 {
> +	arm,scpi-dvfs-max-freq = <1536000000>;
> +};
> +
> +&cpu2 {
> +	arm,scpi-dvfs-max-freq = <1536000000>;
> +};
> +
> +&cpu3 {
> +	arm,scpi-dvfs-max-freq = <1536000000>;
> +};
> +
>  &uart_AO {
>  	status = "okay";
>  	pinctrl-0 = <&uart_ao_a_pins>;
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index ea7a4e1..80a6f27b 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -25,6 +25,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/scpi_protocol.h>
>  #include <linux/types.h>
> +#include <linux/of.h>
> 
>  #include "arm_big_little.h"
> 
> @@ -54,6 +55,11 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
>  	struct scpi_opp *opp;
>  	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
>  	struct scpi_dvfs_info *info = scpi_get_dvfs_info(cpu_dev);
> +	u32 max_freq = 0;
> +
> +	/* Eventually get a platform frequency limitation */
> +	of_property_read_u32(cpu_dev->of_node, "arm,scpi-dvfs-max-freq",
> +			     &max_freq);
> 
>  	if (IS_ERR(info))
>  		return PTR_ERR(info);
> @@ -62,6 +68,10 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
>  		return -EIO;
> 
>  	for (opp = info->opps, idx = 0; idx < info->count; idx++, opp++) {
> +		/* Drop unsupported frequencies */
> +		if (max_freq && opp->freq > max_freq)
> +			continue;
> +
>  		ret = dev_pm_opp_add(cpu_dev, opp->freq, opp->m_volt * 1000);
>  		if (ret) {
>  			dev_warn(cpu_dev, "failed to add opp %uHz %umV\n",
> 

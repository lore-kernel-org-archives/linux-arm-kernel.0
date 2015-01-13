From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 13 Jan 2015 17:55:22 +0900
Subject: [PATCHv3 1/8] devfreq: exynos: Add generic exynos memory bus
 frequency driver
In-Reply-To: <520952065.968311421138534993.JavaMail.weblogic@epmlwas05d>
References: <520952065.968311421138534993.JavaMail.weblogic@epmlwas05d>
Message-ID: <54B4DD7A.504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Myungjoo,

On 01/13/2015 05:42 PM, MyungJoo Ham wrote:
>>   
>>  This patch adds the generic exynos bus frequency driver for memory bus
>> with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
>> for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
>> support the memory bus frequency driver for Exynos SoCs.
>>
>> Each memory bus block has a clock for memory bus speed and frequency
>> table which is changed according to the utilization of memory bus on runtime.
>> And then each memory bus group has the one more memory bus blocks and
>> OPP table (including frequency and voltage), regulator, devfreq-event
>> devices.
>>
>> There are a little difference about the number of memory bus because each Exynos
>> SoC have the different sub-IP and different memory bus speed. In spite of this
>> difference among Exynos SoCs, we can support almost Exynos SoC by adding
>> unique data of memory bus to devicetree file.
>>
>> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/Kconfig          |  15 +
>>  drivers/devfreq/Makefile         |   1 +
>>  drivers/devfreq/exynos-busfreq.c | 589 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 605 insertions(+)
>>  create mode 100644 drivers/devfreq/exynos-busfreq.c
> 
> Exynos drivers are located at drivers/devfreq/exynos/
> Please relocate/rename exynos-busfreq.c

OK. I'll move it at drivers/devfreq/exynos directory.
Do you prefer 'exynos-bus.c' instead of 'exynos-busfreq.c'?
If you reply, I'll change it.

> 
> []
> 
>> diff --git a/drivers/devfreq/exynos-busfreq.c b/drivers/devfreq/exynos-busfreq.c
>> new file mode 100644
>> index 0000000..b180f43
>> --- /dev/null
>> +++ b/drivers/devfreq/exynos-busfreq.c
> 
> []
> 
>> +
>> +#define BUS_SATURATION_RATIO	40
> 
> In order to be a common driver, this should be tunable.
> 
> Because .dts is supposed to have hardware configuration only,
> you may keep a table of { chip-name, saturation ratio} in this
> driver and look up the saturation ratio based on the chip-name.

OK, I'll add new property for saturation_ratio.

I'll implement to use default saturation_ratio value ,
if dt node don't include saturation_ratio property.

> 
>> +#define SAFEVOLT		50000
>> +
>> +struct exynos_memory_bus_opp_info {
>> +	unsigned long rate;
>> +	unsigned long volt;
>> +};
>> +
>> +struct exynos_memory_bus_block {
>> +	struct clk *clk;
>> +	struct exynos_memory_bus_opp_info *freq_table;
>> +};
>> +
> 
> []
> 
>> +#ifdef CONFIG_PM_SLEEP
>> +static int exynos_busfreq_resume(struct device *dev)
>> +{
>> +	struct exynos_memory_bus_data *data = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = exynos_busfreq_enable_edev(data);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to enable the devfreq-event devices\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int exynos_busfreq_suspend(struct device *dev)
>> +{
>> +	struct exynos_memory_bus_data *data = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = exynos_busfreq_disable_edev(data);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to disable the devfreq-event devices\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif
> 
> Please disable regulator at suspend and resume it at resume.
> 
> You may interfere with low-power mode of corresponding voltage line,
> which is often implemented to be activated if the regulator is
> explicitely disabled for "alive" regulators like this one.

OK, I'll modify it.

Thanks for your review.

Best Regards,
Chanwoo Choi

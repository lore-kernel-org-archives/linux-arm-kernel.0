From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 18 Jul 2013 09:24:31 +0100
Subject: [RFC PATCH v2 11/15] cpufreq: kirkwood-cpufreq: remove device
 tree parsing for cpu nodes
In-Reply-To: <20130717144355.GE1026@lunn.ch>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374069984-20567-12-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20130717144355.GE1026@lunn.ch>
Message-ID: <51E7A63F.7020207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/13 15:43, Andrew Lunn wrote:
> On Wed, Jul 17, 2013 at 03:06:20PM +0100, Sudeep.KarkadaNagesha at arm.com wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Now that the cpu device registration initialises the of_node(if available)
>> appropriately for all the cpus, parsing here is redundant.
>>
>> This patch removes all DT parsing and uses cpu->of_node instead.
>>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> ---
>>  drivers/cpufreq/kirkwood-cpufreq.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
>> index c233ea6..18aa3eb 100644
>> --- a/drivers/cpufreq/kirkwood-cpufreq.c
>> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/module.h>
>>  #include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>> +#include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>> @@ -165,6 +166,7 @@ static struct cpufreq_driver kirkwood_cpufreq_driver = {
>>  static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>>  {
>>  	struct device_node *np;
>> +	struct device *cpu_dev;
>>  	struct resource *res;
>>  	int err;
>>  
>> @@ -175,9 +177,17 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>>  	if (IS_ERR(priv.base))
>>  		return PTR_ERR(priv.base);
>>  
>> -	np = of_find_node_by_path("/cpus/cpu at 0");
>> -	if (!np)
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev) {
>> +		dev_err(&pdev->dev, "failed to get cpu device\n");
>>  		return -ENODEV;
>> +	}
>> +
>> +	np = of_node_get(cpu_dev->of_node);
>> +	if (!np) {
>> +		dev_err(&pdev->dev, "failed to get cpu device node\n");
>> +		return -ENODEV;
>> +	}
> 
> Hi Sudeep
> 
> Are we not going a bit backwards here? You are replacing two lines
> with 10 lines.
> 
> How about putting these 10 lines into some helper,
> of_get_cpu_device()?  It would be useful for spear, kirkwood and
> imx6q, and maybe others.
> 
Yes I realised that after making changes to this and pmac32 drivers. I
have already made those changes in v3. I am waiting for more response
before posting them.

Regards,
Sudeep

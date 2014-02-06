From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 6 Feb 2014 16:09:41 +0200
Subject: [PATCH v5 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <20140206003526.GQ20228@joshc.qualcomm.com>
References: <1391608060-10760-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391608060-10760-2-git-send-email-ivan.khoronzhuk@ti.com>
 <20140206003526.GQ20228@joshc.qualcomm.com>
Message-ID: <52F397A5.8030201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 02:35 AM, Josh Cartwright wrote:
> Hey Ivan-
>
> On Wed, Feb 05, 2014 at 03:47:38PM +0200, Ivan Khoronzhuk wrote:
>> Add broadcast clock-event device for the Keystone arch.
>>
>> The timer can be configured as a general-purpose 64-bit timer,
>> dual general-purpose 32-bit timers. When configured as dual 32-bit
>> timers, each half can operate in conjunction (chain mode) or
>> independently (unchained mode) of each other.
>>
>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>> Acked-by: Santosh shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/timer-keystone.c | 233 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 234 insertions(+)
>>   create mode 100644 drivers/clocksource/timer-keystone.c
>>
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index c7ca50a..4abe5aa 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -37,3 +37,4 @@ obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
>>   obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
>>   obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
>>   obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
>> +obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
>> diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
>> new file mode 100644
>> index 0000000..2299666
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-keystone.c
>> +static void __init keystone_timer_init(struct device_node *np)
>> +{
>> +	struct clock_event_device *event_dev = &timer.event_dev;
>> +	unsigned long rate;
>> +	struct clk *clk;
>> +	int irq, error;
>> +	u32 tgcr;
>> +
>> +	irq  = irq_of_parse_and_map(np, 0);
>> +	if (irq == NO_IRQ) {
>> +		pr_err("%s: failed to map interrupts\n", __func__);
>> +		return;
>> +	}
>> +
>> +	timer.base = of_iomap(np, 0);
>> +	if (!timer.base) {
>> +		pr_err("%s: failed to map registers\n", __func__);
>> +		return;
>> +	}
>> +
>> +	clk = of_clk_get(np, 0);
>> +	if (!clk) {
> This condition should be IS_ERR(clk).

Thanks Josh,
I'll fix it.

-- 
Regards,
Ivan Khoronzhuk

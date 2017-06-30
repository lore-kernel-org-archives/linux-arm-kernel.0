From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 30 Jun 2017 09:24:54 +0800
Subject: [RFC PATCH] pinctrl: rockchip: add irq_shutdown
In-Reply-To: <20170629220532.GA54678@google.com>
References: <1498223019-9123-1-git-send-email-jeffy.chen@rock-chips.com>
 <20170629220532.GA54678@google.com>
Message-ID: <5955A866.20308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi brian,

On 06/30/2017 06:05 AM, Brian Norris wrote:
> On Fri, Jun 23, 2017 at 09:03:39PM +0800, Jeffy Chen wrote:
>> Currently the rockchip pinctrl driver would try to enable/disable the
>> gpio bank clk when enable/disable an irq.
>>
>> So when the irq core trying to shutdown an already disabled irq, it
>> would result in unbalanced clk disable request:
>> [   35.911955] WARNING: at drivers/clk/clk.c:680
>> ...
>> [   37.272271] Call trace:
>> [   37.274729] [<ffffffc0007ac270>] clk_core_disable+0x28/0x194
>> [   37.280395] [<ffffffc0007ac6a8>] clk_disable+0x34/0x48
>> [   37.285544] [<ffffffc0004f3bf0>] rockchip_irq_disable+0x30/0x3c
>> [   37.291472] [<ffffffc00027a7e0>] __irq_disable+0x40/0x64
>> [   37.296791] [<ffffffc00027a86c>] irq_shutdown+0x68/0x8c
>> [   37.302023] [<ffffffc0002777fc>] __free_irq+0x110/0x218
>> [   37.307254] [<ffffffc0002779a8>] free_irq+0x54/0x64
>> [   37.312138] [<ffffffc00027ba24>] devm_irq_release+0x24/0x30
>>
>> Add an irq_shutdown callback, and do a sanity check for irq state to
>> prevent that.
>
> IMO, this patch is completely the wrong approach. Either we:
>
> (a) follow the current semantics of the irqchip core handling (which
> tglx described more or less as "no refcounting; no guarantee that
> enable/disable are balanced") or
>
> (b) fix the irqchip core to provide the above guarantee
right, since we have:
bf22ff45 genirq: Avoid unnecessary low level irq function calls
d829b8f genirq: Set irq masked state when initializing irq_desc

this issue should be fixed now.
>
> To do (a) properly would be rather trivial too; just keep an extra
> bitmask in the bank struct to track the "enabled" state of each
> interrupt. If the mask is non-zero, enable the clock; if zero, disable.
> (Incidentally, this is pretty similar logic to what you ended up with on
> your SPI runtime PM / set_cs() patches recently.)
>
> This patch does neither (a) nor (b), and so I'd tend to reject it.
>
> Brian
>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   drivers/pinctrl/pinctrl-rockchip.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
>> index 607f52c..b0e3130 100644
>> --- a/drivers/pinctrl/pinctrl-rockchip.c
>> +++ b/drivers/pinctrl/pinctrl-rockchip.c
>> @@ -2551,6 +2551,12 @@ static void rockchip_irq_disable(struct irq_data *d)
>>   	clk_disable(bank->clk);
>>   }
>>
>> +static void rockchip_irq_shutdown(struct irq_data *d)
>> +{
>> +	if (!irqd_irq_disabled(d))
>> +		rockchip_irq_disable(d);
>> +}
>> +
>>   static void rockchip_irq_bus_lock(struct irq_data *d)
>>   {
>>   	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>> @@ -2641,6 +2647,7 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
>>   		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
>>   		gc->chip_types[0].chip.irq_enable = rockchip_irq_enable;
>>   		gc->chip_types[0].chip.irq_disable = rockchip_irq_disable;
>> +		gc->chip_types[0].chip.irq_shutdown = rockchip_irq_shutdown;
>>   		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
>>   		gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
>>   		gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
>> --
>> 2.1.4
>>
>>
>
>
>

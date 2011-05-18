From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 16:46:41 +0100
Subject: [PATCH] ARM: bcmring: fix patches to convert to sp804 clockevents
In-Reply-To: <4DD307E2.7010302@broadcom.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
	<4DD2FF02.1020508@broadcom.com>
	<20110517232015.GC5913@n2100.arm.linux.org.uk>
	<4DD307E2.7010302@broadcom.com>
Message-ID: <20110518154641.GK5913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 04:42:26PM -0700, Jiandong Zheng wrote:
> On 5/17/2011 4:20 PM, Russell King - ARM Linux wrote:
>> On Tue, May 17, 2011 at 04:04:34PM -0700, Jiandong Zheng wrote:
>>> @@ -232,12 +230,14 @@ void __init bcmring_init_timer(void)
>>>   	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
>>>   	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
>>>
>>> +	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>>> +
>>
>> As we have the init_early callback in the machine record, can this be
>> done at that point, rather than sticking it in the timer init callback?
>>
> It should be OK as long as the table is added early enough but leave it  
> here make it a little easier to understand the init order.
>
> clkdev_add_table() was called by init_machine() which is too late while  
> some other machines still do similar thing. Should we move  
> clkdev_add_table() to init_early for all SoC using sp804?

Yes please.  The order in which things are called is as the struct is
layed out:

fixup
reserve
map_io
init_early
init_irq
timer->init
init_machine

From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Thu, 2 May 2013 09:20:18 +0000
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <20130502085233.GO32299@pengutronix.de>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-2-git-send-email-b35083@freescale.com>
 <20130502085233.GO32299@pengutronix.de>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851B3C47@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
>Sent: Thursday, May 02, 2013 4:53 PM
>To: Lu Jingchang-B35083
>Cc: linux-arm-kernel at lists.infradead.org; shawn.guo at linaro.org
>Subject: Re: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
>
>> +static int __init pit_clocksource_init(struct clk *pit_clk) {
>> +	unsigned int c = clk_get_rate(pit_clk);
>> +
>> +	sched_clock_reg = clksrc_base + PITCVAL;
>> +
>> +	setup_sched_clock(mvf_read_sched_clock, 32, c);
>> +	return clocksource_mmio_init(clksrc_base + PITCVAL, "pit", c, 300,
>32,
>> +			clocksource_mmio_readl_down);
>> +}
>> +
>> +/* set clock event */
>> +static int pit_set_next_event(unsigned long delta,
>> +				struct clock_event_device *unused) {
>> +	pit_timer_disable();
>> +	__raw_writel(delta - 1, clkevt_base + PITLDVAL);
>> +	pit_irq_acknowledge();
>> +	pit_timer_enable();
>
>You disable/enable the timer each time here, is this necessary? You will
>get a drift in the timer, that's really not nice.
>
[Lu Jingchang-B35083] 
  Disable/enable the timer each time is due to the pit hardware mechanism: Writing a new value to PIT_LDVAL register will not restart the timer; instead the value will be loaded after the timer expires. To abort the current cycle and start a timer period with the new value, the timer must be disabled and enabled again.
  It won't affect the clocksoure timer which runs continuously and separately.
  Thanks!


Best Regards,
Jingchang Lu

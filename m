From: bill4carson@gmail.com (bill4carson)
Date: Mon, 25 Feb 2013 15:04:32 +0800
Subject: test jiffies on ARM SMP board
In-Reply-To: <20130220173014.GY17852@n2100.arm.linux.org.uk>
References: <BLU002-W18453B5FE6CB5CDDA18C8DBCF60@phx.gbl>
 <1361381081.16206.45.camel@anish-Inspiron-N5050>
 <20130220173014.GY17852@n2100.arm.linux.org.uk>
Message-ID: <512B0D00.3000403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2013?02?21? 01:30, Russell King - ARM Linux wrote:
> On Wed, Feb 20, 2013 at 10:54:41PM +0530, anish kumar wrote:
>> On Thu, 2013-02-21 at 00:39 +0800, buyitian wrote:
>>> i am confused about my test. in one device driver,
>>> i put below code:
>>>
>>>      printk("start to test test jiffies\n");
>>>
>>>      local_irq_save(flags);
>>>
>>>      jf1 = jiffies; // read jiffies first time
>>>
>>>      // hold cpu for about 2 seconds(do some calculation)
>>>
>>>      jf2 = jiffies; // read jiffies after 2 seconds
>>>
>>>      local_irq_restore(flags);
>>>
>>>      printk("jf1:%lu, jf2:%lu\n", jf1, jf2);
>>>
>>> and the output is as below:
>>>
>>>      <4>[  108.551124]start to test test jiffies
>>>      <4>[  110.367604]jf1:4294948151, jf2:4294948151
>>>
>>> the jf1 and jf2 are the same value, although they are
>>> read between 2 seconds interval, i think this is because
>>> i disabled local interrupt.
>>> but the printk timestamp is from 108.551124 to 110.367604,
>>> which is about 2 seconds. and on my platform, printk timestamp
>>> is got from the function read_sched_clock:
>>>     static u32 __read_mostly (*read_sched_clock)(void) = jiffy_sched_clock_read;
>>>
>>> and function jiffy_sched_clock_read() is to read from jiffies.
>>>
>>> it seems that the jiffies is frozen when local irq is disabled,
>>> but after local_irq_restore(), the jiffies not only start
>>> to run, but also recover the lost 2 seconds.
>>>
>>> is the jiffies updated from another cpu when irq is disabled on
>>> local cpu?
>>>
>>> is there some internel processor interrupt between cpu1 and cpu0
>>> after local irq is re-enabled so that jiffies recover the lost 2 seconds? 		 	   		
>> I think it is because of the fact that some RTC registers keep the
>
> The RTC has nothing to do with this.
>
> As soon as the IRQs are allowed again (immediately after the
> local_irq_restore()) the pending interrupt - including the timer
> interrupt will be processed.
>
> At this point, because we read the clocksource, we can see that two
> seconds have passed, and so we advance jiffies by the elapsed time.

  80 /*
  81  * Event handler for periodic ticks
  82  */
  83 void tick_handle_periodic(struct clock_event_device *dev)
  84 {
  85     int cpu = smp_processor_id();
  86     ktime_t next;
  87
  88     tick_periodic(cpu);
  89
  90     if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
  91         return;
  92     /*
  93      * Setup the next period for devices, which do not have
  94      * periodic mode:
  95      */
  96     next = ktime_add(dev->next_event, tick_period);
  97     for (;;) {
  98         if (!clockevents_program_event(dev, next, ktime_get()))   <--- once irq enabled, here we got -ETIME, then
  99             return;
100         /*
101          * Have to be careful here. If we're in oneshot mode,
102          * before we call tick_periodic() in a loop, we need
103          * to be sure we're using a real hardware clocksource.
104          * Otherwise we could get trapped in an infinite
105          * loop, as the tick_periodic() increments jiffies,
106          * when then will increment time, posibly causing
107          * the loop to trigger again and again.
108          */
109         if (timekeeping_valid_for_hres())
110             tick_periodic(cpu);                                  <---- here, we add missing jiffies
111         next = ktime_add(next, tick_period);
112     }
113 }


>
> This means printk() sees that the two seconds have passed.  But because
> you're reading from jiffies within the interrupt disabled region, that
> code can't see the missed ticks.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
?????????,??????????

--bill

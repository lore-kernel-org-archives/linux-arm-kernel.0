From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2012 14:25:51 +0000
Subject: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
In-Reply-To: <20120118141147.GN16726@n2100.arm.linux.org.uk>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
 <20120118115952.GM16726@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
 <20120118141147.GN16726@n2100.arm.linux.org.uk>
Message-ID: <4F16D66F.2000602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/12 14:11, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2012 at 01:34:55PM +0000, Hiremath, Vaibhav wrote:
>> On Wed, Jan 18, 2012 at 17:29:52, Russell King - ARM Linux wrote:
>>> On Wed, Jan 18, 2012 at 04:58:02PM +0530, Vaibhav Hiremath wrote:
>>>> Convert counter_32k clocksource driver to standard platform_driver
>>>> and move it drivers/clocksource/ directory.
>>>>
>>>> Also, rename it to more generic name "omap-32k.c".
>>>
>>> NAK.  sched_clock is supposed to be available early.  Platform device
>>> driver initialization is FAR too late.
>>>
>> Russell,
>>
>> Sched_clock is available very early during boot sequence. Initially gp-timer 
>> (dmtimer) will get registered as a clocksource. Please refer to the file
>> mach-omap2/timer.c
>>
>> 32k_sync timer (omap-32k.c) will come get registered during arch_init.
>>
>> Just FYI, the way I tested it is, I used kernel parameter 
>> "clocksourse=counter-32k", the switch from gp-timer to 32k timer
>> will happen once it gets registered.
> 
> So please delete the sched_clock code from the 32k timer stuff you've
> moved to a platform driver.  It will cause sched_clock to reset to zero,
> and that's bad news.
> 
> Only one sched_clock() should ever be registered, and that should only be
> registered very early at boot time.

The kernel will WARN if two sched_clock() are registered. I hope this
will be enough for people not to persist with such a thing...

	M.
-- 
Jazz is not dead. It just smells funny...

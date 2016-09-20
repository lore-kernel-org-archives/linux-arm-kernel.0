From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 19 Sep 2016 21:37:06 -0700
Subject: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
In-Reply-To: <20160919223616.GN1041@n2100.armlinux.org.uk>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
 <20160919200816.GC29242@roeck-us.net>
 <20160919223616.GN1041@n2100.armlinux.org.uk>
Message-ID: <0909debb-f7df-648b-95d2-23b535e5b299@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2016 03:36 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 19, 2016 at 01:08:16PM -0700, Guenter Roeck wrote:
>> On Mon, Sep 19, 2016 at 09:12:14PM +0200, Robert Jarzmik wrote:
>>> The OS timer rate used for the watchdog can now be fetched from the
>>> standard clock API. This will remove the last user of
>>> get_clock_tick_rate() in both pxa and sa11x0 architectures.
>>>
>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> Did you test this ? Potential problem, if built into the kernel, could be that
>> the clocks might not be ready by the time the driver is instantiated. Unless
>> this is converted to a platform driver, it won't be able to handle a
>> -EPROBE_DEFER from the clock subsystem.
>
> Really not a problem at all.  The OSTIMER0 is required for the system
> tick, and if that's not present, the kernel will be without any kind
> of time keeping, so a missing watchdog driver is the least of the
> problems.
>
> Therefore, both PXA and SA11x0 register their clocks really early to
> ensure that OSTIMER0 is available by the time_init() stage, which is
> way before driver probe time.
>

You are right. And, at least in qemu, it actually works.

Thanks,
Guenter

From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 22 Mar 2015 22:50:28 -0700
Subject: [PATCH 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
In-Reply-To: <20150323053355.GJ2825@tarshish>
References: <6bc6e867b500cd3cfc629b96f90442f5c0aced3a.1427028036.git.baruch@tkos.co.il>
 <409ece75204d3911dc526a9bc0c908fc30893b26.1427028036.git.baruch@tkos.co.il>
 <550EF4DA.6040407@roeck-us.net> <20150322180857.GI2825@tarshish>
 <550F111F.9060400@roeck-us.net> <20150323053355.GJ2825@tarshish>
Message-ID: <550FA9A4.5010304@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2015 10:33 PM, Baruch Siach wrote:

> [...]
>
>>>>> +	wdt->restart_handler.notifier_call = dc_restart_handler;
>>>>> +	wdt->restart_handler.priority = 128;
>>>>
>>>> Is 128 intentional, ie is this the expected reset method for this platform ?
>>>> If not, it may be better to select a lower priority (eg 64). Using a watchdog
>>>> to reset a system should in general be a method of last resort.
>>>
>>> Copied this value from imx2_wdt. grep indicates that almost all other watchdog
>>> drivers implementing restart_handler use priority of 128 (except bcm47xx_wdt).
>>> What is the policy here?
>>
>> The policy is to do what is sensible for the platform. That can only be decided
>> on a case-by-case basis. The documentation suggests to use 128 for "Default restart
>> handler; use if no other restart handler is expected to be available, and/or if
>> restart functionality is sufficient to restart the entire system".
>>
>> So if this is the only means expected to be available to reset the system
>> for this architecture/platform, and if the watchdog resets the entire system
>> (not just the CPU), 128 may be ok to use. If, however, there may be other
>> means to reset the system, such as a GPIO pin, maybe not.
>
> This driver is for a SoC hardware block. The restart_handler priority level is
> hard coded in the drivers, and should thus work reasonably well for all its
> users. The fact that the common priority level is 128, is significant in this
> case IMO (as apposed to issues discussed above). Systems designers are likely
> take this priority level into account in their designs. If this does not match
> the documentation, then documentation needs to change to reflect reality.
>
Seems to me you are arguing (again) that it is ok to use priority 128 not
because of merit, but because others do it as well. As you may have noticed,
I kind of dislike that line of argument. Actually, I don't consider it to be
a valid argument in the first place.

Guenter

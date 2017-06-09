From: bo.zhang@nxp.com (Bruce Zhang)
Date: Fri, 9 Jun 2017 02:57:49 +0000
Subject: [[PATCH v2]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <711ac25b-ee32-1bd6-8a18-1e261b445920@gmail.com>
References: <1496803810-57154-1-git-send-email-bo.zhang@nxp.com>
 <20170607071256.GA3230@amd>
 <CACRpkdacymETLuRmpn07HUKHvrjWc85Jdj0s0qk44zTcaALa9w@mail.gmail.com>
 <20170607103129.GA13227@amd>
 <AM3PR04MB4045292078845DDB27718BD8AC90@AM3PR04MB404.eurprd04.prod.outlook.com>
 <711ac25b-ee32-1bd6-8a18-1e261b445920@gmail.com>
Message-ID: <AM3PR04MB404B44A56FC58C12D3DF2A68ACE0@AM3PR04MB404.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacek,

I think that no change need to make for __led_set_brightness() and __led_set_brightness_blocking() function. Because led_classdev_suspend() need to turn off LED with these API. set_brightness_delayed() is the same level API as __led_set_brightness(). No need to add LED_SUSPENDED checking as well.

Best Regards,
Bo

-----Original Message-----
From: Jacek Anaszewski [mailto:jacek.anaszewski at gmail.com] 
Sent: Friday, June 09, 2017 4:28 AM
To: Bruce Zhang <bo.zhang@nxp.com>; Pavel Machek <pavel@ucw.cz>; Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>; linux-arm-kernel at lists.infradead.org; Richard Purdie <rpurdie@rpsys.net>; linux-leds at vger.kernel.org
Subject: Re: [[PATCH v2]] drivers: leds/trigger: system cannot enter suspend

Hi Bruce,

On 06/08/2017 04:57 AM, Bruce Zhang wrote:
> Hi,
> 
> As suspend/resume procedure is as below:
> pm_notifier_call_chain(PM_SUSPEND_PREPARE)->device suspend -> syscore suspend -> enter suspend mode -> syscore resume -> device resume -> pm_notifier_call_chain(PM_POST_SUSPEND).
> If led brightness control depends on other device/hardware (such as I2C), the LED turn off action should be earlier than device suspend. pm_notifier may be a suitable method to turn off LED.

OK, so I agree that the most proper fix to the discussed problem would be ignoring brightness setting requests after suspend, as Pavel suggested.

led_classdev_suspend() already turns the LED off and
led_classdev_resume() brings the brightness back.

Also led_set_brightness_nosleep() and led_set_brightness_sync() don't propagate brightness change to the driver if LED_SUSPENDED is set.

There are two problems though:
1. __led_set_brightness() and __led_set_brightness_blocking() don't
   check the flag, and they can be called from set_brightness_delayed(),
   that was already queued at the time of setting LED_SUSPENDED flag.
2. LED_SUSPENDED flag is accessed in a non-atomic way.

The solution as I see it would be respectively:
1. Return from __led_set_brightness() and
   __led_set_brightness_blocking() if LED_SUSPENDED is set.
2. Switch to accessing struct led_classdev's flags with use of
   bitops. Fortunately those flags are mainly set prior LED class
   device registration and only LED_SYSFS_DISABLE, LED_SUSPENDED
   and LED_UNREGISTERING are accessed afterwards, and only in the LED
   core, so only those places would have to be modified.

Best regards,
Jacek Anaszewski

> -----Original Message-----
> From: Pavel Machek [mailto:pavel at ucw.cz]
> Sent: Wednesday, June 07, 2017 6:31 PM
> To: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bruce Zhang <bo.zhang@nxp.com>; Ulf Hansson 
> <ulf.hansson@linaro.org>; linux-arm-kernel at lists.infradead.org; Jacek 
> Anaszewski <jacek.anaszewski@gmail.com>; Richard Purdie 
> <rpurdie@rpsys.net>; linux-leds at vger.kernel.org
> Subject: Re: [[PATCH v2]] drivers: leds/trigger: system cannot enter 
> suspend
> 
> Hi!
> 
> On Wed 2017-06-07 11:46:10, Linus Walleij wrote:
>> On Wed, Jun 7, 2017 at 9:12 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>>> Core reason is that 5ab92a7cb is wrong. (Very wrong; it papers over 
>>> the issue for one trigger, but we have more than one... Even if 
>>> special handling for heartbeat is warranted, that handling would be 
>>> "turn the led off" not "unregister the trigger", which is 
>>> userland-visible action.)
>>
>> OK yeah I guess you're right.
>>
>> I just couldn't think about anything better and didn't get any review 
>> at the time, so mistakes were made.
>>
>>> That one should be reverted, then maybe the driver should be fixed 
>>> to turn the led off during suspend.
>>
>> Do you mean that the heartbeat trigger driver should be fixed to turn 
>> off the LED during sleep?
>>
>> That is essentially what I was trying to achieve.
> 
> I don't think we should be fixing it at trigger level.
> 
> If userspace keeps blinking using "brightness" attribute, would we like the LED to be off during suspend? I think so.
> 
>> The reason it is done as it is, is that the trigger sets up a timer 
>> to do its job, and the timer may trigger between the point you turn 
>> off the LED and the system really goes to suspend, again maybe 
>> turning the LED on and again leaving the system with a glowing LED at suspend.
> 
>> The patch also solves the following phenomenon, sorry for not writing 
>> in the commit:
>>
>> - Turn off LED
>> - Suspend I2C hardware
>> - Timer trigger
>> - Trying to blink the LED using I2C
>> - Crap in the console about the failed I2C transaction
>> - Actual suspen happens
>> - System comes online
>> - Trying to blink the LED using I2C
>> - Crap in the console about the failed I2C transaction
>> - Resume I2C hardware
>>
>> It's just very fragile this trigger, turning off the LED from the PM 
>> notifier is obviously not enough, we also need to disable the timer, 
>> and then take it back online after resume.
> 
> No, leave the timer alone, and actually leave the trigger alone.
> 
> Simply make the driver turn the LED off in .suspend() callback, and then ignore further requests until .resume(). That will get rid of power drain _and_ "failed I2C transaction" messages, right?
> 
> (Actually, I tested with the heartbeat trigger, and it is not re-installed after resume. Another reason to revert the patch).
> 
> Thanks,
> 
> 									Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) 
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 

From: bo.zhang@nxp.com (Bruce Zhang)
Date: Thu, 8 Jun 2017 02:57:16 +0000
Subject: [[PATCH v2]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <20170607103129.GA13227@amd>
References: <1496803810-57154-1-git-send-email-bo.zhang@nxp.com>
 <20170607071256.GA3230@amd>
 <CACRpkdacymETLuRmpn07HUKHvrjWc85Jdj0s0qk44zTcaALa9w@mail.gmail.com>
 <20170607103129.GA13227@amd>
Message-ID: <AM3PR04MB4045292078845DDB27718BD8AC90@AM3PR04MB404.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As suspend/resume procedure is as below:
pm_notifier_call_chain(PM_SUSPEND_PREPARE)->device suspend -> syscore suspend -> enter suspend mode -> syscore resume -> device resume -> pm_notifier_call_chain(PM_POST_SUSPEND).
If led brightness control depends on other device/hardware (such as I2C), the LED turn off action should be earlier than device suspend. pm_notifier may be a suitable method to turn off LED.

Best Regards,
Bo

-----Original Message-----
From: Pavel Machek [mailto:pavel at ucw.cz] 
Sent: Wednesday, June 07, 2017 6:31 PM
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bruce Zhang <bo.zhang@nxp.com>; Ulf Hansson <ulf.hansson@linaro.org>; linux-arm-kernel at lists.infradead.org; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Richard Purdie <rpurdie@rpsys.net>; linux-leds at vger.kernel.org
Subject: Re: [[PATCH v2]] drivers: leds/trigger: system cannot enter suspend

Hi!

On Wed 2017-06-07 11:46:10, Linus Walleij wrote:
> On Wed, Jun 7, 2017 at 9:12 AM, Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Core reason is that 5ab92a7cb is wrong. (Very wrong; it papers over 
> > the issue for one trigger, but we have more than one... Even if 
> > special handling for heartbeat is warranted, that handling would be 
> > "turn the led off" not "unregister the trigger", which is 
> > userland-visible action.)
> 
> OK yeah I guess you're right.
> 
> I just couldn't think about anything better and didn't get any review 
> at the time, so mistakes were made.
> 
> > That one should be reverted, then maybe the driver should be fixed 
> > to turn the led off during suspend.
> 
> Do you mean that the heartbeat trigger driver should be fixed to turn 
> off the LED during sleep?
> 
> That is essentially what I was trying to achieve.

I don't think we should be fixing it at trigger level.

If userspace keeps blinking using "brightness" attribute, would we like the LED to be off during suspend? I think so.

> The reason it is done as it is, is that the trigger sets up a timer to 
> do its job, and the timer may trigger between the point you turn off 
> the LED and the system really goes to suspend, again maybe turning the 
> LED on and again leaving the system with a glowing LED at suspend.

> The patch also solves the following phenomenon, sorry for not writing 
> in the commit:
> 
> - Turn off LED
> - Suspend I2C hardware
> - Timer trigger
> - Trying to blink the LED using I2C
> - Crap in the console about the failed I2C transaction
> - Actual suspen happens
> - System comes online
> - Trying to blink the LED using I2C
> - Crap in the console about the failed I2C transaction
> - Resume I2C hardware
> 
> It's just very fragile this trigger, turning off the LED from the PM 
> notifier is obviously not enough, we also need to disable the timer, 
> and then take it back online after resume.

No, leave the timer alone, and actually leave the trigger alone.

Simply make the driver turn the LED off in .suspend() callback, and then ignore further requests until .resume(). That will get rid of power drain _and_ "failed I2C transaction" messages, right?

(Actually, I tested with the heartbeat trigger, and it is not re-installed after resume. Another reason to revert the patch).

Thanks,

									Pavel
--
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

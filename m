From: bo.zhang@nxp.com (Bruce Zhang)
Date: Wed, 7 Jun 2017 04:24:27 +0000
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <20170606203813.GD32171@amd>
References: <1496716596-45414-1-git-send-email-bo.zhang@nxp.com>
 <20170606192554.GA32171@amd> <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
 <8afffd09-cb1f-d080-ef4a-ecaa089ad470@ti.com> <20170606203813.GD32171@amd>
Message-ID: <AM3PR04MB4044D34CA2E85B0CE70ED778AC80@AM3PR04MB404.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

It can also fix my issue by reverting  the commit 5ab92a7cb. But this action only does not make led_set_brightness_nosleep function to set brightness. The heartbeat trigger timer is still running even though it is not harmful.

Best Regards,
Bo

-----Original Message-----
From: Pavel Machek [mailto:pavel at ucw.cz] 
Sent: Wednesday, June 07, 2017 4:38 AM
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>; Bruce Zhang <bo.zhang@nxp.com>; Linus Walleij <linus.walleij@linaro.org>; linux-arm-kernel at lists.infradead.org
Subject: Re: [[PATCH]] drivers: leds/trigger: system cannot enter suspend

On Tue 2017-06-06 15:19:23, Grygorii Strashko wrote:
> 
> 
> On 06/06/2017 03:05 PM, Jacek Anaszewski wrote:
> > On 06/06/2017 09:25 PM, Pavel Machek wrote:
> >> On Tue 2017-06-06 10:36:36, Zhang Bo wrote:
> >>> System cannot enter suspend mode because of heartbeat led trigger.
> >>> In autosleep_wq, try_to_suspend function will try to enter suspend 
> >>> mode in specific period. it will get wakeup_count then call 
> >>> pm_notifier chain callback function and freeze processes.
> >>> Heartbeat_pm_notifier is called and it call led_trigger_unregister 
> >>> to change the trigger of led device to none. It will send uevent
> >>
> >> Why is heartbeat_pm_notifier calling led_trigger_unregister? That 
> >> sounds like a bug.
> > 
> > I suggest using git blame. The commit message adding this code is 
> > pretty informative.
> > 
> 
> In my opinion original commit do not contain ehough info about root 
> cause of the problem (commit 5ab92a7cb "leds: handle suspend/resume in 
> heartbeat trigger")

Zhang: Can you try to revert commit 5ab92a7cb in your tree, to see if it fixes your problem?

Thanks,
									Pavel

--
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

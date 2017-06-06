From: bo.zhang@nxp.com (Bruce Zhang)
Date: Tue, 6 Jun 2017 02:11:06 +0000
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <20170605200531.GA24496@amd>
References: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
 <20170605200531.GA24496@amd>
Message-ID: <AM3PR04MB404906CD6B959A13CAEA1DB8ACB0@AM3PR04MB404.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In autosleep_wq, try_to_suspend function will try to enter suspend
mode in specific period. it will get wakeup_count  as initial value then call pm_notifier
chain callback function and freeze processes.
Heartbeat_pm_notifier is called and it call led_trigger_unregister to change the trigger of led device
to none. It will send uevent message and the wakeup count changed.
When try to freeze processes, system will get wakeup_count again and 
compare it with initial value. When not equal, suspend will fail.

While "# echo mem > /sys/power/state" does not record the initial wakeup_count. 
So it can enter suspend mode suscessfully.

Best Regards,
Bo

-----Original Message-----
From: Pavel Machek [mailto:pavel at ucw.cz] 
Sent: Tuesday, June 06, 2017 4:06 AM
To: Bruce Zhang <bo.zhang@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org; jacek.anaszewski at gmail.com
Subject: Re: [[PATCH]] drivers: leds/trigger: system cannot enter suspend

On Mon 2017-06-05 15:36:31, Zhang Bo wrote:
> System cannot enter suspend mode because of heartbeat led trigger.

Can you tell us _why_ the heartbeat trigger prevents suspend/resume?

Because it does not:

# echo heartbeat > /sys/class/leds/tpacpi\:\:standby/trigger
# echo mem > /sys/power/state
(system suspends, as expected).
#

Linux amd 4.12.0-rc2+ #400 SMP Mon May 22 22:44:02 CEST 2017 i686...

If it does for you, you may want to find out why, then fix that.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

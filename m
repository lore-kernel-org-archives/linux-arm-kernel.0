From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 7 Jun 2017 09:12:57 +0200
Subject: [[PATCH v2]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <1496803810-57154-1-git-send-email-bo.zhang@nxp.com>
References: <1496803810-57154-1-git-send-email-bo.zhang@nxp.com>
Message-ID: <20170607071256.GA3230@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-06-07 10:50:10, Zhang Bo wrote:
> System cannot enter suspend mode because of heartbeat led trigger.
> In autosleep_wq, try_to_suspend function will try to enter suspend
> mode in specific period. it will get wakeup_count then call pm_notifier
> chain callback function and freeze processes.
> Heartbeat_pm_notifier is called and it call led_trigger_unregister to
> change the trigger of led device to none. It will send uevent message
> and the wakeup source count changed.
> 
> Add suspend/resume ops to the struct led_trigger, implement these two ops
> for ledtrig-heartbeat. Add led_trigger_suspend/led_trigger_resume funcitons
> to iterate through all LED class devices registered on given trigger and
> call their suspend/resume ops and disable/enable sysfs at the same time.
> 
> Call led_trigger_suspend{resuem} API in pm_notifier function to
> suspend/resume all led devices listed in given trigger.
> 
> Signed-off-by: Zhang Bo <bo.zhang@nxp.com>

NAK.

led_trigger should not need special handling over suspend.

> It can also fix my issue by reverting  the commit 5ab92a7cb. But this
> action only does not make
> led_set_brightness_nosleep function to set brightness. The heartbeat
> trigger timer is still
> running even though it is not harmful.

Yes, timers can and should be active over suspend.

Core reason is that 5ab92a7cb is wrong. (Very wrong; it papers over
the issue for one trigger, but we have more than one... Even if
special handling for heartbeat is warranted, that handling would be
"turn the led off" not "unregister the trigger", which is
userland-visible action.) That one should be reverted, then maybe the
driver should be fixed to turn the led off during suspend.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/7171a591/attachment.sig>

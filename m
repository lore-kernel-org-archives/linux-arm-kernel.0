From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 13 Jun 2017 09:31:24 +0200
Subject: [[PATCH]] Revert "leds: handle suspend/resume in heartbeat
 trigger"
In-Reply-To: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
References: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
Message-ID: <20170613073124.GA16077@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-06-13 10:39:20, Zhang Bo wrote:
> This reverts commit 5ab92a7cb82c66bf30685583a38a18538e3807db.
> 
> System cannot enter suspend mode because of heartbeat led trigger.
> In autosleep_wq, try_to_suspend function will try to enter suspend
> mode in specific period. it will get wakeup_count then call pm_notifier
> chain callback function and freeze processes.
> Heartbeat_pm_notifier is called and it call led_trigger_unregister to
> change the trigger of led device to none. It will send uevent message
> and the wakeup source count changed. As wakeup_count changed, suspend
> will abort.
> 
> Signed-off-by: Zhang Bo <bo.zhang@nxp.com>

Yes, this makes sense. Turning led off should be done at driver level.

As this fixes a regression, it would be kind of nice to get it to
v4.12...

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/75079f2d/attachment.sig>

From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 23 Aug 2017 21:34:19 +0200
Subject: [[PATCH]] Revert "leds: handle suspend/resume in heartbeat
 trigger"
In-Reply-To: <CAMuHMdUjZHpEQKmhCGnqtZjw_PK5PeQe2kEH6TTKfS8Ne2+drQ@mail.gmail.com>
References: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
 <CAMuHMdUjZHpEQKmhCGnqtZjw_PK5PeQe2kEH6TTKfS8Ne2+drQ@mail.gmail.com>
Message-ID: <20170823193419.GA7965@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Tue, Jun 13, 2017 at 4:39 AM, Zhang Bo <bo.zhang@nxp.com> wrote:
> > This reverts commit 5ab92a7cb82c66bf30685583a38a18538e3807db.
> >
> > System cannot enter suspend mode because of heartbeat led trigger.
> > In autosleep_wq, try_to_suspend function will try to enter suspend
> > mode in specific period. it will get wakeup_count then call pm_notifier
> > chain callback function and freeze processes.
> > Heartbeat_pm_notifier is called and it call led_trigger_unregister to
> > change the trigger of led device to none. It will send uevent message
> > and the wakeup source count changed. As wakeup_count changed, suspend
> > will abort.
> >
> > Signed-off-by: Zhang Bo <bo.zhang@nxp.com>
> 
> While investigating an heartbeat LED issue in v4.9.40-ltsi, I stumpled on this
> revert (commit 436c4c45b5b9562b ("Revert "leds: handle suspend/resume in
> heartbeat trigger"") in v4.12-rc6), which was not backported to v4.9 (yet).
> 
> Interestingly, while running v4.9.x on r8a7791/koelsch with an LED configured
> for heartbeat, I can actually suspend the system using s2ram.
> However, after system resume the heartbeat LED no longer flashes.
> /sys/class/leds/LED6/trigger shows the trigger is still "none", and thus
> wasn't restored to "heartbeat" by the notifier.
> There's no "could not re-register heartbeat trigger" message printed.
> 
> Backporting the revert fixes this.

You have my Acked-by: if you want to submit this to some -stable
kernels...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170823/12e18239/attachment.sig>

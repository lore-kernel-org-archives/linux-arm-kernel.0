From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 23 Aug 2017 16:02:57 +0200
Subject: [[PATCH]] Revert "leds: handle suspend/resume in heartbeat
 trigger"
In-Reply-To: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
References: <1497321560-46817-1-git-send-email-bo.zhang@nxp.com>
Message-ID: <CAMuHMdUjZHpEQKmhCGnqtZjw_PK5PeQe2kEH6TTKfS8Ne2+drQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhang,

On Tue, Jun 13, 2017 at 4:39 AM, Zhang Bo <bo.zhang@nxp.com> wrote:
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

While investigating an heartbeat LED issue in v4.9.40-ltsi, I stumpled on this
revert (commit 436c4c45b5b9562b ("Revert "leds: handle suspend/resume in
heartbeat trigger"") in v4.12-rc6), which was not backported to v4.9 (yet).

Interestingly, while running v4.9.x on r8a7791/koelsch with an LED configured
for heartbeat, I can actually suspend the system using s2ram.
However, after system resume the heartbeat LED no longer flashes.
/sys/class/leds/LED6/trigger shows the trigger is still "none", and thus
wasn't restored to "heartbeat" by the notifier.
There's no "could not re-register heartbeat trigger" message printed.

Backporting the revert fixes this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 13:25:28 +0200
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
References: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
Message-ID: <CACRpkdZpMsqt9gjehSQ5c86LyqhZcnYF7QuGk=N4JTi-GJ1SMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 9:36 AM, Zhang Bo <bo.zhang@nxp.com> wrote:

> System cannot enter suspend mode because of heartbeat led trigger.

As mentioned this should not be a problem.

> Heartbeat_pm_notifier is called when system prepare to enter suspend
> mode, then call led_trigger_unregister to change the trigger of led device
> to none. It will send uevent message and the wakeup source count changed.
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

The patch is nice because it fixes my sloppy approach of just adding/removing
the trigger made earlier.

It stops unsolicited I2C traffic and other nastines from happening during the
suspend/resume cycle.

I would even add:

Fixes: 5ab92a7cb82c ("leds: handle suspend/resume in heartbeat trigger")

(...)
> +static void heartbeat_trig_resume(struct led_classdev *led_cdev)
> +{
> +       struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
> +
> +       if (led_cdev->suspended) {
> +               setup_timer(&heartbeat_data->timer,
> +                           led_heartbeat_function, (unsigned long) led_cdev);
> +               heartbeat_data->phase = 0;
> +               led_heartbeat_function(heartbeat_data->timer.data);
> +               led_cdev->suspended = false;
> +       }
> +}
> +
> +static void heartbeat_trig_suspend(struct led_classdev *led_cdev)
> +{
> +       struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
> +
> +       if (led_cdev->activated && !led_cdev->suspended) {
> +               del_timer_sync(&heartbeat_data->timer);
> +               led_cdev->suspended = true;
>         }

Are we sure that the LED is *off* at this point so you don't suspend/resume
with a glowing LED?

Else insert a call to make sure that it's like so, and maybe even
a variable to hold the current state (off/on) across the suspend/resume
cycle.

> @@ -161,25 +186,23 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
>         .name     = "heartbeat",
>         .activate = heartbeat_trig_activate,
>         .deactivate = heartbeat_trig_deactivate,
> +       .suspend = heartbeat_trig_suspend,
> +       .resume = heartbeat_trig_resume,
(...)
> +       void            (*suspend)(struct led_classdev *led_cdev);
> +       void            (*resume)(struct led_classdev *led_cdev);


These names do not correspons to the actual PM calls
they are utilized for.

Name them
.pm_prepare_suspend()
.pm_post_suspend()

Instead, this indicates better the place when they get called.

Yours,
Linus Walleij

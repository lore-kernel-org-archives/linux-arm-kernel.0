From: bo.zhang@nxp.com (Bruce Zhang)
Date: Fri, 9 Jun 2017 13:01:31 +0000
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <CACRpkdZpMsqt9gjehSQ5c86LyqhZcnYF7QuGk=N4JTi-GJ1SMA@mail.gmail.com>
References: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
 <CACRpkdZpMsqt9gjehSQ5c86LyqhZcnYF7QuGk=N4JTi-GJ1SMA@mail.gmail.com>
Message-ID: <AM3PR04MB4041CD5659C02FF30AF159A8ACE0@AM3PR04MB404.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At first we should check that whether exist the use case that LED turn on/off is based on other device(such as I2C). If true, how to guarantee the other devices(such as I2C) are available when turn off LED. Maybe pm_notifier is accepted method to process this case, because pm_notifier callback function is executed before other devices enter suspend mode.

If we don't need to care such case or not exist such use case in application, we can revert the patch 5ab92a7cb.

Best Regards,
Bruce

-----Original Message-----
From: Linus Walleij [mailto:linus.walleij at linaro.org] 
Sent: Friday, June 09, 2017 7:25 PM
To: Bruce Zhang <bo.zhang@nxp.com>
Cc: linux-arm-kernel at lists.infradead.org; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>
Subject: Re: [[PATCH]] drivers: leds/trigger: system cannot enter suspend

On Mon, Jun 5, 2017 at 9:36 AM, Zhang Bo <bo.zhang@nxp.com> wrote:

> System cannot enter suspend mode because of heartbeat led trigger.

As mentioned this should not be a problem.

> Heartbeat_pm_notifier is called when system prepare to enter suspend 
> mode, then call led_trigger_unregister to change the trigger of led 
> device to none. It will send uevent message and the wakeup source count changed.
>
> Add suspend/resume ops to the struct led_trigger, implement these two 
> ops for ledtrig-heartbeat. Add led_trigger_suspend/led_trigger_resume 
> funcitons to iterate through all LED class devices registered on given 
> trigger and call their suspend/resume ops and disable/enable sysfs at the same time.
>
> Call led_trigger_suspend{resuem} API in pm_notifier function to 
> suspend/resume all led devices listed in given trigger.
>
> Signed-off-by: Zhang Bo <bo.zhang@nxp.com>

The patch is nice because it fixes my sloppy approach of just adding/removing the trigger made earlier.

It stops unsolicited I2C traffic and other nastines from happening during the suspend/resume cycle.

I would even add:

Fixes: 5ab92a7cb82c ("leds: handle suspend/resume in heartbeat trigger")

(...)
> +static void heartbeat_trig_resume(struct led_classdev *led_cdev) {
> +       struct heartbeat_trig_data *heartbeat_data = 
> +led_cdev->trigger_data;
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
> +static void heartbeat_trig_suspend(struct led_classdev *led_cdev) {
> +       struct heartbeat_trig_data *heartbeat_data = 
> +led_cdev->trigger_data;
> +
> +       if (led_cdev->activated && !led_cdev->suspended) {
> +               del_timer_sync(&heartbeat_data->timer);
> +               led_cdev->suspended = true;
>         }

Are we sure that the LED is *off* at this point so you don't suspend/resume with a glowing LED?

Else insert a call to make sure that it's like so, and maybe even a variable to hold the current state (off/on) across the suspend/resume cycle.

> @@ -161,25 +186,23 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
>         .name     = "heartbeat",
>         .activate = heartbeat_trig_activate,
>         .deactivate = heartbeat_trig_deactivate,
> +       .suspend = heartbeat_trig_suspend,
> +       .resume = heartbeat_trig_resume,
(...)
> +       void            (*suspend)(struct led_classdev *led_cdev);
> +       void            (*resume)(struct led_classdev *led_cdev);


These names do not correspons to the actual PM calls they are utilized for.

Name them
.pm_prepare_suspend()
.pm_post_suspend()

Instead, this indicates better the place when they get called.

Yours,
Linus Walleij

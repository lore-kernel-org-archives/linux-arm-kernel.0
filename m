From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Jul 2018 16:19:56 -0700
Subject: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
Message-ID: <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> +                                            int temp)
> +{
> +       u8 reg;
> +       bool disable_s2_shutdown = false;
> +       int ret;
> +
> +       WARN_ON(!mutex_is_locked(&chip->lock));
> +
> +       /*
> +        * Default: S2 and S3 shutdown enabled, thresholds at
> +        * 105C/125C/145C, monitoring at 25Hz
> +        */
> +       reg = SHUTDOWN_CTRL1_RATE_25HZ;
> +
> +       if ((temp == THERMAL_TEMP_INVALID) ||
> +           (temp < STAGE2_THRESHOLD_MIN)) {
> +               chip->thresh = THRESH_MIN;
> +               goto skip;
> +       }
> +
> +       if (temp <= STAGE2_THRESHOLD_MAX) {
> +               chip->thresh = THRESH_MAX -
> +                       ((STAGE2_THRESHOLD_MAX - temp) /
> +                        TEMP_THRESH_STEP);
> +               disable_s2_shutdown = true;
> +       } else {
> +               chip->thresh = THRESH_MAX;
> +
> +               if (!IS_ERR(chip->adc))
> +                       disable_s2_shutdown = true;
> +               else
> +                       dev_warn(chip->dev,
> +                                "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140?C! Configuring stage 2 shutdown at 140?C.\n");

Putting a non-ASCII character (the degree symbol) in your commit
message is one thing, but are you sure it's wise to put it in the
kernel logs?


> +       }
> +
> +skip:
> +       reg |= chip->thresh;
> +       if (disable_s2_shutdown)
> +               reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
> +
> +       ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return ret;

Simplify the above lines to:

return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);


> @@ -313,12 +441,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> -       chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> -                                                       &qpnp_tm_sensor_ops);
> -       if (IS_ERR(chip->tz_dev)) {
> -               dev_err(&pdev->dev, "failed to register sensor\n");
> -               return PTR_ERR(chip->tz_dev);
> -       }
> +       chip->initialized = true;

Should we add "thermal_zone_device_update(chip->tz_dev,
THERMAL_EVENT_UNSPECIFIED);" here

...also: do we care about any type of locking for chip->initialized?
Technically we can be running on weakly ordered memory so if
qpnp_tm_update_temp_no_adc() is running on a different processor then
possibly it could still keep returning the default temperature for a
little while.  We could try to analyze whether there's some sort of
implicit barrier or we could add manual memory barriers, but generally
I try to avoid that and just do the simple locking...  What about just
setting chip-Initialized = true at the end of qpnp_tm_init() while the
mutex is still held?


I'd also love to hear from someone with more thermal framework
experience to make sure it's legit to return a default value if
someone calls us while we're initting.  It seems sane to me but nice
to confirm it's OK.


Overall I like the idea of this patch so hopefully others do too.
Thanks for sending it out!


-Doug

From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 3 Aug 2011 12:23:12 +0200
Subject: [PATCH 01/17] leds: create a trigger for CPU activity
In-Reply-To: <1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-2-git-send-email-bryan.wu@canonical.com>
Message-ID: <CAHXqBF+8i7P9WhR0pjUPaew0bkzwE26Pr1u2V09PSZwhkdmCUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/3 Bryan Wu <bryan.wu@canonical.com>:
> Attempting to consolidate the ARM LED code, this removes the
> custom RealView LED trigger code to turn LEDs on and off in
> response to CPU activity and replace it with a standard trigger.
[...]
> +void ledtrig_cpu(enum cpu_led_event ledevt)
> +{
> +       struct ledtrig_cpu_data *trigdata = __get_cpu_var(ledtrig_cpu_triggers);
> +
> +       if (!trigdata)
> +               return;
> +
> +       /* Locate the correct CPU LED */
> +
> +       switch (ledevt) {
> +       case CPU_LED_IDLE_START:
> +       case CPU_LED_START:
> +               /* Will turn the LED on, max brightness */
> +               if (trigdata->led)
> +                       led_set_brightness(trigdata->led,
> +                                          trigdata->led->max_brightness);
> +               break;
> +
> +       case CPU_LED_IDLE_END:
> +       case CPU_LED_STOP:
> +       case CPU_LED_HALTED:
> +               /* Will turn the LED off */
> +               if (trigdata->led)
> +                       led_set_brightness(trigdata->led, LED_OFF);
> +               break;

Might be better to swap CPU_LED_IDLE_START with CPU_LED_IDLE_END here
so that when entering idle state the leds turn off.

Best Regards,
Micha? Miros?aw

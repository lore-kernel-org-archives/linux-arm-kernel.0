From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 17 Dec 2014 09:32:11 -0800
Subject: [PATCH resend v2] input: Add new sun4i-lradc-keys driver
In-Reply-To: <1418827411-13265-2-git-send-email-hdegoede@redhat.com>
References: <1418827411-13265-1-git-send-email-hdegoede@redhat.com>
 <1418827411-13265-2-git-send-email-hdegoede@redhat.com>
Message-ID: <1918972.jFlKNuYrbH@dtor-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 17, 2014 03:43:31 PM Hans de Goede wrote:
> +       /*
> +        * lradc supports only one keypress at a time, release does not give
> +        * any info as to which key was released, so we cache the keycode.
> +        */
> +       if ((ints & CHAN0_KEYDOWN_IRQ) && lradc->chan0_keycode == 0) {
> +               val = readl(lradc->base + LRADC_DATA0) & 0x3f;
> +               voltage = val * lradc->vref / 63;
> +
> +               for (i = 0; i < lradc->chan0_map_count; i++) {
> +                       diff = abs(lradc->chan0_map[i].voltage - voltage);
> +                       if (diff < closest) {
> +                               closest = diff;
> +                               keycode = lradc->chan0_map[i].keycode;
> +                       }
> +               }
> +
> +               lradc->chan0_keycode = keycode;
> +               input_report_key(lradc->input, lradc->chan0_keycode, 1);
> +       }
> +
> +       if (ints & CHAN0_KEYUP_IRQ) {
> +               input_report_key(lradc->input, lradc->chan0_keycode, 0);
> +               lradc->chan0_keycode = 0;
> +       }

Can release and press be reported simultaneously? Should we process release 
first?

Thanks.

-- 
Dmitry

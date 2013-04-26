From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 12:18:59 +0200
Subject: [PATCH] ARM: Adds pin config API to set all configs in one
 function
In-Reply-To: <1366841010-2823-1-git-send-email-syin@broadcom.com>
References: <1366841010-2823-1-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdbT7f8ujCHZxKg26iMKcrAb+_yHW_2YsZwkoo892rkgTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 12:03 AM, Sherman Yin <syin@broadcom.com> wrote:

> Currently, when setting pin configuration in the pinctrl framework,
> pin_config_set() or pin_config_group_set() is called in a loop to set one
> configuration at a time for the specified pin or group.
>
> pin_config_set_all() and pin_config_group_set_all() are defined to set all
> configurations for the specified pin or group at the same time.  These optional
> APIs allow pinctrl drivers to optimize and combine pin configurations to reduce
> the number of register writes required to configure a pin.
>
> If both pin_config_set() and pin_config_set_all() are defined by a driver, the
> latter takes precedence.  Similarly for pin_config_group_set_all().
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>

NAK, sorry.

We discussed this already at the creation of the pinctrl framework.

What you should do is to add an optional pin_config_set_complete()
and pin_config_group_set_complete()
callback that is called after the framework has iterated over all
configs.

This way the responsibility to resolve the sequence of config
calls and validate the validity of that sequence is pushed down
to the driver, it may do this incrementally or at pin_config_set_complete()
and then write the resulting config to the hardware as an
effect of pin_config_set_complete().

The driver takes care of caching intermediate settings for the pin
until the complete() callback is called.

Can you devise a patch like this instead?

I am also very hesitant to merge this if there is no code using
it, i.e. if you don't have a corresponding driver to submit
at the same time, it will not be merged, as I don't like to
maintain dead code.

Yours,
Linus Walleij

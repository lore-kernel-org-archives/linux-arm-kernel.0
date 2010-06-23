From: ext-jani.1.nikula@nokia.com (Jani Nikula)
Date: Wed, 23 Jun 2010 16:22:31 +0300 (EEST)
Subject: gpiolib and sleeping gpios
In-Reply-To: <564390.64703.qm@web180307.mail.gq1.yahoo.com>
References: <564390.64703.qm@web180307.mail.gq1.yahoo.com>
Message-ID: <alpine.DEB.2.00.1006231601310.7850@wnav-qrfxgbc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 23 Jun 2010, ext David Brownell wrote:

> --- On Wed, 6/23/10, Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:
>
>> Hi David -
>> 
>> Part of the reason why such drivers haven't been fixed
>> might be that the runtime warnings are only issued if DEBUG
>> is defined in gpiolib.c:
>
> A very good point.  those cansleep() warnings
> should perhaps be issued more consistently.
>
> (Other warnings are safer to skip.)
>
> I think the normal case for the GPIO calls is
> the spinlock-safe code path, so I'd probably
> ack a patch which incurs the extra costs only
> for gpio chips that are already sleeping.

Hi -

I'd think the most important and useful warning would be about 
gpio_{get,set}_value() in atomic context on a gpio chip that might sleep. 
I seem to have some trouble with my foreign language parser here, so let's 
move to a more natural language - see patch below. ;)

If you'd be willing to accept that, with the overhead of one conditional 
statement in atomic context for non-sleepy chips, I see no reason not to 
go all the way and modify whole gpiolib.c to match extra_check == 1.


BR,
Jani.


diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3ca3654..33d82b7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1527,7 +1527,7 @@ int __gpio_get_value(unsigned gpio)
  	struct gpio_chip	*chip;

  	chip = gpio_to_chip(gpio);
-	WARN_ON(extra_checks && chip->can_sleep);
+	might_sleep_if(chip->can_sleep);
  	return chip->get ? chip->get(chip, gpio - chip->base) : 0;
  }
  EXPORT_SYMBOL_GPL(__gpio_get_value);
@@ -1546,7 +1546,7 @@ void __gpio_set_value(unsigned gpio, int value)
  	struct gpio_chip	*chip;

  	chip = gpio_to_chip(gpio);
-	WARN_ON(extra_checks && chip->can_sleep);
+	might_sleep_if(chip->can_sleep);
  	chip->set(chip, gpio - chip->base, value);
  }
  EXPORT_SYMBOL_GPL(__gpio_set_value);

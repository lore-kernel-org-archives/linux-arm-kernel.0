From: ext-jani.1.nikula@nokia.com (Jani Nikula)
Date: Wed, 23 Jun 2010 14:53:52 +0300 (EEST)
Subject: gpiolib and sleeping gpios
In-Reply-To: <386783.17931.qm@web180310.mail.gq1.yahoo.com>
References: <386783.17931.qm@web180310.mail.gq1.yahoo.com>
Message-ID: <alpine.DEB.2.00.1006231435410.8344@wnav-qrfxgbc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sat, 19 Jun 2010, ext David Brownell wrote:

>> The point I was trying to make is that there are lots of drivers which 
>> will not work with gpios on sleeping io expanders because they call the 
>> spinlock safe gpio calls.
>
> And they will trigger runtime warnings, and thus eventually get fixed. 
> The way to do that is to check if the GPIO needs the cansleep() call
>
> That's the first category above:  the driver should have used the 
> cansleep() variant, and sotriggers a runtime warning.

Hi David -

Part of the reason why such drivers haven't been fixed might be that the 
runtime warnings are only issued if DEBUG is defined in gpiolib.c:

/* When debugging, extend minimal trust to callers and platform code.
  * Also emit diagnostic messages that may help initial bringup, when
  * board setup or driver bugs are most common.
  *
  * Otherwise, minimize overhead in what may be bitbanging codepaths.
  */
#ifdef	DEBUG
#define	extra_checks	1
#else
#define	extra_checks	0
#endif

...

int __gpio_get_value(unsigned gpio)
{
 	struct gpio_chip	*chip;

 	chip = gpio_to_chip(gpio);
 	WARN_ON(extra_checks && chip->can_sleep);
 	return chip->get ? chip->get(chip, gpio - chip->base) : 0;
}

Do you think it would do more harm than good to unconditionally enable the 
extra checks? I do see the comment about overhead there, but having them 
enabled would probably aid driver developers in fixing existing code and 
choosing the correct calls in the future.


BR,
Jani.

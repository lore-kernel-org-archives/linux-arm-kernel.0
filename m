From: johan@kernel.org (Johan Hovold)
Date: Wed, 23 Sep 2015 15:02:37 -0700
Subject: [PATCH v3 3/9] gpiolib: Use GPIO name from names array for gpio
 descriptor
In-Reply-To: <1439561466-14350-4-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20150923220237.GC19608@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 04:11:00PM +0200, Markus Pargmann wrote:
> This patch adds GPIO names to the GPIO descriptors when initializing the
> gpiochip. It also introduces a check whether any of the new names will
> conflict with an existing GPIO name.

And this is why we should not do this. I've said it it before: we need
to consider dynamic buses, not just static device trees.

We have USB and Greybus that will soon be exposing gpiochips and their
line-names can not be globally unique.

Before figuring out what a sane userspace interface should look like we
should not make ABI changes that we need to support indefinitely. The
legacy sysfs interface should instead be frozen.

Exposing a name attribute for a not-necessarily globally unique name
could perhaps be ok, but by enforcing uniqueness at this point we will
then need to come up with another mechanism for naming gpios on dynamic
buses (while maintaining this one indefinitely in parallel).

Linus, please consider dropping these changes for now.

Thanks,
Johan

From: broonie@kernel.org (Mark Brown)
Date: Sat, 24 May 2014 12:54:57 +0100
Subject: [PATCH] spi: Set cs-gpios to output direction
In-Reply-To: <1400893054-16126-1-git-send-email-sboyd@codeaurora.org>
References: <1400893054-16126-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140524115457.GP22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:57:34PM -0700, Stephen Boyd wrote:
> Some gpios used for cs-gpios may not be configured for output by
> default. In these cases gpio_set_value() won't have any effect
> and so the chip select line won't toggle. Request the cs-gpios
> and set them to output direction once we know if the chip select
> is default high or default low.

Currently the SPI framework is expecting that the controller driver will
own the GPIOs so it's not requesting them at all - starting to request
them in the core without warning is likely to lead to double requests
which doesn't seem like the best idea ever.  The driver has to
understand that there are GPIO chip selects since it needs to figure out
what to do with any underlying hardware chip selects that it can't stop
toggling (there may be none or it may be directable into space with
pinmux but we can't rely on that).  

Note also that you've done this in a DT specific bit of code and this
needs to work with non-DT systems too.

> I wonder if we should request the gpios when the master controller
> probes or when a spi device is added? We only know what the default
> value should be when the spi device is added. On the other hand,
> we should probably fail probe if the gpio controller isn't ready when
> the spi master controller probes.

Right, plus the fact that each driver has to open code the requesting,
probe deferral handling and so on.  It's not super awesome, the whole
area around GPIO chip select handling needs a bit of a sorched earth
refactoring.

Ideally we'd be able to error out only the device using an individual
GPIO rather than the whole controller if a GPIO isn't there for some
reason so doing it at device time would be nicer but my recollection is
that this won't play nicely with deferred probe, it's a while since I
looked so I may be misremembering.

> Also, is it better to convert this over to the gpiod interfaces?

Yes, that too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140524/8825c04a/attachment.sig>

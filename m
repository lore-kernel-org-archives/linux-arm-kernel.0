From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Jul 2014 18:09:05 +0100
Subject: [PATCH 1/3] spi: s3c64xx: move "cs-gpio" from subnode to SPI DT
 node
In-Reply-To: <53C56520.8030801@samsung.com>
References: <1405426860-18404-1-git-send-email-ch.naveen@samsung.com>
 <1405426860-18404-2-git-send-email-ch.naveen@samsung.com>
 <53C56520.8030801@samsung.com>
Message-ID: <20140716170905.GT17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 07:30:08PM +0200, Tomasz Figa wrote:
> On 15.07.2014 14:20, Naveen Krishna Chatradhi wrote:

> >  	/* The CS line is asserted/deasserted by the gpio pin */
> > -	if (sdd->cs_gpio)
> > -		cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
> > +	cs->line = spi->cs_gpio;
> >  
> >  	if (!gpio_is_valid(cs->line)) {

> This check is wrong when native chip select is used. However I'm not
> sure how to distinguish this from a situation when invalid GPIO was
> specified, because cs->line will be -ENOENT in both cases. Mark, any ideas?

Hrm.  I'd *hope* that of_get_named_gpio() would distinguish between the
property being there but unparsable and the property being absent.  Does
it not do this?

> > -		if (!of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
> > +		if (!of_find_property(pdev->dev.of_node, "cs-gpios", NULL))
> >  			sdd->cs_gpio = false;

> What is this boolean flag used for now? If cs->line now either contains
> a valid GPIO or a negative error, why gpio_is_valid() couldn't be used
> on it? I believe it was done correctly in previous version.

We ought to handle the errors differently depending on where they came
from - an unspecified GPIO means use the physical chip select but a GPIO
we fail to obtain is an error we should handle.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/b89bae1f/attachment.sig>

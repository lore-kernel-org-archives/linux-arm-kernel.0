From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 19 Apr 2011 09:38:55 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
Message-ID: <20110419093855.36910400@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It also doesn't solve the real problem which is that you've got to
> > implement platform specific parallel gpio extensions all over the place
> > when you really want it all using the same 'handle' and request logic.
> 
> Fair enough.  Forgive me if you've stated this in a previous conversation
> then but what do you see as being the best way forward here?  Should
> gpiolib enforce itself as the One True Allocator and require all firmware
> drivers call back in to it to get access to the pins rather than gpiolib
> calling back to the platform upon gpio_request()?

We need something to allocate gpios and manage them. gpiolib seems to be
very good at this. We also need gpiolib to route other requests because
gpiolib is the one thing which knows how to turn "gpio 43" a struct and
function calls.

> > And for a lot of this stuff that the gpio layer really doesn't want
> > internal knowledge of other chunks of the kernel have used models like
> > 'get_property/set_property' (eg battery, video4linux etc) so that the mid
> > layer can plumb in a conversation between the handle owner and the driver
> > without getting involved in the conversation.
> 
> Yeah that sounds like a more reasonable way to expose this functionality if
> the driver does indeed need it.

Leaving aside the current input/output and on/off bits I would go for
being able to do

	gpio_get_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER);
	gpio_set_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER_ELSE);

and having gpiolib perform nothing more on these than

	is the gpio allocated 
	does ->get_property() exist
		no -EOPNOTSUPP
		yes return ->get_proprty(gpio struct, op, val)
	
For dynamically configurable features that avoids the 

	gpio_request(35);
	magic_platform_hack(&foo[3], blah); /* foo3 will be gpio35 */

type stuff that becomes unmaintainable.

It would be entirely optional for a driver to support any of this stuff,
but it would both allow drivers to do so and also mean that where there
are multiple devices with a common feature *and* a driver wants to use it
that it will be properly abstracted in the driver itself.


Alan



> 
> 	--Ben.
> 
> > 
> > Alan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds

From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Jul 2014 12:10:41 +0100
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <CAAVeFuK8YPFh3gHRt7_n00SBN6raGj2KxU_rY3GFrQq4dT3LTA@mail.gmail.com>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
 <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
 <20140630163931.GD32514@n2100.arm.linux.org.uk>
 <CACRpkda5BjAwphVEkCg6-oUR0yN=RMhjP6FL=Oripy7bQ-aSng@mail.gmail.com>
 <CAAVeFuK8YPFh3gHRt7_n00SBN6raGj2KxU_rY3GFrQq4dT3LTA@mail.gmail.com>
Message-ID: <20140701111041.GL23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:59:01AM +0900, Alexandre Courbot wrote:

> We could compare on the (dev, func, index) triplet instead of the GPIO
> number, but that looks a little bit overkill (and won't work if we mix
> integers and descriptors).

This only works if requests always come from the same triplet - if we're
requesting in the client context that doesn't work.

> How about we add a SHAREABLE flag to the descriptors that indicates
> whether a GPIO can be shared. I can then see one of the following two
> policies being applied:

> 2) GPIOs are shareable by default, and remain that way as long as they
> are obtained using the gpiod interface exclusively. A call to
> gpio_to_desc() or gpio_request_one() would mark the GPIO as
> non-shareable until it is released by the integer interface (and would
> fail if the GPIO is already requested by gpiod). Any integer interface
> call on a gpiod-requested GPIO would now simply fail with -EPERM.

This seems sensible to me.

> I am not sure whether 2) covers all the requirements to allow gpiod to
> be "secure", but if it does, then I suggest we give it a shot
> (although at least a few drivers will certainly need fixing, but such
> is life). This would add a very welcome layer of security and
> guarantee gpiod users that nobody can spoof or mess otherwise with
> their GPIOs unless the board or firmware designer allows it.

I don't see security as a big deal - so long as normal, well written
code gets the benefit of the access protection I think we're doing
enough.  If something jumpst through hoops to bypass it then it's buggy
but fundamentally we have to trust the kernel to at least some extent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/f0588b31/attachment.sig>

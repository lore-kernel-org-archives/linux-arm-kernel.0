From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 11:36:53 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to set_type
In-Reply-To: <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
 <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com>
Message-ID: <20140528093653.GN4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 04:18:29PM +0200, Linus Walleij wrote:
> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > With level triggered interrupt mask / unmask will get called for each
> > interrupt, doing the somewhat expensive mux setting on each unmask thus is
> > not a good idea. Instead move it to the set_type callback, which is typically
> > done only once for each irq.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Yes move it out of mask/unmask but no, not into set_type().
> 
> Can you not use the irqchip startup()/shutdown() callbacks
> instead?

I think we can use irq_request_resources then
https://lkml.org/lkml/2014/3/12/307

We could even merge the gpio_to_irq code into it.

It's called in __setup_irq, so it's guaranteed to be called, and it
will bail out early without doing anything, since it's one of the
first thing __setup_irq does.

> And how come we have no clean separation between gpiochip
> and the pinmux parts here, why cant we just call
> pinctrl_request_gpio() and pinctrl_free_gpio() here instead?
> Or maybe pinctrl_gpio_direction_input() and have that set
> up the muxing in the pinctrl driver side?

Because the function it has to be muxed to is neither gpio_in or
gpio_out, and it's not even considered a gpio. It really is just
another muxing function, like i2c or mmc.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/e08db759/attachment.sig>

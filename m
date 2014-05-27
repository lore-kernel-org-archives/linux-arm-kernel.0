From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 16:18:29 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to set_type
In-Reply-To: <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:

> With level triggered interrupt mask / unmask will get called for each
> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> not a good idea. Instead move it to the set_type callback, which is typically
> done only once for each irq.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Yes move it out of mask/unmask but no, not into set_type().

Can you not use the irqchip startup()/shutdown() callbacks
instead?

And how come we have no clean separation between gpiochip
and the pinmux parts here, why cant we just call
pinctrl_request_gpio() and pinctrl_free_gpio() here instead?
Or maybe pinctrl_gpio_direction_input() and have that set
up the muxing in the pinctrl driver side?

It looks slightly convoluted.

Yours,
Linus Walleij

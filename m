From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Jan 2018 11:30:00 +0100
Subject: [RFC PATCH 2/2] gpio: provide a consumer when requesting a gpio
In-Reply-To: <20180115162407.6314-3-ludovic.desroches@microchip.com>
References: <20180115162407.6314-1-ludovic.desroches@microchip.com>
 <20180115162407.6314-3-ludovic.desroches@microchip.com>
Message-ID: <CACRpkdbsYyHRz826K0QA=Y7Dvf_sm714o5601KBD7Zo4+1hrQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 5:24 PM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> It can be useful for the pinmuxing layer to know which device is
> requesting a GPIO. Add a consumer variant for gpiod_request to
> reach this goal.
>
> GPIO chips managed by pin controllers should provide the new
> request_consumer operation. They can rely on
> gpiochip_generic_request_consumer instead of
> gpiochip_generic_request.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

I think we need to think over what is a good way to share ownership
of a pin.

Russell pointed me to a similar problem incidentally and I briefly looked
into it: there are cases when several devices may need to hold the
same pin.

Can't we just look up the associated gpio_chip from the GPIO range,
and in case the pin is connected between the pin controller and
the GPIO chip, then we allow the gpiochip to also take a
reference?

I.e. in that case you just allow gpio_owner to proceed and take the
pin just like with a non-strict controller.

Yours,
Linus Walleij

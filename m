From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Mar 2016 15:30:06 +0100
Subject: [PATCH 11/17] dt-bindings: Add PLX Technology OXNAS pinctrl and
 gpio bindings
In-Reply-To: <1457005210-18485-12-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-12-git-send-email-narmstrong@baylibre.com>
Message-ID: <CACRpkdYZ5Lm5FkuLmL2ZWTF1jc027d_Jm9AzK3xGS89dostzqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 12:40 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

This is a vert terse zero-line commit message. Atleast describe what you are
trying to do.

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

> +optional properties:
> +- #gpio-lines: Number of gpio if absent 32.

NACK, use ngpio from the gpio.txt document like
everyone else.

> +Required properties for iomux controller:
> +- compatible: "plxtech,nas782x-pinctrl" or "plxtech,ox810se-pinctrl"
> +- plxtech,mux-mask: array of mask (periph per bank) to describe if a pin can be
> +  configured in this periph mode. All the periph and bank need to be describe.

Why? Encode this into the driver and select muxmask from
the compatible string if it is a hardware limitation.

> +Each column will represent the possible peripheral of the pinctrl
> +Each line will represent a pio bank
> +
> +For example :
> +Peripheral: 2 ( A and B)
> +Bank: 2 (A, B and C)
> +=>
> +
> +  /*    A         B     */
> +  0xffffffff 0xffc00c3b  /* pioA */
> +  0xffffffff 0x7fff3ccf  /* pioB */
> +
> +For each peripheral/bank we will descibe in a u32 if a pin can be
> +configured in it by putting 1 to the pin bit (1 << pin)

That's just completely hopeless to understand for a DT author.
Put it into the driver.

> +Required properties for pin configuration node:
> +- plxtech,pins: 4 integers array, represents a group of pins mux and config
> +  setting. The format is plxtech,pins = <PIN_BANK PIN_BANK_NUM PERIPH CONFIG>.
> +  The PERIPH 0 means gpio, PERIPH 1 is periph A, PERIPH 2 is periph B...
> +  PIN_BANK 0 is pioA, PIN_BANK 1 is pioB...

NACK, use the standard binding for "pins" from pinctrl-bindings.txt

Also make the driver use the existing helpers for this property.

Yours,
Linus Walleij

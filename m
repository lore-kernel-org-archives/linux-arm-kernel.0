From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Mar 2015 11:39:46 +0100
Subject: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
In-Reply-To: <1425427237-11511-2-git-send-email-nm@ti.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com>
 <1425427237-11511-2-git-send-email-nm@ti.com>
Message-ID: <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 4, 2015 at 1:00 AM, Nishanth Menon <nm@ti.com> wrote:

> +Configuration definition follows similar model as the pinctrl-single:
> +The groups of pin configuration are defined under "pinctrl-single,pins"
> +
> +&dra7_iodelay_core {
> +       mmc2_iodelay_3v3_conf: mmc2_iodelay_3v3_conf {
> +               pinctrl-single,pins = <
> +                       0x18c (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A19_IN */
> +                       0x1a4 (A_DELAY(265) | G_DELAY(360))     /* CFG_GPMC_A20_IN */
> +                       0x1b0 (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A21_IN */
> +                       0x1bc (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A22_IN */
> +                       0x1c8 (A_DELAY(287) | G_DELAY(420))     /* CFG_GPMC_A23_IN */
> +                       0x1d4 (A_DELAY(144) | G_DELAY(240))     /* CFG_GPMC_A24_IN */
> +                       0x1e0 (A_DELAY(0) | G_DELAY(0))         /* CFG_GPMC_A25_IN */
> +                       0x1ec (A_DELAY(120) | G_DELAY(0))       /* CFG_GPMC_A26_IN */
> +                       0x1f8 (A_DELAY(120) | G_DELAY(180))     /* CFG_GPMC_A27_IN */
> +                       0x360 (A_DELAY(0) | G_DELAY(0))         /* CFG_GPMC_CS1_IN */
> +               >;
> +       };
> +};

But wait.

The promise when we merged pinctrl-single was that this driver was to be used
when the system had a one-register-per-pin layout and it was easy to do device
trees based on that.

We were very reluctant to accept that even though we didn't even have the
generic pin control bindings in place, the argument being that the driver
should know the detailed register layout, it should not be described in the
device tree. We eventually caved in and accepted it as an exception.

Since this pin controller is not using pinctrl-single it does not enjoy that
privilege and you need to explain why this pin controller cannot use the
generic bindings like so many other pin controllers have since started
to do. ("It is in the same SoC" is not an acceptable argument.)

What is wrong with this:
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

We can add generic delay bindings to the list, it even seems like
a good idea to do so, as it is likely something that will come up in
other hardware and will be needed for ACPI etc going forward.

Yours,
Linus Walleij

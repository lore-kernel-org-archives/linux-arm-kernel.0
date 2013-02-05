From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 18:00:56 +0100
Subject: [PATCH 1/9] gpiolib: link all gpio_chips using a list
In-Reply-To: <1359822572-26009-3-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-3-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdZDtJ3AN+Pgxy9nNgVx_YYTC=7AuDC48w7kDbDAeqdufw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Add a list member to gpio_chip that allows all chips to be parsed
> quickly. The current method requires parsing the entire GPIO integer
> space, which is painfully slow. Using a list makes many chip operations
> that involve lookup or parsing faster, and also simplifies the code. It
> is also necessary to eventually get rid of the global gpio_desc[] array.
>
> The list of gpio_chips is always ordered by base GPIO number to ensure
> chips traversal is done in the right order.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

OK!

> + * Return -EBUSY if the new chip overlaps with some other chip's integer
> + * space.
(...)
> +       /* are we stepping on the chip right before? */
> +       if (pos != &gpio_chips && pos->prev != &gpio_chips) {
> +               _chip = list_entry(pos->prev, struct gpio_chip, list);
> +               if (_chip->base + _chip->ngpio > chip->base) {
> +                       dev_err(chip->dev,
> +                              "GPIO integer space overlap, cannot add chip\n");
> +                       err = -EBUSY;
> +               }
> +       }

This robustness change on its own is a merit for merging the patch.
And keeping a list of gpiochips available is great for stuff like
debugfs.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

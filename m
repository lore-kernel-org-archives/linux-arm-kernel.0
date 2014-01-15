From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jan 2014 15:27:24 +0100
Subject: [PATCH v1 3/5] pinctrl: st: Add software edge trigger interrupt
 support.
In-Reply-To: <1389711141-21090-1-git-send-email-srinivas.kandagatla@st.com>
References: <1389711077-20949-1-git-send-email-srinivas.kandagatla@st.com>
 <1389711141-21090-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdbFGOm2xm5H+of_NuJ6DVmBDcEODZbDxVU8nGC-RU64Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 3:52 PM,  <srinivas.kandagatla@st.com> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> ST pin controller does not have hardware support for detecting edge
> triggered interrupts, It only has level triggering support.
> This patch attempts to fake up edge triggers from hw level trigger
> support in software. With this facility now the gpios can be easily used
> for keypads, otherwise it would be difficult for drivers like keypads to
> work with level trigger interrupts.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Clever! Mostly I like the patch as it is but:

>         for_each_set_bit(n, &port_active, BITS_PER_LONG) {
> +               /* check if we are detecting fake edges ... */
> +               pin_edge_cfg = ST_IRQ_EDGE_CONF(bank_edge_mask, n);
> +
> +               if (pin_edge_cfg) {
> +                       /* edge detection. */
> +                       val = st_gpio_get(&bank->gpio_chip, n);
> +                       if (val)
> +                               writel(BIT(n), bank->base + REG_PIO_SET_PCOMP);
> +                       else
> +                               writel(BIT(n), bank->base + REG_PIO_CLR_PCOMP);
> +
> +                       if (pin_edge_cfg != ST_IRQ_EDGE_BOTH &&
> +                               !((pin_edge_cfg & ST_IRQ_EDGE_FALLING) ^ val))
> +                                       continue;
> +               }
> +

Please insert comments here to explain what you are actually doing
because I sure as hell do not understand this code without comments
describing the trick used.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:56:50 +0200
Subject: [PATCH 8/8] gpio: stmpe: configure GPIO as output by default
In-Reply-To: <1461068317-28016-9-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-9-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdZwUnf3qfJr7btC7Bz5VXfPGaevmc3A3MTnimSXAj06+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> Configures all GPIOs as output, in order to minimize power
> consumption when GPIOs are unused.
>
> Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Not only do you set them all to outout but also:

> +       /* To minimize power consumption, configure unused GPIOs as outputs */
> +       for (i = 0; i < stmpe_gpio->chip.ngpio; i++)
> +               stmpe_gpio_direction_output(&stmpe_gpio->chip, i, 0);

You are driving them all low.

Now GPIO is general purpose: what if they are connected to a
line with a pull-up resistor?

That is not saving power, instead consuming more than if you
were setting them all to 1.

I am afraid this is wrong.

What you need is to be able to define in the DT (or similar)
a set of initial values for the GPIO lines, and set them to
0 for this design.

Such bindings have been discussed but no conclusion
or merged patch has emerged. Please help out in driving
a standard for this!

Yours,
Linus Walleij

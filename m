From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:53:45 +0200
Subject: [PATCH 7/8] gpio: stmpe: Add STMPE1600 support
In-Reply-To: <1461068317-28016-8-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-8-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdaLhgR8PcKuR1svU=iAEUq=-USN1zktvdor128kEO=G9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> The particularities of this variant are:
> - GPIO_XXX_LSB and GPIO_XXX_MSB memory locations are inverted compared
>   to other variants.
> - There is no Edge detection, Rising Edge and Falling Edge registers.
> - IRQ flags are cleared when read, no need to write in Status register.
>
> Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

> -       u8 reg = stmpe->regs[STMPE_IDX_GPMR_LSB] - (offset / 8);
> +       u8 reg;
>         u8 mask = 1 << (offset % 8);
>         int ret;
>
> +       if (stmpe->partnum == STMPE1600)
> +               reg = stmpe->regs[STMPE_IDX_GPMR_LSB] + (offset / 8);
> +       else
> +               reg = stmpe->regs[STMPE_IDX_GPMR_LSB] - (offset / 8);

This construct is a bit hard to grasp.

Can we think of something more intuitive? Maybe using more
code lines but easier to understand.

Subtracting the offset is just totally unintuitive in the first place,
the STMPE1600 arrangement is much more intuitive.

I would prefer if we address the LSB+MSB register explicitly
instead of adding or subtracting 1 to the LSB register to get
to the MSB register.

> +       if (stmpe->partnum == STMPE1600)
> +               reg = stmpe->regs[which] + (offset / 8);
> +       else
> +               reg = stmpe->regs[which] - (offset / 8);

Same.

> +       if (stmpe->partnum == STMPE1600)
> +               reg = stmpe->regs[STMPE_IDX_GPDR_LSB] + (offset / 8);
> +       else
> +               reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);

Same.

> +       if (stmpe->partnum == STMPE1600)
> +               reg = stmpe->regs[STMPE_IDX_GPDR_LSB] + (offset / 8);
> +       else
> +               reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);

Same.

> +                               stmpe_reg_write(stmpe,
> +                                               stmpe->regs[regmap[i]] + j,
> +                                               new);
> +                       else
> +                               stmpe_reg_write(stmpe,
> +                                               stmpe->regs[regmap[i]] - j,
> +                                               new);

This is also unintuitively backwards.

> +       if (stmpe->partnum == STMPE1600)
> +               dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB] + (offset / 8);
> +       else
> +               dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB] - (offset / 8);

Same.

> +       if (stmpe->partnum == STMPE1600)
> +               statmsbreg = stmpe->regs[STMPE_IDX_ISGPIOR_LSB];
> +       else
> +               statmsbreg = stmpe->regs[STMPE_IDX_ISGPIOR_MSB];

And this kind of points at the problem.

Can we write this in some way that make it super-clear which register
we're using and why?

Yours,
Linus Walleij

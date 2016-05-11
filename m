From: dianders@chromium.org (Doug Anderson)
Date: Wed, 11 May 2016 10:37:57 -0700
Subject: [PATCH v8 7/8] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1462908698-27284-1-git-send-email-david.wu@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908698-27284-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=Uf-U3RBpgFbR3LkPAJTWqz3d02+H7iyA-SS-y=r3cXjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 10, 2016 at 12:31 PM, David Wu <david.wu@rock-chips.com> wrote:
>  static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
>  {
>         struct i2c_timings *t = &i2c->t;
>         struct rk3x_i2c_calced_timings calc;
>         u64 t_low_ns, t_high_ns;
> +       u32 val;
>         int ret;
>
> -       ret = rk3x_i2c_calc_divs(clk_rate, t, &calc);
> +       ret = i2c->soc_data->calc_timings(clk_rate, t, &calc);
>         WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
>
> -       clk_enable(i2c->clk);
> +       clk_enable(i2c->pclk);
> +
>         i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xffff),
>                    REG_CLKDIV);
> -       clk_disable(i2c->clk);
> +
> +       val = i2c_readl(i2c, REG_CON);
> +       val &= ~REG_CON_TUNING_MASK;
> +       val |= calc.tuning;
> +       i2c_writel(i2c, val, REG_CON);

Another subtle bug here.  You need to be holding the spinlock here
since you're doing a read-modify-write of a register that is also
touched by the interrupt handler.  We never needed it before because
the previous register update wasn't touched by anyone else and it was
a single atomic write.

Also: technically if we are midway through a transfer when all this
happens then there will be a very short period of time when the two
timing-related registers won't match with each other.  I have no idea
how much that would matter, but in the very least it seems wise to
minimize the time where they mismatch.  So I'd probably write:

       spin_lock_irqsave(&i2c->lock, flags);
       val = i2c_readl(i2c, REG_CON);
       val &= ~REG_CON_TUNING_MASK;
       val |= calc.tuning;
       i2c_writel(i2c, val, REG_CON);
       i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xffff),
                  REG_CLKDIV);
       spin_unlock_irqrestore(&i2c->lock, flags);

...if we really end up with on a system with a dynamically changing
clock that uses the new-style timing and we see real problems, we can
always try to come up with a way to avoid any problems.  Sound OK?


Otherwise, I think things look good to me.  Caesar's comments would
also be good to fix.


-Doug

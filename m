From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Sep 2014 08:20:23 -0700
Subject: [PATCH] i2c: rk3x: fix divisor calculation for SCL frequency
In-Reply-To: <54098DA6.4090704@rock-chips.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=W3JJM38v-X=pyLUjAzY3Ti88xUgWp9bMsX5dqp1gubpg@mail.gmail.com>
 <54098DA6.4090704@rock-chips.com>
Message-ID: <CAD=FV=WwCTRh44jTvTZoeFFACmWKeGyu=zWb1=BeimGMuT9r2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Fri, Sep 5, 2014 at 3:17 AM, addy ke <addy.ke@rock-chips.com> wrote:

> The following modifications is reasonable?
>
> static void rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
> {
>         unsigned long i2c_rate = clk_get_rate(i2c->clk);
>         unsigned int div;
>
>         /* set DIV = DIVH = DIVL
>          * SCL rate = (clk rate) / (8 * (DIVH + 1 + DIVL + 1))
>          *          = (clk rate) / (16 * (DIV + 1))
>          */
>         div = DIV_ROUND_UP(i2c_rate, scl_rate * 16) - 1;
>
>         i2c_writel(i2c, (div << 16) | (div & 0xffff), REG_CLKDIV);
> }

Yes, that looks much cleaner and is a nice solution, thanks!  Can you
send up a new patch version?

-Doug

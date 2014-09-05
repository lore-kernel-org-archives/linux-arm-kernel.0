From: dianders@chromium.org (Doug Anderson)
Date: Thu, 4 Sep 2014 21:31:56 -0700
Subject: [PATCH] i2c: rk3x: fix divisor calculation for SCL frequency
In-Reply-To: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=W3JJM38v-X=pyLUjAzY3Ti88xUgWp9bMsX5dqp1gubpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Thu, Sep 4, 2014 at 7:32 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> I2C_CLKDIV register descripted in the previous version of
> RK3x chip manual is incorrect. Plus 1 is required.
>
> The correct formula:
> - T(SCL_HIGH) = T(PCLK) * (CLKDIVH + 1) * 8
> - T(SCL_LOW) = T(PCLK) * (CLKDIVL + 1) * 8
> - (SCL Divsor) = 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
> - SCL = PCLK / (CLK Divsor)

I'll trust that you tested this with a scope


> It will be updated to the latest version of chip manual.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index e637c32..76b6604 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -433,8 +433,8 @@ static void rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
>         unsigned long i2c_rate = clk_get_rate(i2c->clk);
>         unsigned int div;
>
> -       /* SCL rate = (clk rate) / (8 * DIV) */
> -       div = DIV_ROUND_UP(i2c_rate, scl_rate * 8);
> +       /* SCL rate = (clk rate) / (8 * (DIV + 2)) */
> +       div = DIV_ROUND_UP(i2c_rate, scl_rate * 8) - 2;

Given the bug I just fixed in the Rockchip SPI driver, I was a little
worried about div becoming -1 (and thus being a really large positive
number since div is unsigned).

However, it seems that you get saved by the next statement:
  div = DIV_ROUND_UP(div, 2);

In the testing I did with the Linux macros, that magically transformed
a div of 0xFFFFFFFF (-1) to 0, so it's not technically a bug.  ...but
it's very non-obvious.  Can you do something a little cleaner?

-Doug

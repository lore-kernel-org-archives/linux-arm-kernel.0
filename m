From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 31 Jul 2018 23:56:48 -0700
Subject: [PATCH i2c-next v2] i2c: aspeed: Add an explicit type casting for
 *get_clk_reg_val
In-Reply-To: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
References: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAFd5g44L+-6wtV4+Kn5-j8zRXA1aNamR2pV0EaFpcoshgQ4bTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 1:39 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit fixes this sparse warning:
> drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignment (different modifiers)
> drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk_reg_val )( ... )
> drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> Changes since v1:
> - Fixed title and added Reported-by tag.
>
>  drivers/i2c/busses/i2c-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index efb89422d496..a4f956c6d567 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -872,7 +872,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         if (!match)
>                 bus->get_clk_reg_val = aspeed_i2c_24xx_get_clk_reg_val;
>         else
> -               bus->get_clk_reg_val = match->data;
> +               bus->get_clk_reg_val = (u32 (*)(u32))match->data;
>
>         /* Initialize the I2C adapter */
>         spin_lock_init(&bus->lock);
> --
> 2.18.0
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 5 Apr 2016 22:52:30 +0200 (CEST)
Subject: [PATCH 2/2] clk: bcm2835: Fix PLL poweron
In-Reply-To: <1459826456-18812-3-git-send-email-eric@anholt.net>
References: <1459826456-18812-1-git-send-email-eric@anholt.net>
 <1459826456-18812-3-git-send-email-eric@anholt.net>
Message-ID: <1945341121.176536.ed7e19c8-94d6-4e1c-b383-3e4ae025eeac.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 5. April 2016 um 05:20 geschrieben:
>
>
> In poweroff, we set the reset bit and the power down bit, but only
> managed to unset the reset bit for poweron. This meant that if HDMI
> did -EPROBE_DEFER after it had grabbed its clocks, we'd power down the
> PLLH (that had been on at boot time) and never recover.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: stable at vger.kernel.org

please provide a Fixes tag.

Thanks Stefan

> ---
> drivers/clk/bcm/clk-bcm2835.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 87616de..7a79708 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -554,6 +554,10 @@ static int bcm2835_pll_on(struct clk_hw *hw)
> const struct bcm2835_pll_data *data = pll->data;
> ktime_t timeout;
>
> + cprman_write(cprman, data->a2w_ctrl_reg,
> + cprman_read(cprman, data->a2w_ctrl_reg) &
> + ~A2W_PLL_CTRL_PWRDN);
> +
> /* Take the PLL out of reset. */
> cprman_write(cprman, data->cm_ctrl_reg,
> cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
> --
> 2.7.0
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

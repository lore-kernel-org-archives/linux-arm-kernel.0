From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Feb 2016 19:04:57 +0100 (CET)
Subject: [PATCH v5 03/20] clk: bcm2835: add locking to pll*_on/off methods
In-Reply-To: <1456673831-2408-4-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
 <1456673831-2408-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <413895849.331121.eb44c2f6-8870-42b4-ada5-1ccea76f532b.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 28. Februar 2016 um 16:36 geschrieben:
>
>
> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add missing locking to:
> * bcm2835_pll_on
> * bcm2835_pll_off
> * bcm2835_pll_divider_on

this should be obvious. Please explain the why.

>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain
clocks")

> ---
> drivers/clk/bcm/clk-bcm2835.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 3aa3e7a..d999a13 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -910,12 +910,14 @@ static void bcm2835_pll_off(struct clk_hw *hw)
> struct bcm2835_cprman *cprman = pll->cprman;
> const struct bcm2835_pll_data *data = pll->data;
>
> + spin_lock(&cprman->regs_lock);
> cprman_write(cprman, data->cm_ctrl_reg,
> cprman_read(cprman, data->cm_ctrl_reg) |
> CM_PLL_ANARST);
> cprman_write(cprman, data->a2w_ctrl_reg,
> cprman_read(cprman, data->a2w_ctrl_reg) |
> A2W_PLL_CTRL_PWRDN);
> + spin_unlock(&cprman->regs_lock);
> }

As i told please move this particular change into 01/20, the rest is okay.

Regards
Stefan

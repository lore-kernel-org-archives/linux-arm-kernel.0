From: martin@sperl.org (Martin Sperl)
Date: Sun, 6 Mar 2016 12:31:05 +0100
Subject: [PATCH v7] clk: bcm2835: Add support for programming the audio
 domain clocks
In-Reply-To: <1444354644-31997-1-git-send-email-eric@anholt.net>
References: <1444354644-31997-1-git-send-email-eric@anholt.net>
Message-ID: <AE3FF4E9-9435-463F-8A05-2ED0CE67BC26@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I know it has already been merged, but while doing some 
clock investigations of the RPI3 I came accross this code:

> On 09.10.2015, at 03:37, Eric Anholt <eric@anholt.net> wrote:
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index dd295e4..8502a4b 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> +static unsigned long bcm2835_pll_get_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	const struct bcm2835_pll_data *data = pll->data;
> +	u32 a2wctrl = cprman_read(cprman, data->a2w_ctrl_reg);
> +	u32 ndiv, pdiv, fdiv;
> +	bool using_prediv;
> +
> +	if (parent_rate == 0)
> +		return 0;
> +
> +	fdiv = cprman_read(cprman, data->frac_reg) & A2W_PLL_FRAC_MASK;
> +	ndiv = (a2wctrl & A2W_PLL_CTRL_NDIV_MASK) >> A2W_PLL_CTRL_NDIV_SHIFT;
> +	pdiv = (a2wctrl & A2W_PLL_CTRL_PDIV_MASK) >> A2W_PLL_CTRL_PDIV_SHIFT;
> +	using_prediv = cprman_read(cprman, data->ana_reg_base + 4) &
> +		data->ana->fb_prediv_mask;
> +
> +	if (using_prediv)
> +		ndiv *= 2;
Is this really correct?

As far as I interpret the name ?fb_predic_mask" it should be either:
  pdiv * = 2; /* there is already a divider of 2 applied */
or
  ndiv *= 2; /* we need to multiply bot integer and fractional by 2 */
  fdiv *= 2;

As it is a pre-divider, I would assume it is the first,
but I could be wrong - not knowing a lot about PLLs.

Just want to raise this as a question.

Martin

From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 23 Jan 2018 12:03:46 +0100
Subject: [PATCH V3 01/10] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE
 clk support
In-Reply-To: <1516367470-24340-2-git-send-email-aisheng.dong@nxp.com>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
 <1516367470-24340-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1516705426.7870.45.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-01-19 at 21:11 +0800, Dong Aisheng wrote:
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index f711be6..68ccd36 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -360,6 +360,7 @@ struct clk_div_table {
>   * @shift:     shift to the divider bit field
>   * @width:     width of the divider bit field
>   * @table:     array of value/divider pairs, last entry should have div = 0
> + * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
>   * @lock:      register lock
>   *
>   * Clock with an adjustable divider affecting its output frequency.  Implements
> @@ -388,6 +389,12 @@ struct clk_div_table {
>   * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_BASED
>   *     except when the value read from the register is zero, the divisor is
>   *     2^width of the field.
> + * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_BASED

Unless I missed something in your patch, this comment says that, like
CLK_DIVIDER_MAX_AT_ZERO, CLK_DIVIDER_ZERO_GATE behave as a CLK_DIVIDER_ONE_BASED
clock

However, I don't see anything special done in _get_val() around
CLK_DIVIDER_ZERO_GATE which means that calling _get_val() with div=2 would give
val=1. This is more like a regular divider (when CLK_DIVIDER_ONE_BASED is not
set)

Also, when looking for the best divider, CCF could find that the best div is 1.
On a non-CLK_DIVIDER_ONE_BASED, this would translate to value 0 and
(accidentally) gate the clock .

all the occurrences of CLK_DIVIDER_ZERO_GATE I have seen in patch 9 are combined
with CLK_DIVIDER_ONE_BASED, which is probably why this potential issue has gone
unnoticed.

I think CLK_DIVIDER_ZERO_GATE should just means that value 0 gate the clock, and
just that. It should not imply what the rest of values mean.

In a more general way, I'd love to see a feature such as CLK_DIVIDER_ZERO_GATE
added to the divider but I'm bit concerned of all the quirks we are slowly
adding to the generic divider. It seems we are all trying re-use the algorithm
of clk_divider_bestdiv() with different 'val-to-div' transfer function. Not too
sure what the best solution could be though.

> + *     when the value read from the register is zero, it means the divisor
> + *     is gated. For this case, the cached_val will be used to store the
> + *     intermediate div for the normal rate operation, like set_rate/get_rate/
> + *     recalc_rate. When the divider is ungated, the driver will actually
> + *     program the hardware to have the requested divider value.
>   */

From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 31 Aug 2014 12:15:50 +0200
Subject: [PATCH v2 03/12] clk: Add a function to retrieve phase
In-Reply-To: <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
 <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5402F5D6.4080100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/30/2014 10:03 PM, Maxime Ripard wrote:
> The current phase API doesn't look into the actual hardware to get the phase
> value, but will rather get it from a variable only set by the set_phase
> function.
> 
> This will cause issue when the client driver will never call the set_phase
> function, where we can end up having a reported phase that will not match what
> the hardware has been programmed to by the bootloader or what phase is
> programmed out of reset.
> 
> Add a new get_phase function for the drivers to implement so that we can get
> this value.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/clk.c            | 17 ++++++++++++++---
>  include/linux/clk-provider.h |  5 +++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d87661af0c72..7dbceca694f1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1797,8 +1797,8 @@ out:
>   * clk_get_phase - return the phase shift of a clock signal
>   * @clk: clock signal source
>   *
> - * Returns the phase shift of a clock node in degrees, otherwise returns
> - * -EERROR.
> + * Returns the phase shift of a clock node in degrees. Any negative
> + * values are errors.
>   */
>  int clk_get_phase(struct clk *clk)
>  {
> @@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
>  		goto out;
>  
>  	clk_prepare_lock();
> -	ret = clk->phase;
> +
> +	if (clk->phase) {
> +		ret = clk->phase;
> +		goto out_unlock;
> +	}

0 is a valid phase, so this will cause the phase to
be read from the hardware each time if the phase is 0.

Perhaps make clk->phase signed (if it is not already), init it
to -1, and check for it not being -1 ?

Regards,

Hans


> +
> +	if (!clk->ops->get_phase)
> +		goto out_unlock;
> +
> +	ret = clk->ops->get_phase(clk->hw);
> +
> +out_unlock:
>  	clk_prepare_unlock();
>  
>  out:
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 69b20d4c1e1a..abec961092a7 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -130,6 +130,10 @@ struct dentry;
>   *		set then clock accuracy will be initialized to parent accuracy
>   *		or 0 (perfect clock) if clock has no parent.
>   *
> + * @get_phase:	Queries the hardware to get the current phase of a clock.
> + *		Returned values are 0-359 degrees on success, negative
> + *		error codes on failure.
> + *
>   * @set_phase:	Shift the phase this clock signal in degrees specified
>   *		by the second argument. Valid values for degrees are
>   *		0-359. Return 0 on success, otherwise -EERROR.
> @@ -182,6 +186,7 @@ struct clk_ops {
>  				    unsigned long parent_rate, u8 index);
>  	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
>  					   unsigned long parent_accuracy);
> +	int		(*get_phase)(struct clk_hw *hw);
>  	int		(*set_phase)(struct clk_hw *hw, int degrees);
>  	void		(*init)(struct clk_hw *hw);
>  	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
> 

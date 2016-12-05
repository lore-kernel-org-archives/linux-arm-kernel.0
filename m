From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Dec 2016 16:13:42 +0530
Subject: [PATCH v3 3/3] ARM: da850: fix da850_set_pll0rate()
In-Reply-To: <1480932549-30811-4-git-send-email-bgolaszewski@baylibre.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
 <1480932549-30811-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <d4214e68-19c7-3bcc-ec13-5615f52ee054@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 December 2016 03:39 PM, Bartosz Golaszewski wrote:
> This function is confusing - its second argument is an index to the
> freq table, not the requested clock rate in Hz, but it's used as the
> set_rate callback for the pll0 clock. It leads to an oops when the
> caller doesn't know the internals and passes the rate in Hz as
> argument instead of the cpufreq index since this argument isn't bounds
> checked either.
> 
> Fix it by iterating over the array of supported frequencies and
> selecting a one that matches or returning -EINVAL for unsupported
> rates.
> 
> Also: update the davinci cpufreq driver. It's the only user of this
> clock and currently it passes the cpufreq table index to
> clk_set_rate(), which is confusing. Make it pass the requested clock
> rate in Hz.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-davinci/da850.c     | 20 ++++++++++++++++----
>  drivers/cpufreq/davinci-cpufreq.c |  2 +-
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 006ec56..9837541 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -1179,14 +1179,26 @@ static int da850_set_armrate(struct clk *clk, unsigned long index)
>  	return clk_set_rate(pllclk, index);
>  }
>  
> -static int da850_set_pll0rate(struct clk *clk, unsigned long index)
> +static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
>  {
> -	unsigned int prediv, mult, postdiv;
> -	struct da850_opp *opp;
>  	struct pll_data *pll = clk->pll_data;
> +	struct cpufreq_frequency_table *freq;
> +	unsigned int prediv, mult, postdiv;
> +	struct da850_opp *opp = NULL;
>  	int ret;
>  
> -	opp = (struct da850_opp *) cpufreq_info.freq_table[index].driver_data;
> +	for (freq = da850_freq_table;
> +	     freq->frequency != CPUFREQ_TABLE_END; freq++) {
> +		/* rate is in Hz, freq->frequency is in KHz */
> +		if (freq->frequency == rate / 1000) {

Or
	rate = rate / 1000;

before the loop begins? The idea behind my comment was mostly to reduce
the amount of calculation in the loop.

Thanks,
Sekhar

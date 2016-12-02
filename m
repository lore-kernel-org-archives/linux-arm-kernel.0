From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Dec 2016 16:50:55 +0530
Subject: [PATCH 3/3] ARM: da850: fix da850_set_pll0rate()
In-Reply-To: <1480612516-18853-4-git-send-email-bgolaszewski@baylibre.com>
References: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
 <1480612516-18853-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <4b1d65f7-d9a6-6d4e-00f5-2835b728661c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 December 2016 10:45 PM, Bartosz Golaszewski wrote:
> This function is broken - its second argument is an index to the freq
> table, not the requested clock rate in Hz. It leads to an oops when
> called from clk_set_rate() since this argument isn't bounds checked
> either.
> 
> Fix it by iterating over the array of supported frequencies and
> selecting a one that matches or returning -EINVAL for unsupported
> rates.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When this function was written, it was written for speed. The only user
of setting pll0 rate is drivers/cpufreq/davinci-cpufreq.c (not sure how
you were trying to set pll0 rate). And that driver directly passes the
table index to the set_rate() function.

The idea was to optimize for speed in cpufreq driver and quickly index
into the pll data instead of searching through it.

But I agree, it is confusing and we are better off with maintainable
code. So, no problem with the patch, but this needs to be done along
with updates to cpufreq driver.

> ---
>  arch/arm/mach-davinci/da850.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 855b720..1c0f296 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -1173,14 +1173,28 @@ static int da850_set_armrate(struct clk *clk, unsigned long index)
>  	return clk_set_rate(pllclk, index);
>  }
>  
> -static int da850_set_pll0rate(struct clk *clk, unsigned long index)
> +static int da850_set_pll0rate(struct clk *clk, unsigned long requested_rate)

Calling it just 'rate' is fine, IMO. The name of the function is enough
to suggest that its the rate to be set to.

Thanks,
Sekhar

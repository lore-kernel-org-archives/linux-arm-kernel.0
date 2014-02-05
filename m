From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 05 Feb 2014 15:48:47 +0100
Subject: [PATCH] clk: add strict of_clk_init dependency check
In-Reply-To: <1391593680-9388-1-git-send-email-b.brezillon@overkiz.com>
References: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
 <1391593680-9388-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52F24F4F.8000901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 05/02/2014 10:48, Boris BREZILLON wrote:
> The parent dependency check is only available on the first parent of a given
> clk.
> 
> Add support for strict dependency check: all parents of a given clk must be
> initialized.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
> 
> Hello Gregory,
> 
> This patch adds support for strict check on clk dependencies (check if all
> parents specified by an DT clk node are initialized).
> 
> I'm not sure this is what you were expecting (maybe testing the first parent
> is what you really want), so please feel free to tell me if I'm wrong.
> 
> Best Regards,
> 
> Boris
> 
>  drivers/clk/clk.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index beb0f8b..6849769 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2543,22 +2543,37 @@ static int parent_ready(struct device_node *np)
>  {
>  	struct of_phandle_args clkspec;
>  	struct of_clk_provider *provider;
> +	int num_parents;
> +	bool found;
> +	int i;
>  
>  	/*
>  	 * If there is no clock parent, no need to wait for them, then
>  	 * we can consider their absence as being ready
>  	 */
> -	if (of_parse_phandle_with_args(np, "clocks", "#clock-cells", 0,
> -					&clkspec))
> +	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
> +	if (num_parents <= 0)
>  		return 1;
>  
> -	/* Check if we have such a provider in our array */
> -	list_for_each_entry(provider, &of_clk_providers, link) {
> -		if (provider->node == clkspec.np)
> +	for (i = 0; i < num_parents; i++) {
> +		if (of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
> +					       &clkspec))
>  			return 1;
> +
> +		/* Check if we have such a provider in our array */
> +		found = false;
> +		list_for_each_entry(provider, &of_clk_providers, link) {
> +			if (provider->node == clkspec.np) {
> +				found = true;
> +				break;

Hum this means that as soon as you have one parent then you consider it
as ready. It is better of what I have done because I only test the 1st
parent. However I wondered if we should go further by ensuring all the
parents are ready.

If I am right, there is more than one parent only for the muxer. In this
case is it really expected that all the parent are ready?

Thanks,

Gregory

> +			}
> +		}
> +
> +		if (!found)
> +			return 0;
>  	}
>  
> -	return 0;
> +	return 1;
>  }
>  
>  /**
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

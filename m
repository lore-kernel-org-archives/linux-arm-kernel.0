From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 26 Apr 2013 17:08:31 -0700
Subject: [PATCH] clk: add option to keep boot clocks on
In-Reply-To: <1367019591-31685-1-git-send-email-olof@lixom.net>
References: <1367019591-31685-1-git-send-email-olof@lixom.net>
Message-ID: <517B16FF.6070008@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/13 16:39, Olof Johansson wrote:
> This is primarily useful when there's a driver that doesn't claim clocks
> properly, but the bootloader does. It's not expected to be used in normal
> cases, but for bringup and debug it's very useful to have the option to
> not gate unclaimed clocks that are still on.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

add to Documentation/kernel-parameters.txt or somewhere else?

> ---
> 
> Mike, this is a pretty trivial patch that I would love to see in 3.10
> even though it's getting late. I'm definitely not picky about the naming
> of the boot option, so feel free to change it.
> 
> 
> -Olof
> 
>  drivers/clk/clk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 20ce67f..b22551e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -499,10 +499,24 @@ out:
>  	return;
>  }
>  
> +
> +static bool keep_boot_clocks;
> +static int __init clk_keep_boot_clocks(char *__unused)
> +{
> +	keep_boot_clocks = true;
> +	return 1;
> +}
> +__setup("clk_keep_boot_clocks", clk_keep_boot_clocks);
> +
>  static int clk_disable_unused(void)
>  {
>  	struct clk *clk;
>  
> +	if (keep_boot_clocks) {
> +		pr_warn("clk: Not disabling unused clocks\n");
> +		return 0;
> +	}
> +
>  	clk_prepare_lock();
>  
>  	hlist_for_each_entry(clk, &clk_root_list, child_node)
> 


-- 
~Randy

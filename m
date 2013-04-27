From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 27 Apr 2013 11:17:13 -0700
Subject: [PATCH] clk: add option to keep boot clocks on
In-Reply-To: <1367019591-31685-1-git-send-email-olof@lixom.net>
References: <1367019591-31685-1-git-send-email-olof@lixom.net>
Message-ID: <20130427181713.8923.62611@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Olof Johansson (2013-04-26 16:39:51)
> This is primarily useful when there's a driver that doesn't claim clocks
> properly, but the bootloader does. It's not expected to be used in normal
> cases, but for bringup and debug it's very useful to have the option to
> not gate unclaimed clocks that are still on.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Mike, this is a pretty trivial patch that I would love to see in 3.10
> even though it's getting late. I'm definitely not picky about the naming
> of the boot option, so feel free to change it.
> 

This bike shed could be improved with a different color of paint.
Opinions below:

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
>         return;
>  }
>  
> +

Remove extra whitespace.

> +static bool keep_boot_clocks;
> +static int __init clk_keep_boot_clocks(char *__unused)
> +{
> +       keep_boot_clocks = true;
> +       return 1;
> +}
> +__setup("clk_keep_boot_clocks", clk_keep_boot_clocks);

s/clk_keep_boot_clocks/clk_ignore_unused/

This matches nicely with the existing CLK_IGNORE_UNUSED flag in
include/linux/clk-provider.h

In addition to Randy's suggestion to update kernel-parameters.txt,
please also toss in a note somewhere in Documentation/clk.txt so that
others bringing up new platforms can more easily find out about this
boot option.  Don't worry about making it pretty since I plan to rework
the clock documentation for 3.11.

Otherwise patch looks good to me.  I did some testing and I would be
comfortable sneaking this in for 3.10.

Regards,
Mike

> +
>  static int clk_disable_unused(void)
>  {
>         struct clk *clk;
>  
> +       if (keep_boot_clocks) {
> +               pr_warn("clk: Not disabling unused clocks\n");
> +               return 0;
> +       }
> +
>         clk_prepare_lock();
>  
>         hlist_for_each_entry(clk, &clk_root_list, child_node)
> -- 
> 1.8.1.192.gc4361b8

From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Dec 2016 09:08:00 -0800
Subject: [PATCH v3] mach-omap2: fixing wrong strcat for Non-NULL
 terminated string
In-Reply-To: <1480915633-16284-1-git-send-email-maninder1.s@samsung.com>
References: <1480915633-16284-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20161206170800.GB13181@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Maninder Singh <maninder1.s@samsung.com> [161204 21:32]:
> Issue caught with static analysis tool:
> "Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"
> 
> Use strlcpy _includes_ the NUL terminator, and  strlcat() which ensures 
> that it won't overflow the buffer.
> 
> Reported-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Russell King <linux@armlinux.org.uk>

I think the above should have been just:

Cc: Russell King <linux@armlinux.org.uk>

Can you please check and resend with Russell in Cc?

Regards,

Tony

> ---
> v1 -> v2: changed strncpy to strlcpy
> v2 -> v3: use of strlcat as suggested by Russell to
> 	  make change clearer and simpler.
> 
>  arch/arm/mach-omap2/omap_hwmod.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 759e1d4..e8b9887 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -741,14 +741,14 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  	int ret = 0;
>  	char name[MOD_CLK_MAX_NAME_LEN];
>  	struct clk *clk;
> +	static const char modck[] = "_mod_ck";
>  
> -	/* +7 magic comes from '_mod_ck' suffix */
> -	if (strlen(oh->name) + 7 > MOD_CLK_MAX_NAME_LEN)
> +	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
>  		pr_warn("%s: warning: cropping name for %s\n", __func__,
>  			oh->name);
>  
> -	strncpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - 7);
> -	strcat(name, "_mod_ck");
> +	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
> +	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
>  
>  	clk = clk_get(NULL, name);
>  	if (!IS_ERR(clk)) {
> -- 
> 1.9.1
> 

From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 30 Sep 2011 12:17:55 -0500
Subject: [PATCH 1/2] ARM: CLKDEV: Add Common Macro for clk_lookup
In-Reply-To: <1317381097-2691-2-git-send-email-padma.v@samsung.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-2-git-send-email-padma.v@samsung.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DC56773@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 30, 2011 4:12 AM, Padmavathi Venna wrote:
>
> Added a standardized macro CLKDEV_INIT which can used across all
> the platforms to support clkdev
>
> Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  include/linux/clkdev.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
> index 457bcb0..f2db158 100644
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -14,6 +14,13 @@
>  
>  #include <asm/clkdev.h>
>  
> +#define CLKDEV_INIT(d, n, c) \
> +	{ \
> +		.dev_id = d, \
> +		.con_id = n, \
> +		.clk = &c, \
> +	},

Padmavathi,

I just noticed you have the ending ',' in the macro.  This makes the
clk_lookup tables look a bit strange and hides what each entry in the
table is.

static struct clk_lookup foo_clks[] = {
	CLKDEV("bar1_dev", "bar1_con", bar1_clk)
	CLKDEV("bar2_dev", "bar2_con", bar2_clk)
	...
};

I think this is a bit clearer:

static struct clk_lookup foo_clks[] = {
	CLKDEV("bar1_dev", "bar1_con", bar1_clk),
	CLKDEV("bar2_dev", "bar2_con", bar2_clk),
	...
};

Also, having the macro automatically add the '&' to the clk parameter
hides the fact that it's a pointer.  If you remove it CLKDEV(NULL, NULL, NULL)
would then work for the sentinel entry's in mach0-davinci.

Care to remove that comma, and possibly the '&', and redo the patch set?

Regards,
Hartley

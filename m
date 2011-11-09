From: robherring2@gmail.com (Rob Herring)
Date: Tue, 08 Nov 2011 20:36:22 -0600
Subject: [RFC 7/8] arm/clkdev: lookup clocks from OF clock providers
In-Reply-To: <1320801583-12774-8-git-send-email-grant.likely@secretlab.ca>
References: <1320801583-12774-1-git-send-email-grant.likely@secretlab.ca>
 <1320801583-12774-8-git-send-email-grant.likely@secretlab.ca>
Message-ID: <4EB9E726.2000500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2011 07:19 PM, Grant Likely wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> Hook the OF clock provider infrastructure to clk_get.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/clk/clkdev.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 6db161f..63f81c9 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -19,6 +19,8 @@
>  #include <linux/mutex.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/of.h>
> +#include <linux/of_clk.h>
>  
>  static LIST_HEAD(clocks);
>  static DEFINE_MUTEX(clocks_mutex);
> @@ -78,6 +80,11 @@ EXPORT_SYMBOL(clk_get_sys);
>  struct clk *clk_get(struct device *dev, const char *con_id)
>  {
>  	const char *dev_id = dev ? dev_name(dev) : NULL;
> +	struct clk *clk;
> +

Need NULL check for dev (and then init clk to NULL):

	if (dev && dev->of_node)
> +	clk = of_clk_get_by_name(dev->of_node, con_id);

> +	if (clk && __clk_get(clk))
> +		return clk;
>  
>  	return clk_get_sys(dev_id, con_id);
>  }

From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 11:36:49 +0800
Subject: [PATCH] bus: imx-weim: Take the 'status' property value into
 account
In-Reply-To: <1456142513-12876-1-git-send-email-festevam@gmail.com>
References: <1456142513-12876-1-git-send-email-festevam@gmail.com>
Message-ID: <20160229033649.GS22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:01:53AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently we have an incorrect behaviour when multiple devices
> are present under the weim node. For example:
> 
> &weim {
> 	...
> 	status = "okay";
> 	
> 	sram at 0,0 {
> 		...
>         	status = "okay";
> 	};
> 
> 	mram at 0,0 {
> 		...
>         	status = "disabled";
>     	};
> };
> 
> In this case only the 'sram' device should be probed and not 'mram'.
> 
> However what happens currently is that the status variable is ignored,
> causing the 'sram' device to be disabled and 'mram' to be enabled.  
> 
> Change the weim_parse_dt() function to use
> for_each_available_child_of_node()so that the devices marked with
> 'status = disabled' are not probed.
> 
> Cc: <stable@vger.kernel.org>
> Suggested-by: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Arnd, Olof,

I do not have any other 'driver' patches queued, so please help directly
apply this one.  Considering this fixes a real problem, it would be good
if we can merge this through -rc.  But we understand that it's -rc6 now,
and this doesn't fix a regression or so-critical issue, so it should be
fine to queue the patch for the next release as well.

Shawn

> ---
>  drivers/bus/imx-weim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index e98d15e..1827fc4 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -150,7 +150,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  			return ret;
>  	}
>  
> -	for_each_child_of_node(pdev->dev.of_node, child) {
> +	for_each_available_child_of_node(pdev->dev.of_node, child) {
>  		if (!child->name)
>  			continue;
>  
> -- 
> 1.9.1
> 
> 

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Sep 2017 15:25:23 +0200
Subject: [PATCH] rtc: sun6i: fix memory leak
In-Reply-To: <1505652190-4942-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1505652190-4942-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <20170927132523.u6miojeax67idtsj@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/09/2017 at 13:43:10 +0100, Sudip Mukherjee wrote:
> If 'clk_data' is not allocated we returned but we failed to free 'rtc'.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 3d2216c..5bc28ee 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -201,8 +201,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node)
>  
>  	clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
>  			   GFP_KERNEL);
> -	if (!clk_data)
> +	if (!clk_data) {
> +		kfree(rtc);
>  		return;
> +	}

Please also fix the other occurrence of the issue in the same function.

>  
>  	spin_lock_init(&rtc->lock);
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 19 Nov 2017 09:38:36 +0100
Subject: [PATCH 1/2 v3] misc: aspeed-lpc-snoop: Fix platform_get_irq's
 error checking
In-Reply-To: <3ce95a4e4eb4476b19868f36cd1f11e4b62b6203.1511065797.git.arvind.yadav.cs@gmail.com>
References: <3ce95a4e4eb4476b19868f36cd1f11e4b62b6203.1511065797.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171119083836.qx7bbnalum5rebj3@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2017 at 10:04:00 +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ 0 is not valid.
> changes in v3:
>               Return -ENODEV instead of lpc_snoop->irq.

What about -EPROBE_DEFER?

> 
>  drivers/misc/aspeed-lpc-snoop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/misc/aspeed-lpc-snoop.c
> index cb78c98..e3be88f 100644
> --- a/drivers/misc/aspeed-lpc-snoop.c
> +++ b/drivers/misc/aspeed-lpc-snoop.c
> @@ -115,7 +115,7 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
>  	int rc;
>  
>  	lpc_snoop->irq = platform_get_irq(pdev, 0);
> -	if (!lpc_snoop->irq)
> +	if (lpc_snoop->irq <= 0)
>  		return -ENODEV;
>  
>  	rc = devm_request_irq(dev, lpc_snoop->irq,
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

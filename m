From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 16 Jan 2013 22:37:08 +0300
Subject: [PATCH v6 03/22] mfd: omap-usb-tll: Use devm_kzalloc/ioremap
 and clean up error path
In-Reply-To: <1358347433-329-4-git-send-email-rogerq@ti.com>
References: <1358347433-329-1-git-send-email-rogerq@ti.com>
 <1358347433-329-4-git-send-email-rogerq@ti.com>
Message-ID: <50F70164.3080105@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/16/2013 05:43 PM, Roger Quadros wrote:

> Use devm_ variants of kzalloc() and ioremap(). Simplify the error path.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-tll.c |   36 +++++++++++-------------------------
>  1 files changed, 11 insertions(+), 25 deletions(-)

> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 9658e18..53ed10b 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
[...]
> -	base = ioremap(res->start, resource_size(res));
> +	base = devm_request_and_ioremap(dev, res);
>  	if (!base) {
> -		dev_err(dev, "TLL ioremap failed\n");
>  		ret = -ENOMEM;

   -EADDRNOTAVAIL as the comment to devm_request_and_ioremap() suggests.

> -		goto err_usbtll_p2_fck;
> +		dev_err(dev, "Resource request/ioremap failed:%d\n", ret);
> +		goto err_res;
>  	}

WBR, Sergei

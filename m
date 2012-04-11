From: balbi@ti.com (Felipe Balbi)
Date: Wed, 11 Apr 2012 14:34:57 +0300
Subject: [PATCHv7 11/18] I2C: OMAP: use devm_* functions
In-Reply-To: <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120411113456.GF12064@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:42:49PM +0530, Shubhrajyoti D wrote:
> The various devm_ functions allocate memory that is released when a driver
> detaches. This patch uses devm_kzalloc, devm_request_mem_region and
> devm_ioremap for data that is allocated in the probe function of a platform
> device and is only freed in the remove function.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   29 +++++++++--------------------
>  1 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 121c52e..86be475 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -995,17 +995,17 @@ omap_i2c_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	ioarea = request_mem_region(mem->start, resource_size(mem),
> -			pdev->name);
> +	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
> +			resource_size(mem), pdev->name);

you could use devm_request_and_ioremap()

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/210aa6c6/attachment.sig>

From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Dec 2014 17:11:26 +0000
Subject: [PATCH v2 1/3] power: reset: read priority from device tree
In-Reply-To: <1417453389-1588-2-git-send-email-stefan@agner.ch>
References: <1417453389-1588-1-git-send-email-stefan@agner.ch>
 <1417453389-1588-2-git-send-email-stefan@agner.ch>
Message-ID: <20141201171126.GB22708@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:03:07PM +0000, Stefan Agner wrote:
> This patch adds an optional property which allows to specify the
> reset source priority. This priority is used by the kernel restart
> handler call chain to sort out the proper reset/restart method.
> Depending on the power design of a board or other machine/board
> specific peculiarity, it is not possible to pick a generic priority.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/power/reset/syscon-reboot.txt | 3 +++
>  drivers/power/reset/syscon-reboot.c                             | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> index 1190631..ee41d9c 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> @@ -11,6 +11,9 @@ Required properties:
>  - offset: offset in the register map for the reboot register (in bytes)
>  - mask: the reset value written to the reboot register (32 bit access)
>  
> +Optional properties:
> +- priority: define the priority of the reset (0-255, defaults to 128)
> +

NAK. This is a leak of Linux-internal details.

What is this necessary for?

Mark.

>  Default will be little endian mode, 32 bit access only.
>  
>  Examples:
> diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
> index 815b901..3060d6b 100644
> --- a/drivers/power/reset/syscon-reboot.c
> +++ b/drivers/power/reset/syscon-reboot.c
> @@ -67,8 +67,11 @@ static int syscon_reboot_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
>  		return -EINVAL;
>  
> -	ctx->restart_handler.notifier_call = syscon_restart_handle;
>  	ctx->restart_handler.priority = 128;
> +	of_property_read_u32(pdev->dev.of_node, "priority",
> +			     &ctx->restart_handler.priority);
> +
> +	ctx->restart_handler.notifier_call = syscon_restart_handle;
>  	err = register_restart_handler(&ctx->restart_handler);
>  	if (err)
>  		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
> -- 
> 2.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 16 Jan 2013 22:34:31 +0300
Subject: [PATCH v6 11/22] mfd: omap-usb-host: Use devm_kzalloc() and
 devm_request_and_ioremap()
In-Reply-To: <1358347433-329-12-git-send-email-rogerq@ti.com>
References: <1358347433-329-1-git-send-email-rogerq@ti.com>
 <1358347433-329-12-git-send-email-rogerq@ti.com>
Message-ID: <50F700C7.2020101@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/16/2013 05:43 PM, Roger Quadros wrote:

> Use devm_ variants of kzalloc and ioremap. Also clean up error path.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
[...]

> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 061366d..0f190b6 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -461,15 +461,20 @@ static int usbhs_omap_probe(struct platform_device *pdev)
[...]
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
> +	omap->uhh_base = devm_request_and_ioremap(dev, res);
> +	if (!omap->uhh_base) {
> +		dev_err(dev, "Resource request/ioremap failed\n");
> +		return -ENOMEM;

   Should be -EADDRNOTAVAIL according to the comment to
devm_request_and_ioremap()...

WBR, Sergei

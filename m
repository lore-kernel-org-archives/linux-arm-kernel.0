From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 11:35:54 -0600
Subject: [PATCH v4 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1386869130-2993-2-git-send-email-w-kwok2@ti.com>
References: <1386869130-2993-1-git-send-email-w-kwok2@ti.com>
 <1386869130-2993-2-git-send-email-w-kwok2@ti.com>
Message-ID: <20131212173554.GC1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 12, 2013 at 12:25:29PM -0500, WingMan Kwok wrote:
> +static int kdwc3_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> +
> +	kdwc3_disable_irqs(kdwc);
> +	clk_disable_unprepare(kdwc->clk);

isn't this same clock feeding dwc3 core ?

> +	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);

if it is, you should disable the clock only *after* removing the core,
provided core will access registers during remove.


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/3302c8f3/attachment.sig>

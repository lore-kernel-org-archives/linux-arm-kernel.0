From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Nov 2013 11:41:40 -0600
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <5295B93A.3040400@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
 <5295B93A.3040400@ti.com>
Message-ID: <20131127174140.GE8123@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 27, 2013 at 02:49:54PM +0530, George Cherian wrote:
> >+	error = of_platform_populate(node, NULL, NULL, dev);
> >+	if (error) {
> >+		dev_err(&pdev->dev, "failed to create dwc3 core\n");
> >+		goto err_core;
> >+	}
> >+
> >+	return 0;
> >+
> >+err_core:
> >+	kdwc3_disable_irqs(kdwc);
> >+err_irq:
> >+	kdwc3_disable(kdwc);
> >+
> >+	return error;
> >+}
> >+
> >+static int kdwc3_remove(struct platform_device *pdev)
> >+{
> >+	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> >+
> >+	if (kdwc) {
> >+		kdwc3_disable_irqs(kdwc);
> >+		kdwc3_disable(kdwc);
> >+		platform_set_drvdata(pdev, NULL);
> >+	}
> >+	return 0;
> >+}
> >+
> 
> You need to unregister the child nodes in remove.
> Also why can't the dwc3-omap driver be reused, Felipe??
> I believe the TI wrapper for Keystone is similar to that of AM437x or
> OMAP5.

it is very similar indeed, if it can be easily re-use that glue, I'd
rather not add another.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/eac509d5/attachment.sig>

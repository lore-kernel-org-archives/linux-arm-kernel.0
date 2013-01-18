From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jan 2013 10:59:02 +0000
Subject: [PATCH 2/2] usb: chipidea: imx: Add system suspend/resume API
In-Reply-To: <1358477428-2605-2-git-send-email-peter.chen@freescale.com>
References: <1358477428-2605-1-git-send-email-peter.chen@freescale.com>
 <1358477428-2605-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20130118105901.GC23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:50:28AM +0800, Peter Chen wrote:
> +#ifdef CONFIG_PM
> +static int ci13xxx_imx_suspend(struct device *dev)
> +{
> +	struct ci13xxx_imx_data *data =
> +		platform_get_drvdata(to_platform_device(dev));

Is there a reason not to use dev_get_drvdata() here?  Hint:

#define to_platform_device(x) container_of((x), struct platform_device, dev)

static inline void *platform_get_drvdata(const struct platform_device *pdev)
{
        return dev_get_drvdata(&pdev->dev);
}

So, you're going from a dev => platform device => the same dev again.

It's perfectly valid to use dev_get_drvdata() here because we're not going
to separate these two (it makes absolutely no sense to.)

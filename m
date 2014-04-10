From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Apr 2014 23:42:44 +0100
Subject: [PATCH v4 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <1397155678-26607-3-git-send-email-lho@apm.com>
References: <1397155678-26607-1-git-send-email-lho@apm.com>
 <1397155678-26607-2-git-send-email-lho@apm.com>
 <1397155678-26607-3-git-send-email-lho@apm.com>
Message-ID: <20140410224244.GH6518@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 12:47:57PM -0600, Loc Ho wrote:

> +	if (device_may_wakeup(&pdev->dev)) {
> +		if (!enable_irq_wake(irq))
> +			pdata->irq_wake = 1;
> +	} else {
> +		pdata->irq_enabled = xgene_rtc_alarm_irq_enabled(dev);
> +		xgene_rtc_alarm_irq_enable(dev, 0);
> +		clk_disable(pdata->clk);
> +	}
> +	clk_unprepare(pdata->clk);

This will unconditionally unprepare the clock even if it wasn't disabled
which looks like a bug - I would have expected the disable to be a
clk_disable_unprepare() instead?  Similarly for the resume path.

Otherwise this looks good to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/2d493b32/attachment.sig>

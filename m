From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Apr 2014 18:21:34 +0100
Subject: [rtc-linux] [PATCH] rtc: Fix suspend/resume for APM X-Gene SoC
 RTC driver
In-Reply-To: <1397259218-20494-1-git-send-email-lho@apm.com>
References: <1397259218-20494-1-git-send-email-lho@apm.com>
Message-ID: <20140414172134.GB25182@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 05:33:38PM -0600, Loc Ho wrote:

> -	clk_prepare_enable(pdata->clk);
> +	ret = clk_prepare_enable(pdata->clk);
> +	if (ret)
> +		return ret;
>  
>  	/* Turn on the clock and the crystal */
>  	writel(RTC_CCR_EN, pdata->csr_base + RTC_CCR);
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	ret = device_init_wakeup(&pdev->dev, 1);
> +	if (ret)
> +		return ret;
>  
If the init fails you should unprepare (though I suspect the same issue
applies to other things in the probe function anyway).  If you fix that
then feel free to add:

Reviewed-by: Mark Brown <broonie@linaro.org>

or anyway I guess.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/e4980563/attachment.sig>

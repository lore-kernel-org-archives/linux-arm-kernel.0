From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Feb 2013 13:19:12 +0000
Subject: [PATCH 01/35] mfd: ab8500-gpadc: Implemented suspend/resume
In-Reply-To: <1360933026-30325-2-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20130220131912.GB13049@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 12:56:32PM +0000, Lee Jones wrote:

> +static int ab8500_gpadc_suspend(struct device *dev)
> +{
> +	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
> +
> +	mutex_lock(&gpadc->ab8500_gpadc_lock);
> +
> +	pm_runtime_get_sync(dev);
> +
> +	regulator_disable(gpadc->regu);
> +	return 0;
> +}

This doesn't look especially sane...  You're doing a runtime get, taking
the lock without releasing it and disabling the regulator.  This is
*very* odd, both the changelog and the code need to explain what's going
on and why it's safe in a lot more detail here.

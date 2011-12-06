From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Dec 2011 11:47:37 +0000
Subject: [RFC PATCH 1/8] ARM: Add commonly used cpuidle init code
In-Reply-To: <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
Message-ID: <20111206114737.GF17194@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 10:38:04PM -0600, Robert Lee wrote:

> +static int arm_enter_idle(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv, int index)
> +{
> +	ktime_t time_start, time_end;
> +
> +	local_irq_disable();
> +	local_fiq_disable();

Apart from the IRQ disables this code isn't really ARM specific at all
and I bet it'd be useful on a lot of other architectures.

> +	time_start = ktime_get();

> +	index = mach_cpuidle(dev, drv, index);

Given the number of systems that at least start off with just a call to
cpu_do_idle() here shouldn't we have a defualt mach_cpu_idle() which
does that?  Currently the code requires the caller to provide one.

Please CC me on any iterations, I've got a S3C64xx implementation I'm
pushing which could probably use this.

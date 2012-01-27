From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 27 Jan 2012 06:59:03 +0000
Subject: [PATCH v1 3/3] ARM: tegra: cpuidle driver for tegra
In-Reply-To: <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
 <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D1214331791EA6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 21:52:03, Peter De Schrijver wrote:
[...]
> +static int tegra_idle_enter_lp3(struct cpuidle_device *dev,
> +	struct cpuidle_driver *drv, int index)
> +{
> +	ktime_t enter, exit;
> +	s64 us;
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
> +	enter = ktime_get();
> +
> +	tegra_cpu_wfi();
> +
> +	exit = ktime_sub(ktime_get(), enter);
> +	us = ktime_to_us(exit);
> +
> +	local_fiq_enable();
> +	local_irq_enable();
> +
> +	dev->last_residency = us;
> +
> +	return index;
> +}

You can probably drop local_irq_disable() and local_irq_enable().

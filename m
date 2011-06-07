From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 6 Jun 2011 17:33:39 -0700
Subject: [PATCH V2 1/3] drivers/pwm st_pwm: Add support for ST's Pulse
	Width Modulator
In-Reply-To: <af3d50b271b17e404d236e19196adfd4618e2501.1306831238.git.viresh.kumar@st.com>
References: <cover.1306831238.git.viresh.kumar@st.com>
	<af3d50b271b17e404d236e19196adfd4618e2501.1306831238.git.viresh.kumar@st.com>
Message-ID: <20110606173339.268b9f9c.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2011 14:21:51 +0530
Viresh Kumar <viresh.kumar@st.com> wrote:

> This patch adds support for ST Microelectronics Pulse Width Modulator. This is
> currently used by ST's SPEAr platform and tested on the same.
> 
> This patch also adds drivers/pwm directory as suggested by Arnd Bergmann in
> following discussion:
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/118651
> 
>
> ...
>
> +/**
> + * struct pwm_device: struct representing pwm device/channel
> + *
> + * pwmd_id: id of pwm device
> + * pwm: pointer to parent pwm ip
> + * label: used for storing label passed in pwm_request
> + * offset: base address offset from parent pwm mmio_base
> + * busy: represents usage status of a pwm device
> + * lock: lock specific to a pwm device

More specificity here would be helpful.  Precisely which data does the
lock protect?

> + * node: node for adding device to parent pwm's devices list
> + *
> + * Each pwm IP contains four independent pwm device/channels. Some or all of
> + * which may be present in our configuration.
> + */
> +struct pwm_device {
> +	unsigned pwmd_id;
> +	struct pwm *pwm;
> +	const char *label;
> +	unsigned offset;
> +	unsigned busy;
> +	spinlock_t lock;
> +	struct list_head node;
> +};
> +
> +/**
> + * struct pwm: struct representing pwm ip
> + *
> + * id: id of pwm ip
> + * mmio_base: base address of pwm
> + * clk: pointer to clk structure of pwm ip
> + * clk_enabled: clock enable status
> + * pdev: pointer to pdev structure of pwm
> + * lock: lock specific to current pwm ip

Ditto.

> + * devices: list of devices/childrens of pwm ip
> + * node: node for adding pwm to global list of all pwm ips
> + */
> +struct pwm {
> +	unsigned id;
> +	void __iomem *mmio_base;
> +	struct clk *clk;
> +	int clk_enabled;
> +	struct platform_device *pdev;
> +	spinlock_t lock;
> +	struct list_head devices;
> +	struct list_head node;
> +};
> +
> +/*
> + * period_ns = 10^9 * (PRESCALE + 1) * PV / PWM_CLK_RATE
> + * duty_ns = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
> + *
> + * PV = (PWM_CLK_RATE * period_ns)/ (10^9 * (PRESCALE + 1))
> + * DC = (PWM_CLK_RATE * duty_ns)/ (10^9 * (PRESCALE + 1))
> + */
> +int pwm_config(struct pwm_device *pwmd, int duty_ns, int period_ns)
> +{
> +	u64 val, div, clk_rate;
> +	unsigned long prescale = MIN_PRESCALE, pv, dc;
> +	int ret = 0;
> +
> +	if (!pwmd) {
> +		pr_err("pwm: config - NULL pwm device pointer\n");
> +		return -EFAULT;
> +	}
> +
> +	if (period_ns == 0 || duty_ns > period_ns) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* TODO: Need to optimize this loop */
> +	while (1) {
> +		div = 1000000000;
> +		div *= 1 + prescale;
> +		clk_rate = clk_get_rate(pwmd->pwm->clk);
> +		val = clk_rate * period_ns;
> +		pv = div64_u64(val, div);
> +		val = clk_rate * duty_ns;
> +		dc = div64_u64(val, div);
> +
> +		if ((pv == 0) || (dc == 0)) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		if ((pv > MAX_PERIOD) || (dc > MAX_DUTY)) {
> +			prescale++;
> +			if (prescale > MAX_PRESCALE) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +			continue;
> +		}
> +		if ((pv < MIN_PERIOD) || (dc < MIN_DUTY)) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		break;
> +	}

gee, is this some sort of puzzle?  So human-readable description of
what this code is doing would be an improvement.


> +	/*
> +	 * NOTE: the clock to PWM has to be enabled first
> +	 * before writing to the registers
> +	 */
> +	spin_lock(&pwmd->pwm->lock);
> +	ret = clk_enable(pwmd->pwm->clk);
> +	if (ret) {
> +		spin_unlock(&pwmd->pwm->lock);
> +		goto err;
> +	}
> +
> +	spin_lock(&pwmd->lock);
> +	writel(prescale << PRESCALE_SHIFT, pwmd->pwm->mmio_base +
> +			pwmd->offset + PWMCR);
> +	writel(dc, pwmd->pwm->mmio_base + pwmd->offset + PWMDCR);
> +	writel(pv, pwmd->pwm->mmio_base + pwmd->offset + PWMPCR);
> +	spin_unlock(&pwmd->lock);
> +	clk_disable(pwmd->pwm->clk);
> +	spin_unlock(&pwmd->pwm->lock);

The nesting rules for these two locks seems sensible and obvious, but I
guess documenting the rule wouldn't hurt.

> +	return 0;
> +err:
> +	dev_err(&pwmd->pwm->pdev->dev, "pwm config fail\n");
> +	return ret;
> +}
> +EXPORT_SYMBOL(pwm_config);
> +
>
> ...
>
> +static int __devinit st_pwm_probe(struct platform_device *pdev)

And here things get rather odd.

Most of this file is a generic, non-device specific PWM layer, exported
to other modules.  But then we get into driver bits which are specific
to one paritular type of device.  Confused - this is like putting the
e100 driver inside net/ipv4/tcp.c?

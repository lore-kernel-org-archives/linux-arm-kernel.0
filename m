From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 5 Aug 2011 09:01:50 +0900
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <1312498820-2275-2-git-send-email-swarren@nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
Message-ID: <20110805000148.GB13321@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 05:00:18PM -0600, Stephen Warren wrote:

> +	} else {
> +		gpio = irq_to_gpio(irq);
> +		if (gpio_is_valid(gpio)) {
> +			ret = gpio_request(gpio, new->name);
> +			if (ret < 0)
> +				goto out_mask;
> +			ret = gpio_direction_input(gpio);
> +			if (ret < 0)
> +				goto out_mask;
> +		}

If you treat failures as an error what happens when a driver is using a
GPIO as both an interrupt and a GPIO?  For example a driver which
monitors the level on a GPIO and uses edge triggered IRQs to be notified
of state changes.

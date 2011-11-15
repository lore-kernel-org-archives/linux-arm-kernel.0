From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Nov 2011 13:16:37 +0000
Subject: [RFC][PATCH] gpiolib: add irq_wake (power-management) sysfs file
In-Reply-To: <1321004406-15663-1-git-send-email-p-combes@ti.com>
References: <1321004406-15663-1-git-send-email-p-combes@ti.com>
Message-ID: <20111115131636.GA31028@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 10:40:06AM +0100, Patrick Combes wrote:

> By calling poll() on the /sys/class/gpio/gpioN/value sysfs file, usermode
> application can take benefit of gpio interrupts.
> However, depending on the power state reached, this interrupt may not wake-up
> the CPU.
> This patch creates a new sysfs file /sys/class/gpio/gpioN/irq_wake to enable
> usermode application to set the wake properties of a gpio IRQ.
> This option can be set or not for each gpio to preserve power consumption (e.g
> embedded systems).

There's already device global control for this in sysfs via the power
framework - 

Also...

> +	else if (sysfs_streq(buf, "enable") || sysfs_streq(buf, "1"))
> +		status = enable_irq_wake(gpio_to_irq(gpio));
> +	else if (sysfs_streq(buf, "disable") || sysfs_streq(buf, "0"))
> +		status = disable_irq_wake(gpio_to_irq(gpio));
> +	else
> +		status = -EINVAL;

...this doesn't do anything to stop userspace doing multiple enables and
disables.

> +	if (gpio_irq_data)
> +		status = sprintf(buf, " Wakeup %s\n",
> +					irqd_is_wakeup_set(gpio_irq_data)
> +					? " enable" : "disable");

This is *really* non-idiomatic for sysfs output, you'd expect the sysfs
output to look like the input.  It's supposed to machine parsable...

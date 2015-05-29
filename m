From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 29 May 2015 12:25:01 +0300
Subject: [PATCH v0] gpio: xgene: add ACPI support for APM X-Gene GPIO
 standby driver
In-Reply-To: <1432795588-17476-1-git-send-email-yvo@apm.com>
References: <1432795588-17476-1-git-send-email-yvo@apm.com>
Message-ID: <20150529092501.GI1747@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 01:46:28PM +0700, Y Vo wrote:
> +#ifdef CONFIG_ACPI
> +	if (priv->nirq > 0) {
> +		/* Register interrupt handlers for gpio signaled acpi events */
> +		acpi_gpiochip_request_interrupts(&priv->bgc.gc);
> +	}
> +#endif

You don't need to check CONFIG_ACPI as acpi_gpiochip_request_interrupts()
will be stubbed out if !CONFIG_ACPI.

Should you call acpi_gpiochip_free_interrupts() somewhere to unregister
the interrupts as well?

Even better if you can switch your driver to use GPIOLIB_IRQCHIP all
this is done automatically for you.

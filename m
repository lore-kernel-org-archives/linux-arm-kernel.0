From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jan 2016 13:36:46 +0000
Subject: [PATCH v4 1/3] ACPI: amba bus probing support
In-Reply-To: <1450880383-29560-2-git-send-email-aleksey.makarov@linaro.org>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
 <1450880383-29560-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <20160103133645.GC5779@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 05:19:40PM +0300, Aleksey Makarov wrote:
> +	dev = amba_device_alloc(NULL, 0, 0);
> +	if (!dev) {
> +		dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
...
> +	/*
> +	 * If the ACPI node has a parent and that parent has a physical device
> +	 * attached to it, that physical device should be the parent of the
> +	 * platform device we are about to create.
> +	 */
> +	dev->dev.parent = NULL;

No need to initialise this; amba_device_alloc() uses kzalloc(), and so
dev->dev.parent will already be NULL.

...
> +	dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));

Is there a reason not to use:

	dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);

above?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

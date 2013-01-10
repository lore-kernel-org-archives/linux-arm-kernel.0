From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Jan 2013 10:57:10 +0000
Subject: [PATCH] gpio: vt8500: memory cleanup missing
In-Reply-To: <1357163240-23131-1-git-send-email-linux@prisktech.co.nz>
References: <1357163240-23131-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130110105710.GA19944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 10:47:20AM +1300, Tony Prisk wrote:
> There is also no .remove callback defined. To allow removing the
> registered chips, I have moved *vtchip to be a static global.

What?  Why?

> +/* Pointer to our array of chips */
> +static struct vt8500_gpio_chip *vtchip;
> +
...
> +static int vt8500_gpio_remove(struct platform_device *pdev)
> +{
> +	int i;
> +	int ret;
> +	const struct vt8500_gpio_data *data;
> +	void __iomem *gpio_base = vtchip[0].base;
> +	const struct of_device_id *of_id =
> +				of_match_device(vt8500_gpio_dt_ids, &pdev->dev);
> +

You can get at the vtchip pointer if you put it into the platform device's
driver data pointer.  That way, you're not artificially limiting this
driver to just one device, and, with your changes it will go wrong if DT
ever lists more than one device.

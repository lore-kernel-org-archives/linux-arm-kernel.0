From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Dec 2016 12:09:05 +0000
Subject: [PATCH 05/16] drivers/fsi: Add fake master driver
In-Reply-To: <1481069677-53660-6-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481069677-53660-6-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <20161207120905.GD7054@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 06:14:26PM -0600, Chris Bostic wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> 
> For debugging, add a fake master driver, that only supports reads,
> returning a fixed set of data.

> +config FSI_MASTER_FAKE
> +	tristate "Fake FSI master"
> +	depends on FSI
> +	---help---
> +	This option enables a fake FSI master driver for debugging.
> +endif

> +static const struct of_device_id fsi_master_fake_match[] = {
> +	{ .compatible = "ibm,fsi-master-fake" },
> +	{ },
> +};

NAK.

DT should be treated as an ABI, and should describe the HW explicitly.
This makes no sense. This is also missing a binding document.

Have your module take a module parameter allowing you to bind it to
arbitrary devices, or do something like what PCI does where you can
bind/unbind arbitrary drivers to devices using sysfs.

> +
> +static struct platform_driver fsi_master_fake_driver = {
> +	.driver = {
> +		.name		= "fsi-master-fake",
> +		.of_match_table	= fsi_master_fake_match,
> +	},
> +	.probe	= fsi_master_fake_probe,
> +};
> +
> +static int __init fsi_master_fake_init(void)
> +{
> +	struct device_node *np;
> +
> +	platform_driver_register(&fsi_master_fake_driver);
> +
> +	for_each_compatible_node(np, NULL, "ibm,fsi-master-fake")
> +		of_platform_device_create(np, NULL, NULL);

As a general note, please use for_each_matching_node in situations like
this. That way you can reuse your existing of_device_id table, and not
reproduce the string.

That said, this is not necessary. The platform driver has an
of_match_table, so presumes the parent bus registers children, and hence
they should already have platform devices.

Thanks,
Mark.

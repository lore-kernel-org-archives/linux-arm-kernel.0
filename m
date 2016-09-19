From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 19 Sep 2016 13:08:26 -0500
Subject: find_child_device() on ACPI node works only once
Message-ID: <57E0299A.6000408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I need help getting my ACPI table parsing code to work correctly.  My 
driver fails to find the child device in a node when the driver is 
unloaded and reloaded.  I suspect that I'm not freeing a resource correctly.

Here is my ACPI table (trimmed):

Device (MAC0) {
	Name (_HID, "QCOM8070")
	Name (_UID, 0)
	Method (_CRS, 0x0, Serialized) {
		Name (RBUF, ResourceTemplate() {
			...
			Return (RBUF)
		}
	}
	Device (IPHY) {
		Name (_HID, "QCOM8071")

		Method (_CRS, 0x0, Serialized) {
			Name (RBUF, ResourceTemplate () {
				...
			Return (RBUF)
		}
	}


So QCOM8071 is a child device for QCOM8070.  The driver probes on 
QCOM8070 and then manually instantiates QCOM8071.

static const struct acpi_device_id emac_acpi_match[] = {
	{
		.id = "QCOM8070",
	},
	{}
};
MODULE_DEVICE_TABLE(acpi, emac_acpi_match);

static struct platform_driver emac_platform_driver = {
	.probe	= emac_probe,
	.remove	= emac_remove,
	.driver = {
		.name		= "qcom-emac",
		.acpi_match_table = ACPI_PTR(emac_acpi_match),
	},
};

In emac_probe, I do this:

struct device *dev;

dev = device_find_child(&pdev->dev, NULL, emac_sgmii_acpi_match);
adpt->sgmii_pdev = to_platform_device(dev);

And here's emac_sgmii_acpi_match:

> static int emac_sgmii_acpi_match(struct device *dev, void *data)
> {
> 	static const struct acpi_device_id match_table[] = {
> 		{
> 			.id = "QCOM8071",
> 		},
> 		{}
> 	};
> 	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
>
> 	return !!id;
> }

When my driver exits, I call

	platform_device_unregister(adpt->sgmii_pdev);

So here's the problem: the second time my driver is loaded, 
emac_sgmii_acpi_match() always returns false.  The QCOM8071 child node 
no longer exists.  It's apparently hidden in some way.

I've been trying for several days to debug this, and I'm at my wits' 
end.  I'm assuming that I'm not freeing the resource properly, but other 
than calling platform_device_unregister(), what else should I do?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Apr 2015 19:58:41 -0600
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1430176449-12322-3-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
Message-ID: <55403AD1.4030103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2015 05:14 PM, Eric Anholt wrote:
> This gives us a function for making mailbox property channel requests
> of the firmware, and uses it to control the 3 power domains provided
> by the firmware.

> diff --git a/arch/arm/mach-bcm/raspberrypi-firmware.c b/arch/arm/mach-bcm/raspberrypi-firmware.c

> +/*
> + * Submits a set of concatenated tags to the VPU firmware through the
> + * mailbox property interface.
> + *
> + * The buffer header and the ending tag are added by this function and
> + * don't need to be supplied, just the actual tags for your operation.
> + * See struct raspberrypi_firmware_property_tag_header for the per-tag structure.
> + */
> +int raspberrypi_firmware_property(void *data, size_t tag_size)
> +{
> +	size_t size = tag_size + 12;
> +	u32 *buf;
> +	dma_addr_t bus_addr;
> +	int ret = 0;
> +
> +	if (!firmware)
> +		return -EPROBE_DEFER;

I think it'd make more sense if the clients looked up the firmware
driver via phandle at their probe time. This would mean:

* No need for global "firmware", since clients could pass the firmware
driver handle into this function.

* Clients resolve deferred probe at their probe time. That way, they
won't register themselves with subsystems asserting they can provide
services, but find out they can't yet provide the service at that time.

> +static int raspberrypi_firmware_probe(struct platform_device *pdev)

BTW if you wanted, a s/raspberrypi/rpi/ in all symbols and filenames
seems reasonable. I'm not really bothered either way.

> +{

> +	firmware->chan = mbox_request_channel(&firmware->cl, 0);
> +	if (IS_ERR(firmware->chan)) {
> +		ret = PTR_ERR(firmware->chan);
> +		/* An -EBUSY from the core means it couldn't find our
> +		 * channel, because the mailbox driver hadn't
> +		 * registered yet.
> +		 */
> +		if (ret == -EBUSY)
> +			ret = -EPROBE_DEFER;
> +		else
> +			dev_err(dev, "Failed to get mbox channel: %d\n", ret);

I would have hoped that mbox_request_channel() returned -EPROBE_DEFER
itself. It really should...

> +static int raspberrypi_firmware_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	of_genpd_del_provider(dev->of_node);
> +	mbox_free_channel(firmware->chan);

firmware = NULL; ?

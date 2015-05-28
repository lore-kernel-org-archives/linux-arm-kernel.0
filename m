From: lee@kernel.org (Lee Jones)
Date: Thu, 28 May 2015 12:45:01 +0100
Subject: [PATCH 2/3 v2] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <20150528112610.GO11677@x1>
References: <1431543609-19646-1-git-send-email-eric@anholt.net>
 <1431543609-19646-3-git-send-email-eric@anholt.net>
 <20150528112610.GO11677@x1>
Message-ID: <20150528114500.GP11677@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few nits, nothing major.

> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: Drop power-domains stuff for now since we don't have the driver
>     core support to make it useful.  Move to drivers/firmware/.
>     Capitalize the enums.  De-global the firmware variable.  Use the
>     firmware device to allocate our DMA buffer, so that the dma-ranges
>     DT property gets respected.  Simplify the property tag transaction
>     interface even more, leaving a multi-tag interface still
>     available.  For conciseness, rename "raspberrypi" to "rpi" on all
>     functions/enums/structs, and the "firmware" variable to "fw".
>     Print when the driver is probed successfully, since debugging
>     -EPROBE_DEFER handling is such a big part of bcm2835 development.
>     Drop -EBUSY mailbox handling since the mailbox core has been fixed
>     to return -EPROBE_DEFER in -next.
> 
> Note that I don't think I've done what srwarren wanted for
> -EPROBE_DEFER, because I'm not clear what he wants.  I think he might
> just be asking for a function that does:
> 
> /*
>  * Returns 0 if the firmware device is probed and available, otherwise
>  * -EPROBE_DEFER.
>  */
> int rpi_firmware_get(struct device_node *firmware_node)
> {
> 	struct platform_device *pdev = of_find_device_by_node(of_node);
> 	if (!platform_get_drvdata(pdev))
> 		return -EPROBE_DEFER;
> 	return 0;
> }
> EXPORT_SYMBOL(rpi_firmware_get)
> 
> If that's all, I'm happy to add it.
> 
> Note that a client could currently do this:
> 
> 	ret = rpi_firmware_property_list(firmware_node, NULL, 0);
> 
> in exchange for a bit of overhead in the case that it's actually probed already.
> 
> 
>  drivers/firmware/Makefile                          |   1 +
>  drivers/firmware/raspberrypi.c                     | 224 +++++++++++++++++++++
>  .../soc/bcm2835/raspberrypi-firmware-property.h    | 114 +++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 drivers/firmware/raspberrypi.c
>  create mode 100644 include/soc/bcm2835/raspberrypi-firmware-property.h
> 
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 3fdd391..41ced28 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
>  obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
>  obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o
>  CFLAGS_qcom_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
> +obj-$(CONFIG_BCM2835_MBOX)	+= raspberrypi.o
>  
>  obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
>  obj-$(CONFIG_EFI)		+= efi/
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> new file mode 100644
> index 0000000..61bde1b
> --- /dev/null
> +++ b/drivers/firmware/raspberrypi.c
> @@ -0,0 +1,224 @@
> +/*
> + *  Copyright ? 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * Defines interfaces for interacting wtih the Raspberry Pi firmware's
> + * property channel.
> + */

No need to separate this from the header comment above.

> +#include <linux/dma-mapping.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <soc/bcm2835/raspberrypi-firmware-property.h>
> +
> +#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
> +#define MBOX_CHAN(msg)			((msg) & 0xf)
> +#define MBOX_DATA28(msg)		((msg) & ~0xf)
> +#define MBOX_CHAN_PROPERTY		8
> +
> +struct rpi_firmware {
> +	struct mbox_client cl;
> +	struct mbox_chan *chan; /* The property channel. */
> +	struct completion c;
> +	u32 enabled;
> +};
> +
> +static DEFINE_MUTEX(transaction_lock);
> +
> +static void response_callback(struct mbox_client *cl, void *msg)
> +{
> +	struct rpi_firmware *fw = container_of(cl, struct rpi_firmware, cl);
> +	complete(&fw->c);
> +}
> +
> +/*
> + * Sends a request to the firmware through the BCM2835 mailbox driver,
> + * and synchronously waits for the reply.
> + */
> +static int
> +rpi_firmware_transaction(struct rpi_firmware *fw, u32 chan, u32 data)
> +{
> +	u32 message = MBOX_MSG(chan, data);
> +	int ret;
> +
> +	WARN_ON(data & 0xf);
> +
> +	mutex_lock(&transaction_lock);
> +	reinit_completion(&fw->c);
> +	ret = mbox_send_message(fw->chan, &message);
> +	if (ret >= 0) {
> +		wait_for_completion(&fw->c);
> +		ret = 0;
> +	} else {
> +		dev_err(fw->cl.dev, "mbox_send_message returned %d\n", ret);
> +	}
> +	mutex_unlock(&transaction_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Submits a set of concatenated tags to the VPU firmware through the
> + * mailbox property interface.
> + *
> + * The buffer header and the ending tag are added by this function and
> + * don't need to be supplied, just the actual tags for your operation.
> + * See struct rpi_firmware_property_tag_header for the per-tag
> + * structure.
> + */
> +int rpi_firmware_property_list(struct device_node *of_node,
> +			       void *data, size_t tag_size)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(of_node);
> +	struct rpi_firmware *fw = platform_get_drvdata(pdev);
> +	size_t size = tag_size + 12;
> +	u32 *buf;
> +	dma_addr_t bus_addr;
> +	int ret = 0;

No need to re-initialise.

> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	/* Packets are processed a dword at a time. */
> +	if (size & 3)
> +		return -EINVAL;
> +
> +	buf = dma_alloc_coherent(fw->cl.dev, PAGE_ALIGN(size), &bus_addr,
> +				 GFP_ATOMIC);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	/* The firmware will error out without parsing in this case. */
> +	WARN_ON(size >= 1024 * 1024);
> +
> +	buf[0] = size;
> +	buf[1] = RPI_FIRMWARE_STATUS_REQUEST;
> +	memcpy(&buf[2], data, tag_size);
> +	buf[size / 4 - 1] = RPI_FIRMWARE_PROPERTY_END;
> +	wmb();
> +
> +	ret = rpi_firmware_transaction(fw, MBOX_CHAN_PROPERTY, bus_addr);
> +
> +	rmb();
> +	memcpy(data, &buf[2], tag_size);
> +	if (ret == 0 && buf[1] != RPI_FIRMWARE_STATUS_SUCCESS) {
> +		/*
> +		 * The tag name here might not be the one causing the
> +		 * error, if there were multiple tags in the request.
> +		 * But single-tag is the most common, so go with it.
> +		 */
> +		dev_err(fw->cl.dev, "Request 0x%08x returned status 0x%08x\n",
> +			buf[2], buf[1]);
> +		ret = -EINVAL;
> +	}
> +
> +	dma_free_coherent(NULL, PAGE_ALIGN(size), buf, bus_addr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_property_list);
> +
> +/*
> + * Submits a single tag to the VPU firmware through the mailbox
> + * property interface.
> + *
> + * This is a convenience wrapper around
> + * rpi_firmware_property_list() to avoid some of the
> + * boilerplate in property calls.
> + */
> +int rpi_firmware_property(struct device_node *of_node,
> +			  u32 tag, void *tag_data, size_t buf_size)
> +{
> +	/* Single tags are very small (generally 8 bytes), so the
> +	 * stack should be safe.
> +	 */
> +	u8 data[buf_size + sizeof(struct rpi_firmware_property_tag_header)];
> +	struct rpi_firmware_property_tag_header *header =
> +		(struct rpi_firmware_property_tag_header *)data;
> +	int ret;
> +
> +	header->tag = tag;
> +	header->buf_size = buf_size;
> +	header->req_resp_size = 0;
> +	memcpy(data + sizeof(struct rpi_firmware_property_tag_header),
> +	       tag_data, buf_size);
> +
> +	ret = rpi_firmware_property_list(of_node, &data, sizeof(data));
> +	memcpy(tag_data,
> +	       data + sizeof(struct rpi_firmware_property_tag_header),
> +	       buf_size);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_property);
> +
> +static int rpi_firmware_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret = 0;
> +	struct rpi_firmware *fw;
> +
> +	fw = devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
> +	if (!fw)
> +		return -ENOMEM;
> +
> +	fw->cl.dev = dev;
> +	fw->cl.rx_callback = response_callback;
> +	fw->cl.tx_block = true;
> +
> +	fw->chan = mbox_request_channel(&fw->cl, 0);
> +	if (IS_ERR(fw->chan)) {
> +		ret = PTR_ERR(fw->chan);
> +		/* An -EBUSY from the core means it couldn't find our
> +		 * channel, because the mailbox driver hadn't
> +		 * registered yet.
> +		 */
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
> +		return ret;
> +	}
> +
> +	init_completion(&fw->c);
> +
> +	dev_info(dev, "Firmware driver\n");

We don't normally print unless data (such as version/revision number)
has been acquired from the h/w.

> +	platform_set_drvdata(pdev, fw);
> +
> +	return 0;
> +}
> +
> +static int rpi_firmware_remove(struct platform_device *pdev)
> +{
> +	struct rpi_firmware *fw = platform_get_drvdata(pdev);
> +
> +	mbox_free_channel(fw->chan);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rpi_firmware_of_match[] = {
> +	{ .compatible = "raspberrypi,firmware", },

"firmware" sounds very generic.  Is there any other information you
can use to make it more specific, in order to future-proof the
addition of new incarnations?  I'm thinking "bcm2835-firmware" for
instance.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rpi_firmware_of_match);
> +
> +static struct platform_driver rpi_firmware_driver = {
> +	.driver = {
> +		.name = "raspberrypi-firmware",
> +		.owner = THIS_MODULE,

Remove this, it's taken care of elsewhere.

> +		.of_match_table = rpi_firmware_of_match,
> +	},
> +	.probe		= rpi_firmware_probe,
> +	.remove		= rpi_firmware_remove,
> +};
> +module_platform_driver(rpi_firmware_driver);
> +
> +MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
> +MODULE_DESCRIPTION("Raspberry Pi firmware driver");
> +MODULE_LICENSE("GPL v2");

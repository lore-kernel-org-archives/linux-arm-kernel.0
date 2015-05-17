From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Sun, 17 May 2015 19:30:06 +0200
Subject: [PATCH 2/3 v2] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1431543609-19646-3-git-send-email-eric@anholt.net>
References: <1431543609-19646-1-git-send-email-eric@anholt.net>
 <1431543609-19646-3-git-send-email-eric@anholt.net>
Message-ID: <5558D01E.2070809@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 13.05.2015 21:00, skrev Eric Anholt:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> v2: Drop power-domains stuff for now since we don't have the driver
>      core support to make it useful.  Move to drivers/firmware/.
>      Capitalize the enums.  De-global the firmware variable.  Use the
>      firmware device to allocate our DMA buffer, so that the dma-ranges
>      DT property gets respected.  Simplify the property tag transaction
>      interface even more, leaving a multi-tag interface still
>      available.  For conciseness, rename "raspberrypi" to "rpi" on all
>      functions/enums/structs, and the "firmware" variable to "fw".
>      Print when the driver is probed successfully, since debugging
>      -EPROBE_DEFER handling is such a big part of bcm2835 development.
>      Drop -EBUSY mailbox handling since the mailbox core has been fixed
>      to return -EPROBE_DEFER in -next.
>
> Note that I don't think I've done what srwarren wanted for
> -EPROBE_DEFER, because I'm not clear what he wants.  I think he might
> just be asking for a function that does:
>
> /*
>   * Returns 0 if the firmware device is probed and available, otherwise
>   * -EPROBE_DEFER.
>   */
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
[...]
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
[...]
> +int rpi_firmware_property_list(struct device_node *of_node,
> +			       void *data, size_t tag_size)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(of_node);
> +	struct rpi_firmware *fw = platform_get_drvdata(pdev);
> +	size_t size = tag_size + 12;
> +	u32 *buf;
> +	dma_addr_t bus_addr;
> +	int ret = 0;
> +
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	/* Packets are processed a dword at a time. */
> +	if (size & 3)
> +		return -EINVAL;
> +
> +	buf = dma_alloc_coherent(fw->cl.dev, PAGE_ALIGN(size), &bus_addr,
[...]
> +	dma_free_coherent(NULL, PAGE_ALIGN(size), buf, bus_addr);

Should probably pass the device when freeing as well.

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

Definition of ret can be move here.

> +		ret = PTR_ERR(fw->chan);
> +		/* An -EBUSY from the core means it couldn't find our
> +		 * channel, because the mailbox driver hadn't
> +		 * registered yet.
> +		 */

You forgot to remove this comment.

> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
> +		return ret;
> +	}

Why not turn the comments into kernel-doc comments:
(Thunderbird converts my tabs into spaces, sorry about that)

/**
  * struct rpi_firmware_property_tag_header - Firmware property tag header
  * @tag:        One of enum_mbox_property_tag.
  * @buf_size:   The number of bytes in the value buffer following this 
struct.
  * @req_resp_size: On submit, the length of the request (though it doesn't
  *                 appear to be currently used by the firmware).  On 
return,
  *                 the length of the response (always 4 byte aligned), with
  *                 the low bit set.
  */
struct rpi_firmware_property_tag_header {
         u32 tag;
         u32 buf_size;
         u32 req_resp_size;
};


/**
  * rpi_firmware_property_list - Submit firmware property list
  * @of_node:    Pointer to the firmware Device Tree node.
  * @data:       Buffer holding tags.
  * @tag_size:   Size of tags buffer.
  *
  * Submits a set of concatenated tags to the VPU firmware through the
  * mailbox property interface.
  *
  * The buffer header and the ending tag are added by this function and
  * don't need to be supplied, just the actual tags for your operation.
  * See struct rpi_firmware_property_tag_header for the per-tag
  * structure.
  */
int rpi_firmware_property_list(struct device_node *of_node,
                                void *data, size_t tag_size)


/**
  * rpi_firmware_property - Submit single firmware property
  * @of_node:    Pointer to the firmware Device Tree node.
  * @tag:        One of enum_mbox_property_tag.
  * @tag_data:   Tag data buffer.
  * @buf_size:   Buffer size.
  *
  * Submits a single tag to the VPU firmware through the mailbox
  * property interface.
  *
  * This is a convenience wrapper around
  * rpi_firmware_property_list() to avoid some of the
  * boilerplate in property calls.
  */
int rpi_firmware_property(struct device_node *of_node,
                           u32 tag, void *tag_data, size_t buf_size)

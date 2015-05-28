From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 15:28:15 -0600
Subject: [PATCH 2/3 v4] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1432837987-22861-1-git-send-email-eric@anholt.net>
References: <20150528114500.GP11677@x1>
 <1432837987-22861-1-git-send-email-eric@anholt.net>
Message-ID: <5567886F.5080108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 12:33 PM, Eric Anholt wrote:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.

This thread was rather hard to follow since updated versions of patches
were sent "in response" to the original posting rather than as a new
thread. Generally it's best to post a complete copy of each new version
of the series, and as a completely standalone thread.

> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile

> +obj-$(CONFIG_BCM2835_MBOX)	+= raspberrypi.o

I think this warrants its own Kconfig option that depends on _MBOX.

> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c

> +int rpi_firmware_property_list(struct device_node *of_node,
> +			       void *data, size_t tag_size)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(of_node);

I would expect the of_node -> pdev mapping to happen at client device
probe time. Simplest for this driver would be if the
client-probe-time-mapping function returned the "struct rpi_firmware"
and the client passed that to this function.

> +	struct rpi_firmware *fw = platform_get_drvdata(pdev);
> +	size_t size = tag_size + 12;
> +	u32 *buf;
> +	dma_addr_t bus_addr;
> +	int ret;
> +
> +	if (!fw)
> +		return -EPROBE_DEFER;

That return code should only be used in functions called at probe time.
While I do see the expectation is that clients call this function once
at probe time and hence guarantee to see -EPROBE_DEFER at probe time (if
at all), it's rather odd for a function that's intended to be called at
times other that probe() to ever have the possibility of returning
-EPROBE_DEFER. If somehow that values gets returned at another time,
it's going to be rather confusing to the client.

> +	buf[0] = size;
> +	buf[1] = RPI_FIRMWARE_STATUS_REQUEST;
> +	memcpy(&buf[2], data, tag_size);
> +	buf[size / 4 - 1] = RPI_FIRMWARE_PROPERTY_END;

Out of curiosity, why not require the client to format the entire
message itself? In theory at least, the client could submit a whole
"string" of tags at once, so it really seems like the client should be
constructing the whole message.

Still, this is something that's easy to modify later without affecting
much (and in particular, has zero impact on DT), so feel free to ignore
this for now.

...
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

If this driver were solely a transport, and required the client driver
to construct the whole message and parse the whole response, the gotcha
that's documented above would be solved; the client would know exactly
which set of tags to look at for errors.

Alternatively, iterating over all the tags is quite simple, since each
one has a size field and there's a sentinel tag at the end. That
enhancement could also be added later though.

> +rpi_firmware_print_firmware_revision(struct device *dev)
> +{
> +	u32 packet;
> +	int ret = rpi_firmware_property(dev->of_node,
> +					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
> +					&packet, sizeof(packet));
...
> +		time_to_tm(packet, 0, &tm);

Oh, the revision value is a time? Is so, it'd be nice if the
documentation could be updated to state this:

https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

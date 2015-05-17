From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Sun, 17 May 2015 20:26:08 +0200
Subject: [PATCH 2/3 v2] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1431543609-19646-3-git-send-email-eric@anholt.net>
References: <1431543609-19646-1-git-send-email-eric@anholt.net>
 <1431543609-19646-3-git-send-email-eric@anholt.net>
Message-ID: <5558DD40.4070701@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 13.05.2015 21:00, skrev Eric Anholt:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

[...]

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

To use the firmware property functions, I need a DT node pointer.
Since Device Tree is dynamic now, should I fetch the firmware node
each time, or should I do that in probe and store the node pointer?

Device Tree:
         firmware: firmware {
             compatible = "raspberrypi,firmware";
         };

         thermal {
             compatible = "brcm,bcm2835-thermal";
             firmware = <&firmware>;
         };

Rewritten (not tested) function from downstream bcm2835-thermal driver:

static int bcm2835_get_temp_or_max(struct thermal_zone_device *thermal_dev,
                                    unsigned long *temp, unsigned tag_id)
{
     struct device *dev = <get device somehow>;
     struct device_node *np;
     struct {
         u32 id;
         u32 val;
     } tag_buf;

     np = of_parse_phandle(dev->of_node, "firmware", 0);
     if (!np)
         return -EINVAL;

     ret = rpi_firmware_property(np, tag_id, &tag_buf, sizeof(tag_buf));
     if (ret)
         return ret;

     *temp = val;

     return 0;
}

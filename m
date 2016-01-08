From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 09:22:22 +0100
Subject: [RFC PATCH 1/2] USB: core: let USB device know device node
In-Reply-To: <1452231864-11171-2-git-send-email-peter.chen@freescale.com>
References: <1452231864-11171-1-git-send-email-peter.chen@freescale.com>
 <1452231864-11171-2-git-send-email-peter.chen@freescale.com>
Message-ID: <11330516.E3pzCBVn95@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 13:44:23 Peter Chen wrote:
> +struct device_node *usb_of_find_node(struct device_node *parent, int portnum)
> +{
> +       struct device_node *node;
> +       u32 port;
> +
> +       for_each_child_of_node(parent, node) {
> +               if (!of_property_read_u32(node, "reg", &port)) {
> +                       if (port == portnum)
> +                               return node;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(usb_of_find_node);

The implementation looks good to me, but I find the function name slightly
confusing. We use "*find_node" or similar names in other subsystems to
scan the entire tree, when this one just looks at the immediate children
of the device.

Maybe something like "usb_of_get_child_node()" instead?

	Arnd

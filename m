From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jun 2014 10:39:32 +0200
Subject: [PATCH 6/6] mailbox/omap: add a custom of_xlate function
In-Reply-To: <1403660878-56350-7-git-send-email-s-anna@ti.com>
References: <1403660878-56350-1-git-send-email-s-anna@ti.com>
 <1403660878-56350-7-git-send-email-s-anna@ti.com>
Message-ID: <5721425.bMLltMQDlc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 20:47:58 Suman Anna wrote:
> +static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
> +                                           const struct of_phandle_args *sp)
> +{
> +       phandle phandle = sp->args[0];
> +       struct device_node *node;
> +       struct omap_mbox_device *mdev;
> +       struct omap_mbox *mbox;
> +
> +       node = of_find_node_by_phandle(phandle);
> +       if (!node) {
> +               pr_err("could not find node phandle 0x%x\n", phandle);
> +               return NULL;
> +       }
> +
> +       mdev = container_of(controller, struct omap_mbox_device, controller);
> +       if (WARN_ON(!mdev))
> +               return NULL;
> +
> +       mbox = omap_mbox_device_find(mdev, node->name);
> +       return mbox ? mbox->chan : NULL;
> 

Wouldn't it be easier to change the omap_mbox_device_find() function to
take a phandle argument directly? You shouldn't have to walk all
nodes in the system, or match it by name if you already have the 
device node.

Also, the xlate function is normally the place where you read out
the other arguments and set them as members in your omap_mbox
structure.

	Arnd

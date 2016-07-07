From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 07 Jul 2016 15:56:51 -0700
Subject: [PATCH 5/6] usb: chipidea: host: let the hcd know's parent device
 node
In-Reply-To: <1467882892-27589-6-git-send-email-peter.chen@nxp.com>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-6-git-send-email-peter.chen@nxp.com>
Message-ID: <146793221122.31330.7571458363004882365@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-07-07 02:14:51)
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index 053bac9..55120ef 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -109,15 +109,25 @@ static int host_start(struct ci_hdrc *ci)
>         struct ehci_hcd *ehci;
>         struct ehci_ci_priv *priv;
>         int ret;
> +       struct device *dev = ci->dev;
>  
> -       if (usb_disabled())
> +       if (usb_disabled() || !dev)

Does that ever happen?

>                 return -ENODEV;
>  
> -       hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> +       /*
> +        * USB Core will try to get child node under roothub,
> +        * but chipidea core has no of_node, and the child node
> +        * for controller is located at glue layer's node which
> +        * is chipidea core's parent.
> +        */
> +       if (dev->parent && dev->parent->of_node)
> +               dev->of_node = dev->parent->of_node;

Why not do this during the ci device probe? How is host special for
having an of_node for the child device.

Doing that would also make my ULPI bus DT discovery patch simpler
because we wouldn't have to search the parent of the parent for a DT
node to find the ULPI node that's a child of the ci glue device.

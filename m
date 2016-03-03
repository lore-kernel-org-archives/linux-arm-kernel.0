From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 3 Mar 2016 13:31:56 -0500 (EST)
Subject: [PATCH 1/3] usb: core: add power sequence for USB devices
In-Reply-To: <1456999276-6315-2-git-send-email-peter.chen@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1603031326310.1380-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Mar 2016, Peter Chen wrote:

> Some hard-wired USB devices need to do power sequence to let the
> device work normally, the typical power sequence like: enable USB
> PHY clock, toggle reset pin, etc. But current Linux USB driver
> lacks of such code to do it, it may cause some hard-wired USB devices
> works abnormal or can't be recognized by controller at all.
> 
> In this patch, it will do power on sequence at hub's probe for all
> devices under this hub (includes root hub) if this device is described
> at dts and there is a phandle "usb-pwrseq" for it. At hub_disconnect,
> it will do power off sequence.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>


> +static int hub_of_pwrseq(struct usb_device *hdev, bool on)
> +{
> +	struct device *parent;
> +	struct device_node *node;
> +	int ret = 0;
> +
> +	if (hdev->parent)
> +		parent = &hdev->dev;
> +	else
> +		parent = bus_to_hcd(hdev->bus)->self.controller;
> +
> +	for_each_child_of_node(parent->of_node, node) {
> +		ret = on ? usb_child_pwrseq_on(node)
> +			: usb_child_pwrseq_off(node);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

If you get a failure, do you want to leave the power to all the
preceding devices turned on?  It seems to me you should either turn all 
of them back off, or else continue trying to turn on power for the 
remaining children.

Alan Stern

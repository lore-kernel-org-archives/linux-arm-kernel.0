From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 30 Apr 2012 08:13:05 +0200
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <1335738860-26623-9-git-send-email-marex@denx.de>
References: <1335738860-26623-1-git-send-email-marex@denx.de>
 <1335738860-26623-9-git-send-email-marex@denx.de>
Message-ID: <20382.11633.123788.260827@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marek Vasut writes:
> This driver handles claiming of clocks and memory areas. These are later
> properly delegated to it's child devices, the USB Host (ehci-mxs) and
> USB Gadget (ci13xxx-mxs).
> 
[...]

There is a conceptual bug in the following code. Did you ever run it?

> +	INIT_WORK(&priv->work, imx_otg_work);
> +
[...]
> +	if (pdata->gadget_mode) {
> +		data->pdev_gadget = add_platform_device("ci13xxx-mxs", -1,
> +							data, sizeof(*data),
> +							DMA_BIT_MASK(32));
This will blow up due to 'BUG_ON(!list_empty(&work->entry));'
in kernel/workqueue.c when schedule_work() is called in
imx_otg_set_host() or imx_otg_set_peripheral().

platform_add_data() (called from add_platform_device()) will make a
copy of the data structure which contains the initialized work queue.
INIT_WORK() will have initialized a list_head embedded in the work
queue (making 'next' and 'prev' member pointing to the list_head
itself).
The copied list_head will thus have its members pointing to the
original data structure rather than the respective copies and thus
fail the 'list_empty()' check.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

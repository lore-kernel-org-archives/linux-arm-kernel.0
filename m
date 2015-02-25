From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Feb 2015 10:32:04 -0600
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <54EDCE04.3040404@linaro.org>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
 <20150220144119.GB1707@saruman.tx.rr.com>
 <54E75665.6050205@linaro.org>
 <20150220160610.GB6430@saruman.tx.rr.com>
 <54E89E29.4010807@linaro.org>
 <20150221162102.GA1784@saruman.tx.rr.com>
 <54E948AC.2010609@linaro.org>
 <20150223153612.GF32701@saruman.tx.rr.com>
 <54EDCE04.3040404@linaro.org>
Message-ID: <20150225163204.GA11136@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 09:28:36PM +0800, zhangfei wrote:
> >>>>>>>>+static void hi6220_detect_work(struct work_struct *work)
> >>>>>>>>+{
> >>>>>>>>+	struct hi6220_priv *priv =
> >>>>>>>>+		container_of(work, struct hi6220_priv, work.work);
> >>>>>>>>+	int gpio_id, gpio_vbus;
> >>>>>>>>+	enum usb_otg_state state;
> >>>>>>>>+
> >>>>>>>>+	if (!gpio_is_valid(priv->gpio_id) || !gpio_is_valid(priv->gpio_vbus))
> >>>>>>>>+		return;
> >>>>>>>>+
> >>>>>>>>+	gpio_id = gpio_get_value_cansleep(priv->gpio_id);
> >>>>>>>>+	gpio_vbus = gpio_get_value_cansleep(priv->gpio_vbus);
> >>>>>>>
> >>>>>>>looks like this should be using extcon
> >>>>>>Not used extcon before.
> >>>>>>However, we need gpio_vbus interrupt.
> >>>>>>Checked phy-tahvo.c and phy-omap-otg.c, not find extcon related with
> >>>>>>interrupt.
> >>>>>>Will investigate tomorrow.
> >>>>>
> >>>>>drivers/extcon/extcon-gpio.c
> >>>>I think there is no need to use extcon, gpio is clear enough.
> >>>>extcon-gpio.c even do not support dt.
> >>>
> >>>well, add DT. The whole idea of free software is that we improve on
> >>>things we already have. EXTCON is *the* API to handle such things.
> >>
> >>I think I am still not understanding extcon-gpio, not sure why need
> >>use this API here.
> >
> >because extcon is the API to use for external connectors. The same way
> >you use regulator framework to control that single GPIO tied to an
> >enable signal of a fixed regulator, you use extcon when you need to read
> >that gpio signal tied to id pin of the USB connector.
> >
> >>Here two gpio requires, one gpio as interrupt, in the interrupt
> >>handler, we detect the gpio status judging the otg status.
> >>extcon-gpio.c use the interrupt, then can we also use the gpio
> >>interrupt.  Using extcon-gpio is used for saving gpio_request?
> >
> >extcon is used to hide gpio_request from dwc2. dwc2 only knows about
> >extcon, not gpios. extcon will request the gpio and use it as interrupt
> >source. When an IRQ fires, it will read the gpio state and decide if it
> >should broadcast a message to tell dwc2 to become host or peripheral.
> 
> Thanks for the kind education, understand now.

hey, no problem ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/dab57924/attachment.sig>

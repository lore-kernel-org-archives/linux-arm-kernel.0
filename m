From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Feb 2015 09:36:12 -0600
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <54E948AC.2010609@linaro.org>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
 <20150220144119.GB1707@saruman.tx.rr.com>
 <54E75665.6050205@linaro.org>
 <20150220160610.GB6430@saruman.tx.rr.com>
 <54E89E29.4010807@linaro.org>
 <20150221162102.GA1784@saruman.tx.rr.com>
 <54E948AC.2010609@linaro.org>
Message-ID: <20150223153612.GF32701@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 22, 2015 at 11:10:36AM +0800, zhangfei wrote:
> >>>>>>+static void hi6220_start_peripheral(struct hi6220_priv *priv, bool on)
> >>>>>>+{
> >>>>>>+	struct usb_otg *otg = priv->phy.otg;
> >>>>>>+
> >>>>>>+	if (!otg->gadget)
> >>>>>>+		return;
> >>>>>>+
> >>>>>>+	if (on)
> >>>>>>+		usb_gadget_connect(otg->gadget);
> >>>>>>+	else
> >>>>>>+		usb_gadget_disconnect(otg->gadget);
> >>>>>
> >>>>>why is the PHY fiddling with pullups ?
> >>>>
> >>>>We use this to enable/disable otg gadget mode.
> >>>
> >>>I got that, but the pullups don't belong to the PHY, they belong to the
> >>>gadget.
> >>>
> >>>>The gpio_id & gpio_vbus are used to distinguish otg gadget mode or
> >>>>host mode.
> >>>>When micro usb or otg device attached to otg, gpio_vbus falling down.
> >>>>And gpio_id = 1 is micro usb, gpio_id = 0 is otg device.
> >>>
> >>>all of that I understood clearly :-)
> >>>
> >>>>So when micro usb attached, we enable gadget mode; while micro usb
> >>>>detached, we disable gadget mode, and dwc2 will automatically set to
> >>>>host mode.
> >>>
> >>>that's all fine, I'm concerned about letting the PHY fiddle with
> >>>something it doesn't own. If I am to change pullups rules in udc-core,
> >>>this is likely to break down miserably and I don't want to have to go
> >>>through that.
> >>
> >>Thanks for the clarifying.
> >
> >no problem.
> >
> >>How about using usb_gadget_vbus_connect/disconnect, which are used in many
> >>files under drivers/usb/phy.
> >>There is no vbus_session in dwc2/gadget.c, I thought it would be same as
> >>pullup.
> >>
> >>However, usb_gadget_vbus_connect still need para gadget, where should we put
> >>this file, drivers/usb/phy or drivers/phy
> >
> >drivers/phy, if the framework misses anything you need, it's a great
> >opportunity to give back to the community by extending the framework.
> 
> Sorry, I am a little confused.
> I need some concrete suggestion for the next step of this patch, which is
> required for the community board, hikey board.
> 
> Do you mean in the future we need use hsotg->phy instead of hsotg->uphy.
>         struct phy *phy;
>         struct usb_phy *uphy;

yes, we need to move everybody to use struct phy, instead of struct
usb_phy.

> usb_phy has many members that struct phy does not have, including otg.
> struct usb_otg          *otg;
> Is that mean we need port such member from usb_phy to phy.

This means we have a little ground work to do before we can add your phy
driver to that framework, right ? As I said, if the framework is missing
anything, work with Kishon (generic phy maintainer) to add those missing
pieces generically.

> Besides, are you ok with using usb_gadget_vbus_connect/disconnect.
> 
> >
> >Scratching one's own itch kinda thing...
> >
> >>>>>>+static void hi6220_detect_work(struct work_struct *work)
> >>>>>>+{
> >>>>>>+	struct hi6220_priv *priv =
> >>>>>>+		container_of(work, struct hi6220_priv, work.work);
> >>>>>>+	int gpio_id, gpio_vbus;
> >>>>>>+	enum usb_otg_state state;
> >>>>>>+
> >>>>>>+	if (!gpio_is_valid(priv->gpio_id) || !gpio_is_valid(priv->gpio_vbus))
> >>>>>>+		return;
> >>>>>>+
> >>>>>>+	gpio_id = gpio_get_value_cansleep(priv->gpio_id);
> >>>>>>+	gpio_vbus = gpio_get_value_cansleep(priv->gpio_vbus);
> >>>>>
> >>>>>looks like this should be using extcon
> >>>>Not used extcon before.
> >>>>However, we need gpio_vbus interrupt.
> >>>>Checked phy-tahvo.c and phy-omap-otg.c, not find extcon related with
> >>>>interrupt.
> >>>>Will investigate tomorrow.
> >>>
> >>>drivers/extcon/extcon-gpio.c
> >>I think there is no need to use extcon, gpio is clear enough.
> >>extcon-gpio.c even do not support dt.
> >
> >well, add DT. The whole idea of free software is that we improve on
> >things we already have. EXTCON is *the* API to handle such things.
> 
> I think I am still not understanding extcon-gpio, not sure why need
> use this API here.

because extcon is the API to use for external connectors. The same way
you use regulator framework to control that single GPIO tied to an
enable signal of a fixed regulator, you use extcon when you need to read
that gpio signal tied to id pin of the USB connector.

> Here two gpio requires, one gpio as interrupt, in the interrupt
> handler, we detect the gpio status judging the otg status.
> extcon-gpio.c use the interrupt, then can we also use the gpio
> interrupt.  Using extcon-gpio is used for saving gpio_request?

extcon is used to hide gpio_request from dwc2. dwc2 only knows about
extcon, not gpios. extcon will request the gpio and use it as interrupt
source. When an IRQ fires, it will read the gpio state and decide if it
should broadcast a message to tell dwc2 to become host or peripheral.

> >Quite frankly, though, Roger Quadros (now in Cc) has been working to get
> >DT support on extcon-gpio, so perhaps wait for that and base your
> >patches on top of his.
> >
> >Now your statement that GPIO is clear enough is completely bogus to me.
> >
> >Why do we have fixed regulators with GPIO enable signals, right ? Might
> >as well just fiddle with the GPIO directly, right ? Wrong, the idea of
> >using these frameworks is to encapsulate implementation details and make
> >sure that if things change from one board to another, we can still use
> >our SW without major modifications.
> >
> >>>>>>+	if (gpio_vbus == 0) {
> >>>>>>+		if (gpio_id == 1)
> >>>>>>+			state = OTG_STATE_B_PERIPHERAL;
> >>>>>>+		else
> >>>>>>+			state = OTG_STATE_A_HOST;
> >>>>>>+	} else {
> >>>>>>+		state = OTG_STATE_A_HOST;
> >>>>>>+	}
> >>>>>>+
> >>>>>>+	if (priv->state != state) {
> >>>>>>+		hi6220_start_peripheral(priv, state == OTG_STATE_B_PERIPHERAL);
> >>>>>>+		priv->state = state;
> >>>>>>+	}
> >>>>>>+}
> >>>>>>+
> >>>>>>+static irqreturn_t hiusb_gpio_intr(int irq, void *data)
> >>>>>>+{
> >>>>>>+	struct hi6220_priv *priv = (struct hi6220_priv *)data;
> >>>>>>+
> >>>>>>+	/* add debounce time */
> >>>>>>+	schedule_delayed_work(&priv->work, msecs_to_jiffies(100));
> >>>>>
> >>>>>this is really bad. We have threaded interrupt support, right ?
> >>>>
> >>>>Since we use two gpio to distinguish gadget mode or host mode.
> >>>>Debounce time can introduce more accuracy.
> >>>
> >>>gpio_set_debounce() ?
> >>Not all gpio.c support set_debounce, including gpio-pl061.c.
> >
> >then the framework should implement it in SW. That was the whole idea of
> >adding set_debounce() to gpiolib. If the controller can't handle it,
> >gpiolib handles it in SW. Again, encapsulating details.
> >
> >>>>I think threaded interrupt can not be used for adding debounce time.
> >>>>Here add debounce is just for safety.
> >>>
> >>>add the debounce to the gpio itself.
> >>
> >>Here the debounce added only for safety.
> >>gpio_id may mis-report when unplug usb, but it is correct for plug usb & otg
> >>device.
> >>So debounce can be omitted.
> >>If you think using delayed work for debounce is ugly, it is fine switch to
> >>threaded_irq.
> >
> >debounce might be very well needed. We *do* want to filter out the
> >transient period. I'm just telling you there are better ways of doing
> >so; and your response to that is "let's just remove it" and I'm not
> >really comfortable with that attitude.
> >
> >That's the attitude of a lazy person which, I hope, you are not ;)
> 
> Understand.
> What I mean here is gpio_id is not used when unplug, it is only used after
> plug.

sure, but does it make a difference if you let gpiolib handle debouncing
for you ? It makes no difference at all, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/58ed6b4d/attachment.sig>

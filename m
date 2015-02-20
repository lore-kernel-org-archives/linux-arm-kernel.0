From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 20 Feb 2015 23:44:37 +0800
Subject: [PATCH v4 4/4] phy: add phy-hi6220-usb
In-Reply-To: <20150220144119.GB1707@saruman.tx.rr.com>
References: <1423726646-30336-1-git-send-email-zhangfei.gao@linaro.org>
 <1423726646-30336-5-git-send-email-zhangfei.gao@linaro.org>
 <20150220144119.GB1707@saruman.tx.rr.com>
Message-ID: <54E75665.6050205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Balbi

On 02/20/2015 10:41 PM, Felipe Balbi wrote:

>> +static void hi6220_start_peripheral(struct hi6220_priv *priv, bool on)
>> +{
>> +	struct usb_otg *otg = priv->phy.otg;
>> +
>> +	if (!otg->gadget)
>> +		return;
>> +
>> +	if (on)
>> +		usb_gadget_connect(otg->gadget);
>> +	else
>> +		usb_gadget_disconnect(otg->gadget);
>
> why is the PHY fiddling with pullups ?

We use this to enable/disable otg gadget mode.

The gpio_id & gpio_vbus are used to distinguish otg gadget mode or host 
mode.
When micro usb or otg device attached to otg, gpio_vbus falling down.
And gpio_id = 1 is micro usb, gpio_id = 0 is otg device.

So when micro usb attached, we enable gadget mode; while micro usb 
detached, we disable gadget mode, and dwc2 will automatically set to 
host mode.

>
>> +}
>> +
>> +static void hi6220_detect_work(struct work_struct *work)
>> +{
>> +	struct hi6220_priv *priv =
>> +		container_of(work, struct hi6220_priv, work.work);
>> +	int gpio_id, gpio_vbus;
>> +	enum usb_otg_state state;
>> +
>> +	if (!gpio_is_valid(priv->gpio_id) || !gpio_is_valid(priv->gpio_vbus))
>> +		return;
>> +
>> +	gpio_id = gpio_get_value_cansleep(priv->gpio_id);
>> +	gpio_vbus = gpio_get_value_cansleep(priv->gpio_vbus);
>
> looks like this should be using extcon
Not used extcon before.
However, we need gpio_vbus interrupt.
Checked phy-tahvo.c and phy-omap-otg.c, not find extcon related with 
interrupt.
Will investigate tomorrow.

>
>> +
>> +	if (gpio_vbus == 0) {
>> +		if (gpio_id == 1)
>> +			state = OTG_STATE_B_PERIPHERAL;
>> +		else
>> +			state = OTG_STATE_A_HOST;
>> +	} else {
>> +		state = OTG_STATE_A_HOST;
>> +	}
>> +
>> +	if (priv->state != state) {
>> +		hi6220_start_peripheral(priv, state == OTG_STATE_B_PERIPHERAL);
>> +		priv->state = state;
>> +	}
>> +}
>> +
>> +static irqreturn_t hiusb_gpio_intr(int irq, void *data)
>> +{
>> +	struct hi6220_priv *priv = (struct hi6220_priv *)data;
>> +
>> +	/* add debounce time */
>> +	schedule_delayed_work(&priv->work, msecs_to_jiffies(100));
>
> this is really bad. We have threaded interrupt support, right ?

Since we use two gpio to distinguish gadget mode or host mode.
Debounce time can introduce more accuracy.
I think threaded interrupt can not be used for adding debounce time.
Here add debounce is just for safety.

Thanks

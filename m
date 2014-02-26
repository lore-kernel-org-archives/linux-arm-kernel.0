From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 26 Feb 2014 20:37:04 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAxLzVdIHR0eS9zZXJpYWw6IEFkZCBHUElPTElCIGhl?=
 =?UTF-8?B?bHBlcnMgZm9yIGNvbnRyb2xsaW5nIG1vZGVtIGxpbmVz?=
In-Reply-To: <1393431588-25977-2-git-send-email-richard.genoud@gmail.com>
References: <1393431588-25977-1-git-send-email-richard.genoud@gmail.com>
 <1393431588-25977-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <1393432624.955150590@f282.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard.

?????, 26 ??????? 2014, 17:19 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Better, but I found few bugs... :)

...
> +Modem control lines via GPIO
> +----------------------------
> +
> +Some helpers are provided in order to set/get modem control lines via GPIO.
> +
> +mctrl_gpio_init(dev, idx):

I think we should indicate variable types used in these functions.

...
> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
> +{
> +	enum mctrl_gpio_idx i;
> +
> +	if (IS_ERR_OR_NULL(gpios))
> +		return;

No. IS_ERR_OR_NULL() is not valid here. This is allocated by kzalloc(),
so you should check valid pointer only, ie (!gpios).
Same in other places.


> +		if (err) {
> +			dev_err(dev, "Unable to set direction for %s GPIO",
> +				mctrl_gpios_desc[i].name);
> +			devm_gpiod_put(dev, gpios->gpio[i]);
> +			gpios->gpio[i] = NULL;
> +		}
> +	}

Let's use dev_dbg().

Thanks.
---

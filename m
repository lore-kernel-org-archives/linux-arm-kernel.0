From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Feb 2013 20:07:23 -0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130205040721.GE25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:32]:
> +- pinctrl-single,drive-strength : array of value that are used to configure
> +  drive strength in the pinmux register. They're value of drive strength
> +  current and drive strength mask.
> +
> +		/* drive strength current, mask */
> +		pinctrl-single,power-source = <0x30 0xf0>;
> +

Looks like a typo, this should probably say pinctrl-single,drive-strength
here instead of power-source?

For the cases where there's a value to be set I'm still wondering how does
a client driver change the value if that needs to be changed dynamically?
Can the value be passed as value + PIN_CONFIG_END?

> +- pinctrl-single,bias-disable : array of value that are used to configure the
> +  input bias disabled in the pinmux register. They're value of bias value,
> +  match bias disabled value and bias disabled mask.
> +
> +		/* bias value, match bias disabled value, mask */
> +		pinctrl-single,bias-disable = <2 0 3>;
> +

I still suggest we use "enable" naming instead of "disable" naming.
So pinctrl-single,bias-enable instead of pinctrl-single,bias-disable.

Then let's change the binding slightly to make it more readable:

		/* enable value, disable value, mask */
		pinctrl-single,bias-enable = <2 0 3>;

For example, I have bit 22 cleared to enable MMC PBIAS, or bit 22
set to disable PBIAS:

		                             /* enable disable  mask */
		pinctrl-single,bias-enable = <0x000000 0x400000 0x400000>;

Then I think pretty much the only change to pinconf_get() would be:

	data = pcs->read(pcs->base + offset) & func->conf[i].mask;

	switch (func->conf[i].param) {
	/* 3 parameters */
	case PIN_CONFIG_BIAS_ENABLE:
	case PIN_CONFIG_BIAS_PULL_DOWN:
	case PIN_CONFIG_BIAS_PULL_UP:
	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
	*config = data;
	if (data == func->conf[i].enable)
		res = 0;
	else
		res = -ENOTSUPP;
	break;
	...

And then the client driver can always assume that if the return value
is 0, the ENABLE value in question is set. And if -ENOTSUPP (or how about
-ENOTSET :) is returned, the ENABLE value is not set?

Then regarding pinconf_set(), don't we also need pinconf_clear() in
addition to pinconf_set()?

Otherwise we need both ENABLE and DISABLE enumeration, which seems
unnecessary to me. So rather than have both PIN_CONFIG_BIAS_ENABLE and
PIN_CONFIG_BIAS_DISABLE, we just need PIN_CONFIG_BIAS_ENABLE.

> +- pinctrl-single,bias-pullup : array of value that are used to configure the
> +  input bias pullup in the pinmux register. They're value of bias value,
> +  match bias pullup value and bias pullup mask.
> +
> +		/* bias value, match bias pullup value, mask */
> +		pinctrl-single,bias-pullup = <0 1 1>;

It seems that you could then use same generic comment in all places
then to make it a bit easier to read:

		/* enable value, disable value, mask */
		pinctrl-single,bias-pullup = <0 1 1>;
...

Regards,

Tony

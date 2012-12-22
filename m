From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Dec 2012 17:22:01 -0800
Subject: [PATCH v6 5/8] document: devicetree: bind pinconf with pin single
In-Reply-To: <1356083118-18857-6-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20121222012201.GS21056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Haojian Zhuang <haojian.zhuang@linaro.org> [121221 01:48]:
>  
> +- pinctrl-single,power-source : array of value that are used to configure
> +  power source in the pinmux register. They're value of power source field
> +  and power source mask.
> +
> +		/* power source, mask */
> +		pinctrl-single,power-source = <0x1000 0x1800>;
> +
> +- pinctrl-single,bias : array of value that are used to configure the input
> +  bias in the pinmux register.  They're value of bias field, bias mask,
> +  bias disable value, bias pull down value & bias pull up value.
> +
> +		/* bias, mask, disable, pull down, pull up */
> +		pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
> +
> +- pinctrl-single,input-schmitt : array of value that are used to configure
> +  input schmitt in the pinmux register. They're value of input schmitt field,
> +  mask, & disable value.
> +
> +		/* input schmitt value, mask, disable */
> +		pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
> +

Hmm we might be able to standardize on just few bindings if we
break the bias into enable, pullup and pulldown. Then we should
have the defval, enable and disable for each of them to allow
setting the board specific config, and to enable and disable
things using the generic pinconf api.

So how about something like this:

pinctrl-single,power-source	 = <defval regmask enableval disableval>;
pinctrl-single,bias-enable	 = <defval regmask enableval disableval>;
pinctrl-single,bias-pullup	 = <defval regmask enableval disableval>;
pinctrl-single,bias-pulldown	 = <defval regmask enableval disableval>;
pinctrl-single,input-schmitt	 = <defval regmask enableval disableval>;

And then we can add support for other things like comparators too:

pinctrl-single,comparator-enable = <defval regmask enableval disableval>;
pinctrl-single,comparator-status = <regmask>;	/* read only status bits */

I'll do some experiments on this with my bit-per-mux testcase,
but please let me know if you see any issues using the format
above meanwhile.

Regards,

Tony

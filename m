From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 16 Oct 2017 10:01:17 +0200
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1504798409-32041-2-git-send-email-timur@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
Message-ID: <20171016080117.GA17369@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 10:33:28AM -0500, Timur Tabi wrote:
[...]
>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>  	if (ret) {
>  		dev_err(pctrl->dev, "Failed register gpiochip\n");
>  		return ret;
>  	}
>  
> -	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
> +	/*
> +	 * If irq_need_valid_mask is true, then gpiochip_add_data() will
> +	 * initialize irq_valid_mask to all 1s.  We need to clear all the
> +	 * GPIOs that are unavailable, and we need to find each block
> +	 * of consecutive available GPIOs are add them as pin ranges.
> +	 */
> +	if (chip->irq_need_valid_mask) {
> +		for (i = 0; i < ngpio; i++)
> +			if (!groups[i].npins)
> +				clear_bit(i, pctrl->chip.irq_valid_mask);
> +
> +		while ((count = msm_gpio_get_next_range(pctrl, &start))) {
> +			ret = gpiochip_add_pin_range(&pctrl->chip,
> +						     dev_name(pctrl->dev),
> +						     start, start, count);
> +			if (ret)
> +				break;
> +			start += count;
> +		}
> +	} else {
> +		ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
> +					     0, 0, ngpio);
> +	}

This is the bit that I don't understand. If you only tell gpiolib about
the GPIOs that exist, then it won't be initializing the .irq_valid_mask
in a wrong way.

In other words, what I'm trying to say is that in your case, ngpio isn't
equal to the sum of .npins over all groups. If instead you make the chip
register only the lines that actually exist, .irq_valid_mask will only
contain bits that do exist.

The reason I'm bringing this up is because we had the same discussion
back in November last year (yes, that driver still isn't upstream...):

	https://lkml.org/lkml/2016/11/22/543

In a nutshell: the Tegra driver was assuming that each port had a fixed
number (8) of lines, but when gpiolib changed to query the direction of
GPIOs at driver probe time this broke badly because on of the instances
of the GPIO controller is very strict about what it allows access to.

This seems to be similar to what you're experiencing. In our case we'd
run into a hard hang trying to access a register for a non-existing
GPIO. One of the possibilities discussed in the thread was to introduce
something akin to what's being proposed here.

In the end it turned out to be easiest to just don't tell gpiolib about
any non-existing GPIOs, because then you don't get to deal with any of
these workarounds. The downside is that you need a little more code to
find out exactly what GPIO you're talking about, or to determine how
many you have. In the end I think it's all worth it by making it a lot
easier in general to deal with. I think it's really confusing if you
expose, say, 200 pins, and for 50 of them users will get -EACCES, or
-ENOENT or whatever if they try to use them.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171016/2a2bf792/attachment.sig>

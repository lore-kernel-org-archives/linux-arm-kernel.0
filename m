From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 27 Oct 2016 09:55:58 -0700
Subject: [PATCH 1/2] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477503355-2600-2-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Wed, 26 Oct 2016 19:35:54 +0200")
References: <1477503355-2600-1-git-send-email-bgolaszewski@baylibre.com>
 <1477503355-2600-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m2insdg28x.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Create a new driver for the da8xx DDR2/mDDR controller and implement
> support for writing to the Peripheral Bus Burst Priority Register.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[...]

> +	for (; setting->name; setting++) {
> +		knob = da8xx_ddrctl_match_knob(setting);
> +		if (!knob) {
> +			dev_warn(dev,
> +				 "no such config option: %s\n", setting->name);
> +			continue;
> +		}
> +
> +		if (knob->reg > (res->end - res->start - sizeof(u32))) {

Why the "- sizeof(u32)"?  Shouldn't this just be resource_size(res)?
(c.f. linux/ioport.h)

> +			dev_warn(dev,
> +				 "register offset of '%s' exceeds mapped memory size\n",
> +				 knob->name);
> +			continue;
> +		}
> +
> +		reg = __raw_readl(ddrctl + knob->reg);
> +		reg &= knob->mask;
> +		reg |= setting->val << knob->shift;
> +
> +		dev_dbg(dev, "writing 0x%08x to %s\n", reg, setting->name);
> +
> +		__raw_writel(reg, ddrctl + knob->reg);

Can you use the normal readl/writel here?  Or explain why the raw ones
are needed?

> +	}
> +
> +	return 0;
> +}
> +

Otherwise, looks good to me.  With the changes above, feel free to add

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin

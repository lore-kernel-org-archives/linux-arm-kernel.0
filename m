From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jun 2012 04:38:53 -0700
Subject: [RFC PATCH 07/11] mfd: omap: control: usb-phy: introduce the
 ctrl-module usb driver
In-Reply-To: <1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
Message-ID: <20120601113853.GO12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eduardo Valentin <eduardo.valentin@ti.com> [120525 01:31]:
> +int omap4_usb_phy_power(struct device *dev, int on)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (on) {
> +		ret = omap_control_readl(dev, CONTROL_DEV_CONF, &val);
> +		if (!ret && (val & PHY_PD)) {
> +			ret = omap_control_writel(dev, ~PHY_PD,
> +						  CONTROL_DEV_CONF);
> +			/* XXX: add proper documentation for this delay */
> +			mdelay(200);
> +		}
> +	} else {
> +		ret = omap_control_writel(dev, PHY_PD, CONTROL_DEV_CONF);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(omap4_usb_phy_power);

I'm not quite convinced that we should export omap_control_read/write
to drivers. If there's a clear register area this USB phy driver can
manage, then ioremaping it separately makes sense. If it's just one
register, then exporting something like omap_control_usb_phy_set()
might be better for ensuring that drivers don't mess up things for
other drivers.

Regards,

Tony

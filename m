From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Nov 2013 08:49:17 -0800
Subject: [PATCH 1/3] arm: omap2: Export devconf1 bypass and acbias.
In-Reply-To: <1381784555-18344-2-git-send-email-marek@goldelico.com>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <1381784555-18344-2-git-send-email-marek@goldelico.com>
Message-ID: <20131111164917.GN15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [131014 14:11]:
> devconf1 reg access is localized only in mach-omap2 and we need to export
> updating of devconf1 from omapdss venc driver (bypass and acbias bits).
> Add simple api call which update only necessary bits.
...

> +void update_bypass_acbias(bool bypass, bool acbias)
> +{
> +#ifdef CONFIG_ARCH_OMAP3
> +	int val = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
> +
> +	if (bypass)
> +		val |= OMAP2_TVOUTBYPASS;
> +	else
> +		val &= ~OMAP2_TVOUTBYPASS;
> +
> +	if (acbias)
> +		val |= OMAP2_TVACEN;
> +	else
> +		val &= ~OMAP2_TVACEN;
> +
> +	omap_ctrl_writel(val, OMAP343X_CONTROL_DEVCONF1);
> +#endif

If this is truly a pinmux, you could already access this
using pinctrl-single,bits device tree driver.

But I guess that won't work yet, so it's best to set this
up as a separate driver like we've done for the USB PHY
registers.

Regards,

Tony

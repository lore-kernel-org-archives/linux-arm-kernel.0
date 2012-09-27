From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 15:18:38 +0100
Subject: [PATCH v2 1/2] usb: phy: add a new driver for usb3 phy
In-Reply-To: <1348754648-8315-2-git-send-email-kishon@ti.com>
References: <1348754648-8315-1-git-send-email-kishon@ti.com>
 <1348754648-8315-2-git-send-email-kishon@ti.com>
Message-ID: <20120927141837.GA26268@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 07:34:07PM +0530, Kishon Vijay Abraham I wrote:
> +static int omap5_usb_phy_power(struct omap_usb *phy, bool on)
> +{
> +	u32 val;
> +	unsigned long rate;
> +	struct clk *sys_clk;
> +
> +	sys_clk = clk_get(NULL, "sys_clkin");
> +	if (IS_ERR(sys_clk)) {
> +		pr_err("%s: unable to get sys_clkin\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(sys_clk);
> +	rate = rate/1000000;
> +	clk_put(sys_clk);

Actually, you're supposed to hold on to the struct clk all the time your
driver is making use of that - you're not supposed to drop it.

That has several advantages: if clk_get() fails, then you're failing
earlier on (when the driver is being probed) and when some event occurs.

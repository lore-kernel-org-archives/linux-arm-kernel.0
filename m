From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jan 2013 14:55:30 +0000
Subject: [PATCH v6 04/22] mfd: omap-usb-tll: Clean up clock handling
In-Reply-To: <1358347433-329-5-git-send-email-rogerq@ti.com>
References: <1358347433-329-1-git-send-email-rogerq@ti.com>
 <1358347433-329-5-git-send-email-rogerq@ti.com>
Message-ID: <20130116145530.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 04:43:35PM +0200, Roger Quadros wrote:
> +	spin_lock_irqsave(&tll->lock, flags);
> +
> +	for (i = 0; i < tll->nch; i++) {
> +		char clkname[] = "usb_tll_hs_usb_chx_clk";
> +		struct clk *fck;
> +
> +		snprintf(clkname, sizeof(clkname),
> +					"usb_tll_hs_usb_ch%d_clk", i);
> +		fck = clk_get(dev, clkname);

NAK.  Why are you doing this under a spinlock?

clk_get() takes a mutex.  You must not be in an atomic region (iow, you
must not be holding a spinlock, and you must not have IRQs disabled)
when you call clk_get().

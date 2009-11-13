From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Nov 2009 08:29:03 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <20091112223237.GF12308@n2100.arm.linux.org.uk>
References: <1258022525-21078-2-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-3-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-4-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-5-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-7-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<20091112223237.GF12308@n2100.arm.linux.org.uk>
Message-ID: <20091113072903.GB30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 10:32:37PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 12, 2009 at 04:06:15PM +0100, Sascha Hauer wrote:
> > +static int mxc_audmux_v2_init(void)
> > +{
> > +	int ret;
> > +
> > +	if (cpu_is_mx31() || cpu_is_mx35())
> > +		audmux_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
> > +	else
> > +		return 0;
> > +
> > +	if (cpu_is_mx35()) {
> > +		audmux_clk = clk_get(NULL, "audmux");
> > +		if (IS_ERR(audmux_clk)) {
> > +			audmux_base = NULL;
> > +			ret = PTR_ERR(audmux_clk);
> > +			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
> > +					ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Hmm.  Wouldn't something like:
> 
> 	if (cpu_is_mx35()) {
> 		audmux_clk = clk_get(NULL, "audmux");
> 		if (IS_ERR(audmux_clk)) {
> 			int ret = PTR_ERR(audmux_clk);
> 			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
> 					ret);
> 			return ret;
> 		}
> 	}
> 
> 	if (cpu_is_mx31() || cpu_is_mx35())
> 		audmux_base = IO_ADDRESS(AUDMUX_BASE_ADDR);
> 
> 	return 0;
> 
> be a better and clearer way to write this?

Indeed. I Changed this.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

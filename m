From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Apr 2012 16:02:45 +0800
Subject: [PATCH 3/8] clk: mxs: add clock support for imx28
In-Reply-To: <20120425071747.GX20478@pengutronix.de>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
 <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
 <20120425071747.GX20478@pengutronix.de>
Message-ID: <20120425080244.GA1503@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 09:17:47AM +0200, Sascha Hauer wrote:
> Hi Shawn,
> 
> I realized that you have no register lock which means that you rely on
> the locking of the clock framework. This may not be sufficient, see the
> following example:
> 
> > +	mxs_clk_div("ssp0_div", "ssp0_sel", SSP0, 0, 9, 29);
> > +	clk = mxs_clk_gate("ssp0", "ssp0_div", SSP0, 31);
> 
> You have both a divider and a gate in the same register here. The gate
> implements clk_enable which is protected by a spinlock in the clock
> framework. The divider implements clk_set_rate which is protected by a
> mutex in the clock framework. This means that during a read-modify-write
> operation for a rate change the clk_enable call can come in between.

We have SET and CLR register on mxs clocks, so do not really have to
go through read-modify-write sequence.

Regards,
Shawn

> 
> Ok, here we have two clocks which are both handled by a single driver,
> so there probably won't be any real problems, but do you want to rely on
> this?
> 

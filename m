From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 Apr 2012 16:48:52 +0800
Subject: [PATCH 3/8] clk: mxs: add clock support for imx28
In-Reply-To: <20120425080537.GB3852@pengutronix.de>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
 <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
 <20120425071747.GX20478@pengutronix.de>
 <20120425080244.GA1503@S2100-06.ap.freescale.net>
 <20120425080537.GB3852@pengutronix.de>
Message-ID: <20120425084852.GB1503@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 10:05:37AM +0200, Sascha Hauer wrote:
> On Wed, Apr 25, 2012 at 04:02:45PM +0800, Shawn Guo wrote:
> > On Wed, Apr 25, 2012 at 09:17:47AM +0200, Sascha Hauer wrote:
> > > Hi Shawn,
> > > 
> > > I realized that you have no register lock which means that you rely on
> > > the locking of the clock framework. This may not be sufficient, see the
> > > following example:
> > > 
> > > > +	mxs_clk_div("ssp0_div", "ssp0_sel", SSP0, 0, 9, 29);
> > > > +	clk = mxs_clk_gate("ssp0", "ssp0_div", SSP0, 31);
> > > 
> > > You have both a divider and a gate in the same register here. The gate
> > > implements clk_enable which is protected by a spinlock in the clock
> > > framework. The divider implements clk_set_rate which is protected by a
> > > mutex in the clock framework. This means that during a read-modify-write
> > > operation for a rate change the clk_enable call can come in between.
> > 
> > We have SET and CLR register on mxs clocks, so do not really have to
> > go through read-modify-write sequence.
> 
> You have the SET and CLR registers but you don't use them.

Doh!  I forgot I'm running with basic clocks.

> You could use
> SET/CLR in the gate, but even then:
> 
> - clk_set_rate starts and reads the divider register
> - clk_enable comes in and writes to SET/CLR for the same register
> - clk_set_rate continues and writes to the divider register not knowing
>   that it has been modified in between.
> 
> You could try and clear all divider bits in the divider using the CLR
> register and then set the wanted bits using the SET register, but this
> would mean writing reserved values to the divider in between.
> 
Ok, will add register locking.  Thanks, Sascha.

-- 
Regards,
Shawn

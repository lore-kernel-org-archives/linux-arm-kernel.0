From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 05 Aug 2016 14:03:35 +0200
Subject: serial: imx: regression triggered by newly introduced DSR irq
 handling
In-Reply-To: <20160805065845.GI17874@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
Message-ID: <1470398615.1936.22.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-05 at 08:58 +0200, Uwe Kleine-K?nig wrote:
> On Fri, Aug 05, 2016 at 12:44:23AM +0200, Christoph Fritz wrote:
> > here on a imx6sx board newly introduced DSR-irq-handling breaks serial
> > console and network support.
> > 
> > Reverting commit 27e16501052e5341934d3 "serial: imx: implement DSR irq
> > handling for DTE mode" fixes the issue.
> > 
> > The underlying cause is the RMII network configuration where register
> > bit SION in IOMUXC_SW_MUX_CTL_PAD_ENET1_TX_CLK is necessary. But this
> > also falsely feeds signal UART1_DTR_B and triggers DSR irq...
> > 
> > Can we revert this commit or add a quirk for RMII-SION configs or make
> > this optional by a device tree option?
> 
> Hmm, MX6SX_PAD_ENET1_TX_CLK__ENET1_TX_CLK in
> arch/arm/boot/dts/imx6sx-pinfunc.h doesn't have SION set.
> 
> I remember there were issues around eth and SION on i.MX6DL, but don't
> know the details. A quick net research found
> https://community.nxp.com/thread/359531 which has: "Set the SION bit.
> Note that this is not required because the funtion setting controls the
> signal path, but it is good practice as it reminds the user that the
> clock needs to fed back into the Ethernet MAC.". Sounds like dangerous
> smattering and a wrong expectation about "users".
> 
> https://community.nxp.com/thread/376821 is from someone who has the same
> problem(?) on i.MX6SX, but no solution yet.
> 
> Does that mean MX6SX_PAD_ENET1_TX_CLK__ENET1_TX_CLK always needs the
> SION bit set?

SION is necessary for pinconfig MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1
if bit 17 in IOMUXC_GPR_GPR1 is set and bit 13 not.

So that ref_enetpll1 provides a clock not only for the external PHY but
also for the internal controller.

Using SION is a quirk here, because the silicon doesn't feed the clock
back to the internal controller automatically.

On the other hand, NXP could argue: You need to add a wire on your PCB
between ENET1_REF_CLK1 and ENET1_TX_CLK -- but referring to the
datasheet ENET1_TX_CLK isn't used in RMII config...

So if Fabio or Shawn agrees with my assumption above, I'll add something
like 27e16501052e5341934d3 "serial: imx: implement DSR irq
handling for DTE mode".

Okay?

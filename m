From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 11 Jun 2012 14:17:58 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
In-Reply-To: <4FD4E2DE.20006@baatz.info>
References: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
 <4FD4E2DE.20006@baatz.info>
Message-ID: <20120611121758.GA3221@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 08:09:34PM +0200, Simon Baatz wrote:
> Hi Andrew,
> 
> Am 08.06.2012 16:09, schrieb Andrew Lunn:
> > Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
> > nor SPI is used in the system, RUNIT clock gets turned off, and the
> > SoC hard locks. It appears something else in the SoC, which is not
> > documented, is also using RUNIT. So prepare and enable RUNIT clock in
> > kirkwood_clk_init().
> >
> > +
> > +	/* Something other than SPI and NAND needs runit, so make sure
> > +	   it never gets turned off. */
> > +	clk_prepare_enable(runit);
> >
> 
> I am experiencing another type of crash caused by the GE0 clock (on a
> IB-NAS 6210). I am compiling mv643xx_eth as a module. Thus, GE0 and GE1
> get turned off first since they are unused.
> 
> When the module loads and it should enable GE0, the box hangs.

I debugged this further. As i guessed, it is interesting, but not how
i expected.

By enabling a clock while performing shared_probe, i stopped it
locking up. I also needed to add a short delay in the individual
interface probe, otherwise it locked up there.

However, this leads to another problem. It appears to forget its MAC
address, as set by u-boot, while the clock is off :-(

I'm not sure how to handle this. One option is simply to not allow the
two clocks to be turned off. The module can then be loaded/unloaded at
any time, and the MAC address set by u-boot will still be available.

Or i could enable_prepare() the clock in kirkwood_ge00_init() and
kirkwood_ge01_init() when the platform device structure is
created. These functions indicate at some time in the future, the
driver might be loaded to driver one or the other interface, so
keeping the clk ticking to preserve the MAC address is a good idea.
This will however not work for DT boards, since they won't in the
future call these functions. We would need additional code to look
into the DT during boot, see if there are nodes for the ethernet
interfaces, and if so, enable_prepare() the clocks.

I'm tempted to go with this last solution, since it is more in keeping
with the way it was done before i replaced the code with the generic
clock framework.

      Andrew

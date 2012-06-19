From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 19 Jun 2012 22:42:10 +0200
Subject: Dove clock support
In-Reply-To: <20120619193251.GR26034@lunn.ch>
References: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
 <20120618074258.GI4799@lunn.ch> <4FDEDEAE.30502@blackshift.org>
 <20120618080449.GK4799@lunn.ch> <4FDEE6C6.2060101@blackshift.org>
 <20120618084300.GL4799@lunn.ch>
 <20120618214143.GA20040@schnuecks.de>
 <4FDFA748.10905@googlemail.com> <20120619193251.GR26034@lunn.ch>
Message-ID: <20120619204210.GA18128@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 09:32:51PM +0200, Andrew Lunn wrote:
> On Tue, Jun 19, 2012 at 12:10:16AM +0200, Sebastian Hesselbarh wrote:
> > On 06/18/2012 11:41 PM, Simon Baatz wrote:
> > >This is not potentially a problem, this is definitively a problem (on kirkwood):
> > >
> > >[   12.280783] sata_mv sata_mv.0: cannot get optional clkdev
> > >[   12.286314] sata_mv sata_mv.0: slots 32 ports 2
> > >...
> > >[   12.665882] ata1: SATA link down (SStatus 0 SControl F300)
> > >[   13.015881] ata2: SATA link down (SStatus 0 SControl F300)
> > 
> > Is this because of some bug in kirkwood soc or missing code in
> > sata_mv.c?
> > 
> > According to the functional specification of kirkwood there is a
> > PhyShutdown bit in it's registers. Dove also has this register bit.
> > 
> > Up to now it looks like the SATA PHY can only be disabled in code,
> > but there should be an phy_enable, too.
> 
> Correct.
> 
> When moving from kirkwoods old clock management to the generic clock
> framework, i kept the functionality the same. The old code would turn
> the PHYs off, but have no way to turn them back on again. The new code
> is the same.

No, not exactly the same. In the old code, it was sufficient to call
the respective kirkwood_..._init function to keep the clock and the
PHY alive. Now, the respective driver needs to enable the clock in
order to prevent that the clock and the PHY are shut down. 

If the driver is loaded as a module, the clock and the PHY are
already shut down at init of the module, which normally would not
happen previously.

Should we make this symmetric and add an enable function to gate_fn?

- Simon

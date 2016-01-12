From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 12 Jan 2016 17:04:44 +0100
Subject: [PATCHv2 0/2] net: fec: Reset ethernet PHY whenever the
 enet_out clock is being enabled
In-Reply-To: <20160112152405.GZ19062@n2100.arm.linux.org.uk>
References: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
 <20160112152405.GZ19062@n2100.arm.linux.org.uk>
Message-ID: <20160112170444.11c412c5@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Tue, Jan 12, 2016 at 04:17:54PM +0100, Lothar Wa?mann wrote:
> > This patchset fixes a regression introduced by
> > commit e8fcfcd5684a ("net: fec: optimize the clock management to save power")
> > for ethernet PHYs that are using ENET_OUT as reference clock (on i.MX6 or i.MX28)
> > 
> > Changes vs. v1:
> > - fixed reference to the commit that introduced the regression.
> > - dropped patch to use gpiod framework. This should be added later,
> >   after the affected DTBs have been updated to specify the correct
> >   gpio_flags.
> > 
> > Patch overview:
> > 1. cleanup patch to remove redundant NULL checks
> > 2. call fec_reset_phy() after the ENET_OUT clock has been enabled
> 
> I definitely want to test these on my SolidRun boards before these get
> merged: the AR8035 on there is configured via pin-straps, and then
> further tweaked with PHY quirks.  Resetting with the iMX6 in the
> wrong state may result in the AR8035 being reconfigured (even jumping
> to a different MDIO address) and certainly would need the PHY quirks
> re-running.
> 
As far as I can tell, all SolidRun boards do not specify the enet_out
clock in the dtb, so the PHY reset behaviour should be unaffected by
this patch on those boards, since the additional fec_reset_phy() call is
framed by:
if (fep->clk_enet_out) {
	...
}

But verifying this explicitly is of course a good idea.


Lothar Wa?mann

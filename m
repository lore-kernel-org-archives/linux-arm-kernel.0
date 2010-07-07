From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 07 Jul 2010 10:02:42 -0400 (EDT)
Subject: [PATCH 11/15] wireless: wl1271: introduce platform device support
In-Reply-To: <4C34347F.8030000@nokia.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com>
	<4C32EF19.1000604@nokia.com>
	<AANLkTintIz-N7MwwtqhVq2LR3Ln5JTNYSbJUBSSClcA-@mail.gmail.com>
	<4C3306F4.8060907@nokia.com>
	<AANLkTin5W52fPzWToRrAzm56SLZI-taSuI16rCEhLWqH@mail.gmail.com>
	<4C333E0D.2070601@nokia.com>
	<alpine.LFD.2.00.1007061316010.6020@xanadu.home>
	<4C338927.5020400@nokia.com> <4C34347F.8030000@nokia.com>
Message-ID: <alpine.LFD.2.00.1007070954010.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Jul 2010, Roger Quadros wrote:

> On 07/06/2010 10:51 PM, Hunter Adrian (Nokia-MS/Helsinki) wrote:
> > For eMMC in omap_hsmmc, this is all done via claim_host / release_host
> > which call ->enable() / ->disable() methods.  omap_hsmmc makes use of
> > mmc_power_restore_host() which calls host->bus_ops->power_restore()
> > which is not implemented for SDIO, but for MMC and SD it reinitializes
> > the card.

This is IMHO a really bad design.  The power control decision has to 
come from the top, not from the bottom.  And certainly not with a 
U-turn dependency the omap_hsmmc is using.

I regret to say this, but the omap_hsmmc driver is becoming a total 
mess.  The host controller driver has to be a dumb interface serving 
requests from the hardware used by the upper layer stack, not the place 
where decisions such as power handling should be made.  Think of it like 
an ethernet driver.  No ethernet driver in Linux is telling the IP stack 
when to shut down.

> Shouldn't the power control intelligence (i.e. when to turn power ON/OFF) lie
> with the bus drivers?

Absolutely!  And in the SDIO case that should lie with each function 
drivers.  Please let's stop this omap_hsmmc madness.


Nicolas

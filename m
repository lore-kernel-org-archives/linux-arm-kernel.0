From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 15:09:04 +0200
Subject: [PATCH 0/1] new module for amba axi on-chip interconnect
In-Reply-To: <20110329181947.GA18134@flint.arm.linux.org.uk>
References: <1301391619-4499-1-git-send-email-arend@broadcom.com>
	<20110329181947.GA18134@flint.arm.linux.org.uk>
Message-ID: <201103301509.04899.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2011, Russell King wrote:
> On Tue, Mar 29, 2011 at 11:40:18AM +0200, Arend van Spriel wrote:
> > GUIDANCE NEEDED:
> > This patch puts the module at proposed location. Please provide your
> > guidance if there is a better location within the linux tree for this
> > module.
> > 
> > This module has been isolated from the brcm80211 driver currently
> > located in staging and provided to other drivers for chipsets using
> > the AMBA AXI on-chip interconnect with ARM Device Management Plugin
> > (DMP) silicon IP, which provides system discovery (chip being the
> > system) and basic core function (disable, reset, etc.).
> 
> What does this do which the 'amba' bus support doesn't?

I believe the one thing we really want from this driver is the bus
scan code, which is not present in the amba bus implementation,
as far as I can tell. Today, the amba bus does very little beyond
what the platform bus does, in particular you still need to
register every single device from board specific code.

When the proposed axi_scan() function gets turned into an
amba_bus_register() function, a board file can call that to
add all devices on the bus without listing them individually
and calling amba_device_register() for each one.

Basically everything else is already there in the amba bus,
no need to do it again.

	Arnd

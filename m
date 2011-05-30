From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 30 May 2011 08:55:47 +0300
Subject: [PATCHv2 2/2] OMAP: add omap_device_reset()
In-Reply-To: <alpine.DEB.2.00.1105292022080.8973@utopia.booyaka.com>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
	<1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>
	<4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari>
	<alpine.DEB.2.00.1105292022080.8973@utopia.booyaka.com>
Message-ID: <1306734947.2117.9.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-05-29 at 20:24 -0600, Paul Walmsley wrote:
> Hi Tomi,
> 
> On Fri, 27 May 2011, Tomi Valkeinen wrote:
> 
> > DSS driver has been designed so that it resets the HW before it begins
> > programming it. That way we get the HW into known state. Otherwise we
> > need to be extra careful to program all possible registers to a sane
> > value. Not impossible, of course, but requires extra work.
> > 
> > I noticed the problem with DSI driver, it didn't work anymore if I
> > didn't reset it.
> 
> One thing that I don't quite understand about this thread is that the 
> hwmod code should be resetting the DSS hwmods when the system boots.  Is 
> something not working with this process?

I believe that is working fine.

The problem appears when DSS is turned off (i.e. the screen is blanked)
and then started again. The driver has been written so that it will
reset the DSS HW before starting to use that particular DSS HW block, to
get a clean state. Remove that reset, and we've got all the old register
values lying around, causing the device to malfunction.

This should be fixable in the driver, of course, although my experience
with DSI (and DSS in general) shows that it's not always very easy to
stop and restart the HW without a reset.

However, I'd still argue that a driver is more robust if it does do a
reset when starting up the HW. Perhaps the driver should be developed
without that reset, but in the production device the reset should give
us extra protection for unexpected situations.

> That is a separate case from the error recovery case.  Sounds like we may 
> need to expose a reset function for that purpose as well.  Tomi, I don't 
> think your proposed patch is enough for this, though: we'd also need to 
> reset the hwmod internal state for that module, and reprogram the 
> SYSCONFIG bits, etc. as mach-omap2/omap_hwmod.c:_setup() does.

Ah, ok, sounds right. It worked for me, but I probably wouldn't notice
if the PM bits in SYSCONFIG are wrong, as I didn't do any PM testing.

 Tomi

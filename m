From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Jan 2014 14:09:23 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140120115919.GD26823@intel.com>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
 <20140120123849.GC15937@n2100.arm.linux.org.uk>
 <20140120115919.GD26823@intel.com>
Message-ID: <20140120130923.GP16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 05:29:20PM +0530, Vinod Koul wrote:
> On Mon, Jan 20, 2014 at 12:38:50PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 20, 2014 at 12:36:27PM +0100, Lothar Wa?mann wrote:
> > > In case user space firmware loading support (CONFIG_FW_LOADER) is
> > > enabled, this message may still be inadequate, since the firmware may
> > > very well be loaded lateron.
> > 
> > I haven't worked out whether that's actually possible - I saw no way to
> > re-trigger the firmware request, and once the firmware request expires,
> > there seems to be no way for userspace to say "okay, the firmware is now
> > available, please load it".
> In that case why don't we use async version and wait till the userspace is
> availble and firmware is loaded. 
> 
> So request_firmware_nowait() seems to do the job, I have used in a device where
> I call it in probe() so that not to slow booting and make firmware bloc availble
> userpsace is availble.
> 
> Sounds too good, did I miss anything obvious for this case here?

Been there, done that. This would make the RAM Firmware mandatory.

The Linux firmware loading mechanism is not very suitable for the SDMA
engine. The firmware loading mechanism expects that a driver cannot work
without a firmware. Normally this is true, but The SDMA engine can run
with the ROM firmware or a RAM firmware loaded during runtime. In fact
the firmware consists of Program code, so the SDMA engine could even run
with a combination of the ROM firmware and 0..n dynamically loaded
firmware modules.

Maybe using the firmware loading mechanism for the SDMA engine was the
wrong approach from the start.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

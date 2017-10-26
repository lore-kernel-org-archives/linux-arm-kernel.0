From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 26 Oct 2017 11:31:15 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171026091325.GA26929@amd>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
Message-ID: <20171026093115.4bc6ctxjx72ng7ld@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 26, 2017 at 11:13:26AM +0200, Pavel Machek wrote:
> On Wed 2017-10-25 14:28:07, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [171025 13:36]:
> > > Hi!
> > > 
> > > ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> > > both. 4.13-rc2 with display and clock patches boots on phone "S", but
> > > does not on phone "P"; nothing nothing is received on serial port.
> > > 
> > > There is some difference in the bootloaders: S's bootloader provides
> > > lots of debug info, P's is silent. R&D settings do _not_ have
> > > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > > prints "Uncompressing linux...booting" there.
> > > 
> > > I'll need to return "S" phone and serial cable tommorow. If you have
> > > any ideas, let me know.
> > 
> > If you get nothing out of the uart, chances are the pins are
> > not muxed for the uart in nolo and maybe kernel dts is missing the
> > pinctrl entries for uart?
> > 
> > Also try booting with mem=512M at 0x80000000 or 256M or 768M. Maybe the
> > memory is different size or partially broken?
> 
> Uhuh. It looks like "P" nokia really wants initrd, otherwise it will
> not boot.
> 
> I got "uncompressing Linux 4.13" on serial console now, debug LEDs
> blinking, and if I use a flashlight, I see output on the screen, too.
> 
> (What do I need to do to get the backlight working?)

Glad you got it working :) For backlight you can add this
in drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c:

add the following code at the end of dsicm_probe:

-----------------------------------------------------------
mutex_unlock(&ddata->lock);
mutex_lock(&ddata->lock);
ddata->in->ops.dsi->bus_lock(ddata->in);
r = dsicm_wake_up(ddata);
if (!r)
    r = dsicm_dcs_write_1(ddata, DCS_BRIGHTNESS, 100);
ddata->in->ops.dsi->bus_unlock(ddata->in);
mutex_unlock(&ddata->lock);
-----------------------------------------------------------

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171026/8e17bd8b/attachment.sig>

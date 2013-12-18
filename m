From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 18 Dec 2013 15:54:42 +0200
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131218120023.GG4360@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
Message-ID: <52B1A922.6020901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-18 14:00, Russell King - ARM Linux wrote:

> So, here goes.  LDP3430:
> 
> OMAP DSS rev 2.0
> omapdss DPI error: can't get VDDS_DSI regulator
> omapfb omapfb: failed to connect default display
> omapfb omapfb: failed to init overlay connections
> omapfb omapfb: failed to setup omapfb
> platform omapfb: Driver omapfb requests probe deferral
> 
> I don't see evidence of it being re-probed, but I do see this during boot
> which implies that there's nothing there:
> 
> XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"
>       after 0 requests (0 known processed) with 0 events remaining.

I don't have an LDP board at hand, and I wasn't able to find out anything from
the logs.

I think I should change omapfb to print something if it's probed succesfully,
as the deferred probing makes finding out if something is probed fine or not
quite murky. Without deferred probing, it was simpler: no errors -> the driver
must be (most likely) ok.

Although... In an earlier log, where there was no panel driver, the log has
these errors:

Error opening /dev/fb0: No such device

There are none in the latest log, which makes me guess the omapfb has been
probed, and fb0 is actually there. But the X is still dying for some reason...

I'll look at this more. Maybe someone in our team can find a board to test.
 
> For the SDP4430, it used to detect the displays, even though nothing has
> ever been displayed on them.  Now it just spits out this:

Those particular LCDs are supposed to be updated manually using custom ioctl,
so normal software using fb won't put anything on the display. For testing
purposes, a SW based automatic update (~20 fps) can be enabled by kernel
cmdline parameter "omapfb.auto_update" or via sysfs:

echo 1 > /sys/class/graphics/fb0/update_mode

> OMAP DSS rev 4.0
> omapdss DSI error: can't get VDDS_DSI regulator
> panel-dsi-cm panel-dsi-cm.0: Failed to connect to video source
> omapfb omapfb: failed to connect default display
> omapfb omapfb: failed to init overlay connections
> omapfb omapfb: failed to setup omapfb
> platform omapfb: Driver omapfb requests probe deferral
> ...
> omapdss DSI error: failed to set complexio power state to 1
> panel-dsi-cm panel-dsi-cm.0: failed to enable DSI
> omapfb omapfb: Failed to enable display 'lcd'
> omapfb omapfb: failed to initialize default display
> omapfb omapfb: failed to setup omapfb

Commit e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 (ARM: OMAP2+: Remove legacy mux
code for display.c) was overly enthusiastic in removing legacy code which was
already in use. Tony has a partial revert for that queued up. It can also be
reverted fully for testing. After that, the panel wakes up.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/db863376/attachment.sig>

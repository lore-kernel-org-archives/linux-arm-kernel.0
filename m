From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Oct 2013 10:34:48 +0100
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131021091259.GB9716@S2101-09.ap.freescale.net>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <20131017203545.GV25034@n2100.arm.linux.org.uk>
 <20131019121218.GH25034@n2100.arm.linux.org.uk>
 <20131021091259.GB9716@S2101-09.ap.freescale.net>
Message-ID: <20131021093448.GX25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 05:13:03PM +0800, Shawn Guo wrote:
> On Sat, Oct 19, 2013 at 01:12:18PM +0100, Russell King - ARM Linux wrote:
> > The other issue is that the set_rate() functions don't wait for the PLL
> > to lock before returning, and don't set bypass mode.  It looks like this
> > code relies on drivers unpreparing the clocks before calling clk_set_rate().
> > I don't see the clk API enforcing this in any way, so I'd suggest that
> > the set_rate() function also does the bypass -> set rate -> wait lock
> > -> clear bypass transition too.  Maybe this should be applied to the
> > other PLLs too.
> 
> Yes.  We experienced the problem when upgrading FSL kernel tree to 3.10.
> The .set_rate() should wait for LOCK bit, but does not need to touch
> BYPASS.

However, the IPU is more stable with switching to bypass while it relocks
than not.

> > Here's a diff which updates the av PLL to do this:
> 
> Some other PLLs needs update too.  I will cook up patches to fix these
> problems.

Yes, I only changed the set_rate on the AV codecs as I haven't tested
that on the others.

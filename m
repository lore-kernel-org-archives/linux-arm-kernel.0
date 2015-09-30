From: balbi@ti.com (Felipe Balbi)
Date: Wed, 30 Sep 2015 09:12:09 -0500
Subject: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
In-Reply-To: <4815825.NCBBBMgLGf@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-12-git-send-email-balbi@ti.com>
 <4815825.NCBBBMgLGf@wuerfel>
Message-ID: <20150930141209.GB31865@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 10:15:25AM +0200, Arnd Bergmann wrote:
> On Tuesday 29 September 2015 15:44:06 Felipe Balbi wrote:
> > All devices should have a default status. Ignoring
> > the arguments if it should be 'okay' or 'disabled'
> > by default, let's set them all the 'disabled' and
> > have boards enable 32k counter.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > 
> 
> The patch looks good, but the description is slightly incorrect:
> There is no reason to list "status='okay'" other than overriding
> the 'disabled' status.
> 
> I'd phrase it something like:
> 
> "We want the use of the 32k counter to be a per-board setting,
> so let's disable it by default in each dtsi file and override the
> setting in the boards. Any board that does not wire up the counter
> should leave it disabled".
> 
> However, if you really want all boards to provide the counter all
> the time, I'd argue that we're better off dropping this patch. We
> use the status="disabled" trick for anything that may or may not
> be working based on the board design, but things that are present
> everywhere don't need this.

okay, so here's the thing. While fiddling with the 32k counter, I noticed
that even though there was no status listed, the thing still initializes
fine. However, when moving 32k to drivers/clocksource and using
CLOCKSOURCE_OF_DECLARE(), 32k would *NOT* probe unless I had an explicit
status = "okay" in DT.

This is where this patch came from. I've used disabled by default
because we just might have a board somewhere which doesn't want to use 32k
counter and having it enabled per-board would help with that. Although,
we could just set status = "disabled" for that one board.

Whatever Tony prefers, I can change the patch accordingly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/2d2d868d/attachment.sig>

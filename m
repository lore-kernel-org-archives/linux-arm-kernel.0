From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Jun 2012 03:47:20 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Fix MUSB ifdefs for platform init code
In-Reply-To: <20120622101533.GC28472@arwen.pp.htv.fi>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
 <20120613101506.18645.98406.stgit@muffinssi.local>
 <20120622101533.GC28472@arwen.pp.htv.fi>
Message-ID: <20120625104720.GC12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120622 03:22]:
> On Wed, Jun 13, 2012 at 03:15:06AM -0700, Tony Lindgren wrote:
> > Commit 62285963 (usb: musb: drop a gigantic amount of ifdeferry)
> > got rid of a bunch of ifdefs in the MUSB code. Looks like the
> > platform init code is still using these dropped defines though,
> > which in many cases results the board defaulting always to host
> > mode.
> > 
> > Currently the situation is that USB_MUSB_HDRC is the main
> > Kconfig option with additional USB_GADGET_MUSB_HDRC so only
> > these two should be used to select between host and OTG mode.
> > 
> > Fix the situation for omaps. The following users should fix the
> > platform init code in a similar way:
> > 
> > Dropped Kconfig option          Current users
> > 
> > USB_MUSB_OTG                    blackfin, davinci, not in Kconfigs
> > USB_MUSB_PERIPHERAL             davinci, not in Kconfigs
> > USB_MUSB_HOST                   davinci, not in Kconfigs
> > USB_MUSB_HDRC_HCD               blackfin, not in Kconfigs
> > USB_MUSB_OTG                    blackfin, not in Kconfigs
> > 
> > Cc: Mike Frysinger <vapier@gentoo.org>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: linux-usb at vger.kernel.org
> > Cc: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Looks ok, though I would stick to things boards are wired to do. e.g.:
> 
> all development boards are wired for OTG (with a few exceptions),
> n800 is peripheral only
> n810 is OTG
> 
> and so on. That way you remove all the clutter.

FYI, these got already merged last week as fixes because of the
broken Kconfig options.

What you're suggesting sounds like a good follow-up patch to improve
things, although I suggest that we remove CONFIG_USB_GADGET_MUSB_HDRC
ifdef else from board-*.c files, and always set host = MUSB_OTG.

For example, both n800 and n810 are wired up the same way except for
the mini-B vs mini-AB connector. The connector alone should be enough
to keep n800 as peripheral unless somebody specifically wants to force
it into host mode by using a non-standard cable or the debug options.

AFAIK, this same logic should apply to all the devices, or do you
see issues with it?

Regards,

Tony

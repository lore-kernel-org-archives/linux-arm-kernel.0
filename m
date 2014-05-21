From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 21 May 2014 16:24:59 +0200
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <537CA4B4.2040001@ti.com>
References: <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com> <537A540E.8070302@ti.com>
 <20140519195100.GB11945@atomide.com> <537CA4B4.2040001@ti.com>
Message-ID: <20140521142459.GB27779@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 21, 2014 at 04:05:56PM +0300, Tomi Valkeinen wrote:
> I'll try and see how the other options work, which are:
> 
> - Bailing out from module_init in each display driver. The reason I
> don't like this (although I haven't tried it) is that all the display
> drivers need the modification, and because I need to catch the
> module_init, I cannot use the helpers like module_platform_driver(), so
> it adds multiple lines to every driver.

You could create your own omapdss_driver() define for that.
This can be replaced more simply once no longer needed and
creates less bloat.

I see one more disadvantage for this approach:

assumed situation (some future 3.16+x kernel):
 * The kernel has an common display framework (CDF)
 * The kernel has an panel driver using CDF
 * There also exists omapdss driver for the same panel
 * omapdss does not (yet) adopt CDF
 * CDF and omapdss are enabled in .config
 * Kernel is booted from an OMAP system

This would result in both drivers being loaded using the same
DT compatible string. The same scenario works using the rewriting
method, since the common display framework would only see the
rewritten compatible string.

Of course this scenario only happens when omapdss is not adopted
to the common display framework from the start on.

> - Traveling the video graph, starting from omapdss. This one is possibly
> better performance-wise than my original version, as we only need to
> search for the omapdss node and can then follow the links. But the code
> will be more complex.

I think the main advantage is the missing lookup table/whitelist,
which adds redundancy. Not having it has some advantages:

* new drivers don't need to touch any existing files (making
  rebasing etc. easier)
* table can get out of sync (though that shouldn't happen anyway,
  since the binding is supposed to be stable)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/fae26241/attachment.sig>

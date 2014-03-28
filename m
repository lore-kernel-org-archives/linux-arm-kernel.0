From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 20:54:03 +0000
Subject: [PATCH 32/75] ARM: l2c: implement L2C-310 erratum 588369 as a
 method override
In-Reply-To: <CAL_JsqJc83QhK2zpYdT9XoU0_wOv7Dm31Ew0Mh6e68f9YU8O7w@mail.gmail.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYWp-0007F1-Tq@rmk-PC.arm.linux.org.uk>
 <CAL_JsqJc83QhK2zpYdT9XoU0_wOv7Dm31Ew0Mh6e68f9YU8O7w@mail.gmail.com>
Message-ID: <20140328205402.GR7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:41:46PM -0500, Rob Herring wrote:
> On Fri, Mar 28, 2014 at 10:17 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Implement L2C-310 erratum 588369 by overriding the invalidate range
> > and flush range methods in the outer_cache operations structure.
> > This allows us to sensibly contain the erratum code in one place
> > without affecting other locations/implemetations.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> 
> [snip]
> 
> > @@ -600,9 +659,19 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
> >         const char *errata[4];
> >         unsigned n = 0;
> >
> > +       /* For compatibility */
> 
> Compatibility of what?  This needs a better comment.
> 
> >         if (revision <= L310_CACHE_ID_RTL_R3P0)
> >                 fns->set_debug = l2c310_set_debug;

With the way the existing code works with the set_debug method.  You
may notice that this comment and code is removed in "ARM: l2c: remove
old .set_debug method".

> >
> > +       if (IS_ENABLED(CONFIG_PL310_ERRATA_588369) &&
> > +           revision < L310_CACHE_ID_RTL_R2P0 &&
> > +           /* For compatibility */
> 
> same here.
> 
> > +           fns->inv_range == l2x0_inv_range) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
hint - the comment is above the code which it applies to in both cases.

It's referring to those which don't have a .inv_range of that, but are
L2C-310.  Well, there's Broadcom's implementation which thankfully is
R3 or later, though I later dropped the call to this function from
the Broadcom stuff since I had confirmation that it was of a sufficiently
modern version not to need any errata workarounds at all.


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Sep 2014 13:10:51 +0100
Subject: [PATCH v5 4/7] ARM: l2c: Add support for overriding prefetch
 settings
In-Reply-To: <5422A8D1.1000507@gmail.com>
References: <1411556741-5810-1-git-send-email-m.szyprowski@samsung.com>
 <1411556741-5810-5-git-send-email-m.szyprowski@samsung.com>
 <20140924111446.GE5729@leverpostej> <5422A8D1.1000507@gmail.com>
Message-ID: <20140924121051.GF5729@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 12:19:45PM +0100, Tomasz Figa wrote:
> On 24.09.2014 13:14, Mark Rutland wrote:
> > On Wed, Sep 24, 2014 at 12:05:38PM +0100, Marek Szyprowski wrote:
> >> From: Tomasz Figa <t.figa@samsung.com>
> >>
> >> Firmware on certain boards (e.g. ODROID-U3) can leave incorrect L2C prefetch
> >> settings configured in registers leading to crashes if L2C is enabled
> >> without overriding them. This patch introduces bindings to enable
> >> prefetch settings to be specified from DT and necessary support in the
> >> driver.
> >>
> >> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/l2cc.txt | 10 +++++++
> >>  arch/arm/mm/cache-l2x0.c                       | 39 ++++++++++++++++++++++++++
> >>  2 files changed, 49 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> >> index af527ee111c2..3443d2d76788 100644
> >> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> >> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> >> @@ -47,6 +47,16 @@ Optional properties:
> >>  - cache-id-part: cache id part number to be used if it is not present
> >>    on hardware
> >>  - wt-override: If present then L2 is forced to Write through mode
> >> +- arm,double-linefill : Override double linefill enable setting. Enable if
> >> +  non-zero, disable if zero.
> >> +- arm,double-linefill-incr : Override double linefill on INCR read. Enable
> >> +  if non-zero, disable if zero.
> >> +- arm,double-linefill-wrap : Override double linefill on WRAP read. Enable
> >> +  if non-zero, disable if zero.
> >> +- arm,prefetch-drop : Override prefetch drop enable setting. Enable if non-zero,
> >> +  disable if zero.
> > 
> > I'm not too keen on tristate properties. Is this level of flexibility
> > really required?
> > 
> > What exact overrides do you need for boards you know of? Why do these
> > cause crashes if not overridden?
> 
> Well, this is all thanks to broken firmware, which doesn't initialize
> those values properly on certain systems and they must be overridden. On
> the other side, there are systems with firmware that does it correctly
> and for those the boot defaults should be preferred. I don't see any
> other reasonable option of handling this.

With the lack of warnings for present but empty properties, I can forsee
people placing empty properties (as the names make them sound like
booleans which enable features).

Surely for enabling/disabling options we should only need to override
one-way, disabling a feature that causes breakage for some reason?
Otherwise we can keep the reset value (which might be sub-optimal).

Perhaps a simple warning is sufficient if the property exists but is
empty.

> As for why they cause crashes, I'm not an expert if it is about L2C
> internals, so I can't really tell, but apparently the cache can work
> correctly only on certain settings.

Likewise, I'm no expert on the l2x0 family. It would be nice to know if
this justs masks an issue elsewhere in Linux, is required for some
reason by the interconnect, etc. I guess we don't have enough
information to figure that out.

Mark.

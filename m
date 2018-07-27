From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Jul 2018 11:51:36 +0100
Subject: [PATCH 5/6] ARM: spectre-v1: use get_user() for __get_user()
In-Reply-To: <20180726131937.GX17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctP5-0005vM-MA@rmk-PC.armlinux.org.uk>
 <20180726124401.3gsvqk244753u72g@lakrids.cambridge.arm.com>
 <20180726131937.GX17271@n2100.armlinux.org.uk>
Message-ID: <20180727105135.iwgrsf2in4dzcygw@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 02:19:37PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 26, 2018 at 01:44:01PM +0100, Mark Rutland wrote:
> > On Tue, Jul 10, 2018 at 03:14:07PM +0100, Russell King wrote:
> > > Fixing __get_user() for spectre variant 1 is not sane: we would have to
> > > add address space bounds checking in order to validate that the location
> > > should be accessed, and then zero the address if found to be invalid.
> > > 
> > > Since __get_user() is supposed to avoid the bounds check, and this is
> > > exactly what get_user() does, there's no point having two different
> > > implementations that are doing the same thing.  So, when the Spectre
> > > workarounds are required, make __get_user() an alias of get_user().
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > I believe that we need to do likewise for __put_user(), given
> > spectre-v1.1.
> 
> Spectre v1.1 is not covered by this patch series.

Ok; given that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As an aside, on arm64 we always do the full checks in __*_user() since
this also hardens against missing/bad access_ok() checks when PAN is not
in use.

As a future thing, it might be worth having the option to always perform
the full checks.

Mark.

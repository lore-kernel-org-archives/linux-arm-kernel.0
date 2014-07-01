From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 15:40:11 +0100
Subject: [PATCH v3 0/8] component helper improvements
Message-ID: <20140701144011.GU32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A while back, Laurent raised some comments about the component helper,
which this patch set starts to address.

The first point it addresses is the repeated parsing inefficiency when
deferred probing occurs.  When DT is used, the structure of the
component helper today means that masters end up parsing the device
tree for each attempt to re-bind the driver.
									        
We remove this inefficiency by creating an array of matching data and
functions, which the component helper can use internally to match up
components to their master.

The second point was the inefficiency of destroying the list of
components each time we saw a failure.	We did this to ensure that
we kept things correctly ordered: component bind order matters.
As we have an array instead, the array is already ordered, so we
use this array to store the component pointers instead of a list,
and remember which are duplicates (and thus should be avoided.)
Avoiding the right duplicates matters as we walk the array in the
opposite direction at tear down.

I hope that this is the final submission in patch form.  Ultimately,
these patches need to be handled carefully:

Patch		Trees
1, 2, 3		Driver, Staging, DRM
4		Driver, DRM
5		Driver, Staging
6, 7, 8		To be held back until all users are updated (Exynos DRM)

 drivers/base/component.c               | 249 ++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/msm_drv.c          |  83 +++++------
 drivers/staging/imx-drm/imx-drm-core.c |  57 +-------
 include/linux/component.h              |   8 +-
 4 files changed, 208 insertions(+), 189 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

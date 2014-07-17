From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Jul 2014 11:51:05 -0400
Subject: [PATCH] irqchip: gic: Fix core ID calculation when topology is
 read from DT
In-Reply-To: <53C7EE82.6040803@samsung.com>
References: <1405610624-18722-1-git-send-email-t.figa@samsung.com>
 <20140717153236.GS13108@titan.lakedaemon.net>
 <53C7EE82.6040803@samsung.com>
Message-ID: <20140717155105.GT13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 05:40:50PM +0200, Tomasz Figa wrote:
> Hi Jason,
> 
> On 17.07.2014 17:32, Jason Cooper wrote:
> > On Thu, Jul 17, 2014 at 05:23:44PM +0200, Tomasz Figa wrote:
> >> Certain GIC implementation, namely those found on earlier, single
> >> cluster, Exynos SoCs, have registers mapped without per-CPU banking,
> >> which means that the driver needs to use different offset for each CPU.
> >>
> >> Currently the driver calculates the offset by multiplying value returned
> >> by cpu_logical_map() by CPU offset parsed from DT. This is correct when
> >> CPU topology is not specified in DT and aforementioned function returns
> >> core ID alone. However when DT contains CPU topology, the function
> >> changes to return cluster ID as well, which is non-zero on mentioned
> >> SoCs and so breaks the calculation in GIC driver.
> >>
> >> This patch fixes this by masking out cluster ID in CPU offset
> >> calculation so that only core ID is considered. Multi-cluster Exynos
> >> SoCs already have banked GIC implementations, so this simple fix should
> >> be enough.
> >>
> >> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> >> ---
> >>  drivers/irqchip/irq-gic.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > iiuc, this was introduced by:
> > 
> >   db0d4db22a78d ARM: gic: allow GIC to support non-banked setups
> > 
> > and so should be for v3.3 and up, correct?
> 
> Could be, although there was and still is no topology data specified in
> DT for affected Exynos SoCs. The need for it showed up just recently, so
> I'm not sure this is a regression to fix in older kernels.

In my "the kernel and the dtb aren't tied together" quest, these are the
kinds of things I like to see fixed in stable kernels.

If a user needs to update a dtb, say to fix a bug, it's reasonable to
use the newest one for a given board.  After all, any new nodes won't
change anything, since the driver in the kernel won't match the node.

However, in this case, without this fix, a user upgrading to the newest
dtb would get a broken system.  So, this fix should be backported to
prevent the breakage.  Or, have I missed something in my analysis?

thx,

Jason.

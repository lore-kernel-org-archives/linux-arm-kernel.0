From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 24 Jan 2013 11:08:03 -0600
Subject: OMAP4 randconfig failure: Zynq
In-Reply-To: <20130124161211.GX23505@n2100.arm.linux.org.uk>
References: <20130124111117.GU23505@n2100.arm.linux.org.uk>
 <20130124155704.GJ11970@beefymiracle.amer.corp.natinst.com>
 <20130124160609.GW23505@n2100.arm.linux.org.uk>
 <20130124161211.GX23505@n2100.arm.linux.org.uk>
Message-ID: <20130124170803.GA1036@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 04:12:11PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 24, 2013 at 04:06:09PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Jan 24, 2013 at 09:57:04AM -0600, Josh Cartwright wrote:
> > > On Thu, Jan 24, 2013 at 11:11:17AM +0000, Russell King - ARM Linux wrote:
> > > > The OMAP4 randconfig build last night failed with this error:
> > > > 
> > > > arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)
> > > > 
> > > > Full details at the usual place - 
> > > > http://www.arm.linux.org.uk/developer/build/
> > > 
> > > Curious.  This doesn't look like a valid config to me.
> > 
> > I think you're wrong.

Yes, indeed.  I was running my tests using the wrong tree.  I can see
this issue in today's linux-next.  Sorry for the noise.

[..]
>
> And what's missing is _specific_ to Zynq.  Let's look at the error again:
>
> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)
>
> What it means is that the "irqchip_init" identifier was not declared by
> anything before it has been used.  That means arch/arm/mach-zynq/common.c
> is missing a required #include statement.
>
> irqchip_init can be found in linux/irqchip.h.  Does arch/arm/mach-zynq/common.c
> include this required include?  No.  Therefore, the build fails with the
> above error.
>
> You need to add this include file...

Agreed, thanks.  Looks like this was introduced with "ARM: use common
irqchip_init for GIC init".  Here's a patch to fix it up, it probably
makes sense to be pulled into Rob's irqchip/gic-vic-move branch.

-- 8< --
Subject: [PATCH] ARM: zynq: include irqchip.h to prevent build failure

Commit 0529e315bbda5d502c93df2cfafba9bb337fbdf4 ("ARM: use common irqchip_init
for GIC init") converts Zynq to make use of irqchip_init, but fails to
include linux/irqchip.h.  Fixes this build error:

   arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)

Reported-by: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 8513b16..8a0b8ab 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/clk/zynq.h>
+#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-- 
1.8.1.1

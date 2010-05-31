From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 31 May 2010 08:20:13 +0100
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <AANLkTim3YdK3QDXC-20otTBPqYF_XX9rGHRX50cycqk6@mail.gmail.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
	<AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
	<AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
	<1275259589.22752.14.camel@e102109-lin.cambridge.arm.com>
	<AANLkTim4e5Sdj9tronOiI-sIMVGaUQdfRIhKHzZ4XfKp@mail.gmail.com>
	<AANLkTim3YdK3QDXC-20otTBPqYF_XX9rGHRX50cycqk6@mail.gmail.com>
Message-ID: <1275290414.2843.11.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-31 at 02:16 +0100, Bjoern Brandenburg wrote:
> On Sun, May 30, 2010 at 9:04 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> > On Sun, May 30, 2010 at 6:46 PM, Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> >> On Sun, 2010-05-30 at 22:38 +0100, Bjoern Brandenburg wrote:
> >>> On Sun, May 30, 2010 at 5:05 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> >>> > On Sun, May 30, 2010 at 3:27 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> >>> >>
> >>> >> I'll try to see if I can pinpoint what was dropped between 2.6.33-arm1
> >>> >> and 2.6.34-arm.
> >>> >
> >>> > Progress: I can get 2.6.34-arm to boot with all 4 CPUs after
> >>> > cherry-picking the following commits (which seemed relevant but
> >>> > absent):
> >>> >
> >>> > 60060ca ARM: Handle instruction cache maintenance fault  properly
> >>> > 3f64e83 ARM errata: Eviction Buffer not empty after Cache Sync on L220
> >>> > 3b009b5 ARM: change definition of cpu_relax() for ARM11MPCore
> >>> >
> >>> > Let's see which is the critical one...
> >>>
> >>> It's 3f64e83 "ARM errata: Eviction Buffer not empty after Cache Sync
> >>> on L220" [1]. With this commit cherry-picked (on top of the 'rebased'
> >>> branch in ARM's repository, i.e., 2.6.34-arm), the system boots to X11
> >>> and runs some simple FS tests; the other ones don't make a difference.
> >>>
> >>> Are there plans for getting this and the other patches in the
> >>> 'rebased' branch into mainline (for .35 or .36)?
> >>
> >> Thanks for the investigation. I recall I got something similar in the
> >> past though I could no longer reproduce it with 2.6.34 (-arm) on the
> >> PB11MPCore I have. Could you try reverting commit e7c5650f606 (ARM:
> >> Change the mandatory barriers implementation) on a vanilla 2.6.34
> >> kernel?
> >
> > That doesn't seem to help. v2.6.34 with e7c5650f606 reverted still hangs.
> 
> Given that 2.6.34-arm contains patches for missing synchronization
> primitives in the network driver, it is maybe not too surprising that
> the vanilla kernel won't boot with an NFS root file system.
> 
> I just tried 2.6.34-arm (i.e., the 'rebased' branch in the ARM repo)
> with e7c5650f606 reverted (and without cherry-picking 3f64e83)   and
> that kernel boots ok!

OK. So the L220 erratum I had in mind was 425331 (Potential deadlock in
certain system configurations if Write Buffer not empty when specific
maintenance operations are received) though doesn't seem to apply to
this revision of the L220. I'll try to get more information tomorrow and
maybe make the e7c5650f606 commit not apply to ARMv6 SMP systems (though
an L220 workaround would be better).

Regarding the SMSC 911x driver synchronisation - I've been asking SMSC
for more than a year to look into this. It fails on SMP systems without
my patch apply but SMSC states that such patch isn't needed. I even
consider reverting the RealView move to the new 911x driver. Something
like below (and make sure you enable the other smc911x.c driver):


Revert "arm: convert realview platform to use smsc911x"

From: Catalin Marinas <catalin.marinas@arm.com>

This reverts commit c5142e84f3a39c6396ce2ddde01b1e420a67464a.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/core.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index d5a9573..98fcacd 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -28,7 +28,7 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/io.h>
-#include <linux/smsc911x.h>
+#include <linux/smc911x.h>
 #include <linux/ata_platform.h>
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
@@ -151,15 +151,14 @@ int realview_flash_register(struct resource *res, u32 num)
 	return platform_device_register(&realview_flash_device);
 }
 
-static struct smsc911x_platform_config smsc911x_config = {
-	.flags		= SMSC911X_USE_32BIT,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
+static struct smc911x_platdata realview_smc911x_platdata = {
+	.flags		= SMC911X_USE_32BIT,
+	.irq_flags	= IRQF_SHARED,
+	.irq_polarity	= 1,
 };
 
 static struct platform_device realview_eth_device = {
-	.name		= "smsc911x",
+	.name		= "smc911x",
 	.id		= 0,
 	.num_resources	= 2,
 };
@@ -169,8 +168,8 @@ int realview_eth_register(const char *name, struct resource *res)
 	if (name)
 		realview_eth_device.name = name;
 	realview_eth_device.resource = res;
-	if (strcmp(realview_eth_device.name, "smsc911x") == 0)
-		realview_eth_device.dev.platform_data = &smsc911x_config;
+	if (strcmp(realview_eth_device.name, "smc911x") == 0)
+		realview_eth_device.dev.platform_data = &realview_smc911x_platdata;
 
 	return platform_device_register(&realview_eth_device);
 }



-- 
Catalin

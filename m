From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Feb 2013 17:47:31 +0000
Subject: [GIT PULL 4/4] mach-virt platform code for 3.9
In-Reply-To: <20130211172747.GA23212@quad.lixom.net>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-4-git-send-email-will.deacon@arm.com>
 <20130211172747.GA23212@quad.lixom.net>
Message-ID: <20130211174731.GO9801@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 05:27:47PM +0000, Olof Johansson wrote:
> On Mon, Feb 04, 2013 at 01:55:31PM +0000, Will Deacon wrote:
> > NOTE: I'm not suggesting you pull this one as it stands -- see below!
> > 
> > This is the last batch from me (Marc is dealing with vgic and virtual
> > timers) and introduces support for mach-virt. This depends on:
> > 
> > 	- for-arm-soc/arch-timers (third pull request in this series)
> > 	- for-rmk/virt/psci (already pulled)
> > 	- irqchip/gic-vic-move (an arm-soc branch)
> > 
> > As a result, the diffstat is atrocious so it would be better if you
> > could create a branch merging the above dependendies, which I could
> > rebase onto (there's actually only two patches here).
> 
> So, while the diffstats below look pretty bad, the actual new code is small and
> easy to get an overview when I pull them in.
> 
> I've staged this in a separate branch (next/virt), that pulls in all the
> dependencies first, then 3/4 and 4/4. It merges cleanly into our for-next as
> well, so this is looking great. It needs a fixup for sys_timer setup before I
> actually push it out merged though, so please send a patch over.

Great, thanks Olof. I've included a small patch to fix the sys_timer stuff
below.

Cheers,

Will

--->8

>From 6ff8d50c1d3b0adc5f5daf4d178b3b093096a0f1 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Mon, 11 Feb 2013 17:44:22 +0000
Subject: [PATCH] ARM: mach-virt: fixup machine descriptor after removal of sys_timer

Now that sys_timer has been removed, update the mach-virt machine
descriptor to use a direct pointer to its timer_init function.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-virt/virt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
index f6ed9cf..31666f6 100644
--- a/arch/arm/mach-virt/virt.c
+++ b/arch/arm/mach-virt/virt.c
@@ -43,15 +43,11 @@ static const char *virt_dt_match[] = {
 	NULL
 };
 
-static struct sys_timer virt_timer = {
-	.init = virt_timer_init,
-};
-
 extern struct smp_operations virt_smp_ops;
 
 DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
 	.init_irq	= irqchip_init,
-	.timer		= &virt_timer,
+	.init_time	= virt_timer_init,
 	.init_machine	= virt_init,
 	.smp		= smp_ops(virt_smp_ops),
 	.dt_compat	= virt_dt_match,
-- 
1.8.0

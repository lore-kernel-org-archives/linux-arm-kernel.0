From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Nov 2012 22:08:47 +0000
Subject: [GIT PULL] Calxeda ECX-2000 support
In-Reply-To: <50996725.2090003@gmail.com>
References: <50917936.2030405@gmail.com>
 <20121106191819.GA11353@quad.lixom.net> <50996725.2090003@gmail.com>
Message-ID: <201211062208.47390.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Rob Herring wrote:
> On 11/06/2012 01:18 PM, Olof Johansson wrote:
> > The addition of include of core.h in sysregs.h gives me a build error on
> > multi_v7_defconfig due to missing guard ifdefs. I've added the following
> > patch on top of your branch.
> > 
> Thanks, I didn't see that in my tree because I have follow-on patches
> removing this based on the DEBUG_LL clean-up. Now that the dependency
> from Stephen is in your tree, I need to send that to you as well.
> 

I've just added another patch on top to get around a build warning:

>From 5bd09fb0336aa4020b85f13e16a4d21e3f5f70c3 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Nov 2012 23:02:27 +0100
Subject: [PATCH] ARM: smp_twd: fix build warning

0336517b38c "ARM: smp_twd: don't warn on no DT node" introduced
a silly build warning by returning an error from a void function.
This keeps the intention of that patch but fixes the warning by
removing the error code

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 6ec73f9..999aa48 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -367,7 +367,7 @@ void __init twd_local_timer_of_register(void)
 
 	np = of_find_matching_node(NULL, twd_of_match);
 	if (!np)
-		return -ENODEV;
+		return;
 
 	twd_ppi = irq_of_parse_and_map(np, 0);
 	if (!twd_ppi) {

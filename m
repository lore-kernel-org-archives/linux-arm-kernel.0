From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  7 Mar 2018 14:20:33 +0100
Subject: [PATCH] ARM: ux500: Fix PMU IRQ regression
Message-ID: <20180307132033.4534-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
deleted some code to bounce and work around the weird PMU
IRQs in the DB8500 ASIC, but did a semantic mistake:
since the auxdata was now unused, the call to
of_platform_populate() was removed, but this does not
work: the default platform population will only kick in
if .init_machine() is assigned NULL, and since the U8540
was still using the callback that was not the case.

Fix this by reinstating the call to of_platform_populate(),
but pass NULL as auxdata.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 2b05f6ae1ee5 ("ARM: ux500: remove PMU IRQ bouncer")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please pick this up directly for fixed if
Mark is OK with the fix. It'd be nice to have in v4.16 since
it is a boot regression.
---
 arch/arm/mach-ux500/cpu-db8500.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 7e5d7a083707..36cd23c8be9b 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -133,6 +133,9 @@ static void __init u8500_init_machine(void)
 	if (of_machine_is_compatible("st-ericsson,u8540"))
 		of_platform_populate(NULL, u8500_local_bus_nodes,
 				     u8540_auxdata_lookup, NULL);
+	else
+		of_platform_populate(NULL, u8500_local_bus_nodes,
+				     NULL, NULL);
 }
 
 static const char * stericsson_dt_platform_compat[] = {
-- 
2.14.3

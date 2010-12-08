From: davidb@codeaurora.org (David Brown)
Date: Tue,  7 Dec 2010 16:42:56 -0800
Subject: [PATCH RFC] arm: Add argument to init_machine
Message-ID: <1291768976-7773-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM SOCs are used in numerous configurations.  While much of the
configuration is identical between these configuration, since it is
contained within the SOC, there will often be slight differences in
external hardware that is connected.

To reduce the number of machine_is_...() tests in the machine init
code, pass an agrument from the machine descriptor through to the init
function.

This adds 4-bytes to the kernel for every machine that is compiled in.
Machines that make use of the pointer will have additional data, which
will likely be offset by a reduction in runtime tests needed.

This version only modifies the Qualcomm board files.  The real patch
will modify all used board files.
---
I wanted to see what people thought of doing this in general for ARM.
We can get the same effect for some of our new targets by having short
individual functions that call another function with a different
pointer.

 arch/arm/include/asm/mach/arch.h   |    3 ++-
 arch/arm/kernel/setup.c            |    6 ++++--
 arch/arm/mach-msm/board-halibut.c  |    2 +-
 arch/arm/mach-msm/board-mahimahi.c |    2 +-
 arch/arm/mach-msm/board-msm7x27.c  |    2 +-
 arch/arm/mach-msm/board-msm7x30.c  |    2 +-
 arch/arm/mach-msm/board-qsd8x50.c  |    2 +-
 arch/arm/mach-msm/board-sapphire.c |    2 +-
 arch/arm/mach-msm/board-trout.c    |    2 +-
 9 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index d97a964..744db02 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -39,7 +39,8 @@ struct machine_desc {
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
-	void			(*init_machine)(void);
+	void			(*init_machine)(void *);
+	void			*init_machine_arg;
 };
 
 /*
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..01ec2f8 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -708,13 +708,14 @@ static struct init_tags {
 	{ 0, ATAG_NONE }
 };
 
-static void (*init_machine)(void) __initdata;
+static void (*init_machine)(void *) __initdata;
+static void *init_machine_arg __initdata;
 
 static int __init customize_machine(void)
 {
 	/* customizes platform devices, or adds new ones */
 	if (init_machine)
-		init_machine();
+		init_machine(init_machine_arg);
 	return 0;
 }
 arch_initcall(customize_machine);
@@ -875,6 +876,7 @@ void __init setup_arch(char **cmdline_p)
 	init_arch_irq = mdesc->init_irq;
 	system_timer = mdesc->timer;
 	init_machine = mdesc->init_machine;
+	init_machine_arg = mdesc->init_machine_arg;
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 75dabb1..9e1f3e5 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -73,7 +73,7 @@ static void __init halibut_init_irq(void)
 	msm_init_irq();
 }
 
-static void __init halibut_init(void)
+static void __init halibut_init(void *arg)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-msm/board-mahimahi.c b/arch/arm/mach-msm/board-mahimahi.c
index ef3ebf2..bde075f 100644
--- a/arch/arm/mach-msm/board-mahimahi.c
+++ b/arch/arm/mach-msm/board-mahimahi.c
@@ -48,7 +48,7 @@ static struct platform_device *devices[] __initdata = {
 	&msm_device_nand,
 };
 
-static void __init mahimahi_init(void)
+static void __init mahimahi_init(void *arg)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-msm/board-msm7x27.c b/arch/arm/mach-msm/board-msm7x27.c
index e7a76ef..9502422 100644
--- a/arch/arm/mach-msm/board-msm7x27.c
+++ b/arch/arm/mach-msm/board-msm7x27.c
@@ -80,7 +80,7 @@ static void __init msm7x2x_init_irq(void)
 	msm_init_irq();
 }
 
-static void __init msm7x2x_init(void)
+static void __init msm7x2x_init(void *arg)
 {
 	if (socinfo_init() < 0)
 		BUG();
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 05241df..8505b0f 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -51,7 +51,7 @@ static void __init msm7x30_init_irq(void)
 	msm_init_irq();
 }
 
-static void __init msm7x30_init(void)
+static void __init msm7x30_init(void *arg)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index ed2af4a..c8cb364 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -91,7 +91,7 @@ static void __init qsd8x50_init_irq(void)
 	msm_init_sirc();
 }
 
-static void __init qsd8x50_init(void)
+static void __init qsd8x50_init(void *arg)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-msm/board-sapphire.c b/arch/arm/mach-msm/board-sapphire.c
index 8919ffb..9f79411 100644
--- a/arch/arm/mach-msm/board-sapphire.c
+++ b/arch/arm/mach-msm/board-sapphire.c
@@ -63,7 +63,7 @@ static void __init sapphire_init_irq(void)
 	msm_init_irq();
 }
 
-static void __init sapphire_init(void)
+static void __init sapphire_init(void *arg)
 {
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 73f1460..84455ed 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -55,7 +55,7 @@ static void __init trout_fixup(struct machine_desc *desc, struct tag *tags,
 	mi->bank[0].size = (101*1024*1024);
 }
 
-static void __init trout_init(void)
+static void __init trout_init(void *arg)
 {
 	int rc;
 
-- 
1.7.3.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

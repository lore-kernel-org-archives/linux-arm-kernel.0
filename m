From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Dec 2010 17:32:38 -0000
Subject: Forced HW_BREAKPOINT
In-Reply-To: <4CF67C52.4000300@ti.com>
References: <4CF58F22.6070803@ti.com>
	<004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
	<4CF67525.2010304@ti.com>
	<004d01cb9174$c8d83ec0$5a88bc40$@deacon@arm.com>
	<4CF67C52.4000300@ti.com>
Message-ID: <004f01cb917d$c04b4910$40e1db30$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyril,

> This was without a debugger connected.  It is possible that I have
> missed some top level debug enable in the SoC (haven't traced through
> the entire logic yet).

Please can you try this patch?


diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 21e3a4a..bcf8437 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -268,9 +268,6 @@ static u8 get_max_wp_len(void)
        if (debug_arch < ARM_DEBUG_ARCH_V7_ECP14)
                goto out;
 
-       if (enable_monitor_mode())
-               goto out;
-
        memset(&ctrl, 0, sizeof(ctrl));
        ctrl.len = ARM_BREAKPOINT_LEN_8;
        ctrl_reg = encode_ctrl_reg(ctrl);
@@ -784,15 +781,18 @@ static void __init reset_ctrl_regs(void *unused)
 
 static int __init arch_hw_breakpoint_init(void)
 {
-       int ret = 0;
        u32 dscr;
 
        debug_arch = get_debug_arch();
 
        if (debug_arch > ARM_DEBUG_ARCH_V7_ECP14) {
                pr_info("debug architecture 0x%x unsupported.\n", debug_arch);
-               ret = -ENODEV;
-               goto out;
+               return 0;
+       }
+
+       if (enable_monitor_mode()) {
+               pr_warning("unable to activate monitor debug mode.\n");
+               return 0;
        }
 
        /* Determine how many BRPs/WRPs are available. */
@@ -829,8 +829,7 @@ static int __init arch_hw_breakpoint_init(void)
        hook_ifault_code(2, hw_breakpoint_pending, SIGTRAP, TRAP_HWBKPT,
                        "breakpoint debug exception");
 
-out:
-       return ret;
+       return 0;
 }
 arch_initcall(arch_hw_breakpoint_init);


This should cause the hw_breakpoint stuff to give up if monitor-mode
cannot be enabled.

Will

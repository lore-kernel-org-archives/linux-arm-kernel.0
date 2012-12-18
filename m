From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Dec 2012 15:54:12 -0800
Subject: Fw: [PATCH 01/01] arm: fix a preempt_count() corruption for
 CONFIG_PREEMPT=n
In-Reply-To: <20121215085129.71d203b2.pkluba@dension.com>
References: <20121215085129.71d203b2.pkluba@dension.com>
Message-ID: <50D10224.30600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/12 23:51, Patrik, Kluba wrote:
> Date: Fri, 14 Dec 2012 15:13:57 +0100
> From: "Patrik, Kluba" <pkluba@dension.com>
> To: linux-kernel at vger.kernel.org
> Subject: [PATCH 01/01] arm: fix a preempt_count() corruption for
> CONFIG_PREEMPT=n
>
>
> Hi All,
>
> After a hard days' work, I've managed to track down a ghost causing
> sporadic kernel warnings and system crashes. The patch applies for the
> HEAD of linux-stable. I don't know how to create and submit patches
> correctly, and hope that somebody will pick it up...
>
> Regards,
> Patrik
> ---
> From 4dd31e88a2715389e5ac198dcf00b48b4f148ea6 Mon Sep 17 00:00:00 2001
> From: Patrik Kluba <pkluba@dension.com>
> Date: Fri, 14 Dec 2012 14:36:27 +0100
> Subject: [PATCH] arm: fix a preempt_count() corruption for
> CONFIG_PREEMPT=n
>
> All the preempt-disabling assembly code is under CONFIG_PREEMPT,
> while VFP_bounce calls preempt_enable() uncoditionally, leading to
> a preempt_count() corruption (gets set to 0xffffffff). Fix the
> imbalance by adding #ifdef CONFIG_PREEMPT before preempt_enable().
> ---
>  arch/arm/vfp/vfpmodule.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 3b44e0d..2184f7e 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -428,7 +428,10 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct
> pt_regs *regs) if (exceptions)
>  		vfp_raise_exceptions(exceptions, trigger, orig_fpscr,
> regs); exit:
> +#ifdef CONFIG_PREEMPT
>  	preempt_enable();
> +#endif
> +	return;

>From include/linux/preempt.h

#ifdef CONFIG_PREEMPT_COUNT

...

#define preempt_enable() \
do { \
        preempt_enable_no_resched(); \
        barrier(); \
        preempt_check_resched(); \
} while (0)

...

#else /* !CONFIG_PREEMPT_COUNT */

...

#define preempt_enable()                do { } while (0)

...

#endif

And CONFIG_PREEMPT_COUNT=y only if CONFIG_PREEMPT=y but your subject
says PREEMPT_COUNT=n. Do you by chance have DEBUG_ATOMIC_SLEEP=y
selected in your config? That seems to select PREEMPT_COUNT as well and
so I believe we need to move ARM assembly to use PREEMPT_COUNT instead
of plain PREEMPT in its preempt_count changing assembly code.

Can you try this patch? I'll probably send a follow up patch that
consolidates the duplicated preempt_decrement code into some assembly
macro. We may also want to fix it up so that assembly stubs call into
the preempt tracer. I'm not sure how that works right now with VFP.

---->8------

diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index cc926c9..323ce1a 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -22,7 +22,7 @@
 @  IRQs disabled.
 @
 ENTRY(do_vfp)
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_COUNT
        ldr     r4, [r10, #TI_PREEMPT]  @ get preempt count
        add     r11, r4, #1             @ increment it
        str     r11, [r10, #TI_PREEMPT]
@@ -35,7 +35,7 @@ ENTRY(do_vfp)
 ENDPROC(do_vfp)
 
 ENTRY(vfp_null_entry)
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_COUNT
        get_thread_info r10
        ldr     r4, [r10, #TI_PREEMPT]  @ get preempt count
        sub     r11, r4, #1             @ decrement it
@@ -53,7 +53,7 @@ ENDPROC(vfp_null_entry)
 
        __INIT
 ENTRY(vfp_testing_entry)
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_COUNT
        get_thread_info r10
        ldr     r4, [r10, #TI_PREEMPT]  @ get preempt count
        sub     r11, r4, #1             @ decrement it
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index ea0349f..dd5e56f 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -168,7 +168,7 @@ vfp_hw_state_valid:
                                        @ else it's one 32-bit instruction, so
                                        @ always subtract 4 from the following
                                        @ instruction address.
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_COUNT
        get_thread_info r10
        ldr     r4, [r10, #TI_PREEMPT]  @ get preempt count
        sub     r11, r4, #1             @ decrement it
@@ -192,7 +192,7 @@ look_for_VFP_exceptions:
        @ not recognised by VFP
 
        DBGSTR  "not VFP"
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPT_COUNT
        get_thread_info r10
        ldr     r4, [r10, #TI_PREEMPT]  @ get preempt count
        sub     r11, r4, #1             @ decrement it

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

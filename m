From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Mon, 16 Oct 2017 11:42:05 +0000
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <201710141957.mbxeZJHB%fengguang.wu@intel.com>
References: <20171011082227.20546-5-liuwenliang@huawei.com>
 <201710141957.mbxeZJHB%fengguang.wu@intel.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2017 07:03 PM, Abbott Liu wrote:
>arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movw r1,
  #:lower16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode
>arch/arm/kernel/entry-armv.S:348: Error: selected processor does not support `movt r1,
  #:upper16:((((0xC0000000-0x01000000)>>3)+((0xC0000000-0x01000000)-(1<<29))))' in ARM mode

Thanks for building test. This error can be solved by following code:
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -188,8 +188,7 @@ ENDPROC(__und_invalid)
        get_thread_info tsk
        ldr     r0, [tsk, #TI_ADDR_LIMIT]
 #ifdef CONFIG_KASAN
-   movw r1, #:lower16:TASK_SIZE
-   movt r1, #:upper16:TASK_SIZE
+ ldr r1, =TASK_SIZE
 #else
        mov r1, #TASK_SIZE
 #endif
@@ -446,7 +445,12 @@ ENDPROC(__fiq_abt)
        @ if it was interrupted in a critical region.  Here we
        @ perform a quick test inline since it should be false
        @ 99.9999% of the time.  The rest is done out of line.
+#if CONFIG_KASAN
+ ldr r0, =TASK_SIZE
+ cmp r4, r0
+#else
        cmp     r4, #TASK_SIZE
+#endif
        blhs    kuser_cmpxchg64_fixup
 #endif
 #endif

movt,movw can only be used in ARMv6*, ARMv7 instruction set. But ldr can be used in ARMv4*, ARMv5T*, ARMv6*, ARMv7.
Maybe the performance is going to fall down by using ldr, but I think the influence of performance is very limited.

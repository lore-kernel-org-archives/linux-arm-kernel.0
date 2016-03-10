From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Mar 2016 01:19:54 +0700 (ICT)
Subject: [PATCH] harden idiv patching against undefined gcc behavior
Message-ID: <alpine.LFD.2.20.1603110053470.6284@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was reported that a kernel with CONFIG_ARM_PATCH_IDIV=y stopped 
booting when compiled with the upcoming gcc 6.  Turns out that turning
a function address into a writable array is undefined and gcc 6 decided
it was OK to omit the store to the first word of the function while
still preserving the store to the second word.

Even though gcc 6 is now fixed to behave more coherently, it is a 
mystery that gcc 4 and gcc 5 actually produce wanted code in the kernel.  
And in fact the reduced test case to illustrate the issue does indeed 
break with gcc < 6 as well.

In any case, let's guard the kernel against undefined compiler behavior 
by hiding the nature of the array location as suggested by gcc 
developers.

Reference: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70128

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reported-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>


diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7d0cba6f1c..c86ea8aac2 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -430,11 +430,13 @@ static void __init patch_aeabi_idiv(void)
 	pr_info("CPU: div instructions available: patching division code\n");
 
 	fn_addr = ((uintptr_t)&__aeabi_uidiv) & ~1;
+	asm ("" : "+g" (fn_addr));
 	((u32 *)fn_addr)[0] = udiv_instruction();
 	((u32 *)fn_addr)[1] = bx_lr_instruction();
 	flush_icache_range(fn_addr, fn_addr + 8);
 
 	fn_addr = ((uintptr_t)&__aeabi_idiv) & ~1;
+	asm ("" : "+g" (fn_addr));
 	((u32 *)fn_addr)[0] = sdiv_instruction();
 	((u32 *)fn_addr)[1] = bx_lr_instruction();
 	flush_icache_range(fn_addr, fn_addr + 8);

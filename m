From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2011 12:27:57 +0100
Subject: linux-next regression on ARM926
In-Reply-To: <CACRpkdbBrVda2oD42tjrWiG6uHXAdWwpr6cZ7qnSc2KM82XCfw@mail.gmail.com>
References: <CACRpkdbBrVda2oD42tjrWiG6uHXAdWwpr6cZ7qnSc2KM82XCfw@mail.gmail.com>
Message-ID: <20110718112757.GV23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 01:02:01PM +0200, Linus Walleij wrote:
> Hi Dave,
> 
> do you have any hints on how to resolve this build error in the -next
> tree:
> 
>   LD      .tmp_vmlinux1
> arch/arm/mm/built-in.o:(.init.data+0xe0): undefined reference to
> `cpu_arm926_do_suspend'
> arch/arm/mm/built-in.o:(.init.data+0xe4): undefined reference to
> `cpu_arm926_do_resume'
> make[2]: *** [.tmp_vmlinux1] Error 1
> make[1]: *** [sub-make] Error 2
> make[1]: Leaving directory `/home/linus/linux-next'
> make: *** [build] Error 2
> 
> This is while building the U300, I can't really tell if the error is on my
> (U300) side or in the recent patches to the proc_arm926 stuff?
> It seems all ARM926 SoCs were affected.

Hmm.

That happens because without CONFIG_PM_SLEEP, we do this:

#define cpu_arm926_do_suspend   0
#define cpu_arm926_do_resume    0

whereas the macro assembler does this:

        .word   cpu_\name\()_do_suspend
        .word   cpu_\name\()_do_resume

and this means that neither the preprocessor nor the assembler can tie
these two together.

One solution would be to put an #ifdef CONFIG_PM_SLEEP around that in
mm/proc-macros.S to select .word 0 instead, and get rid of the #else
in the individual proc-*.S files - something like this (untested):

diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index b2f9bde..2bbcf05 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -421,9 +421,6 @@ ENTRY(cpu_arm926_do_resume)
 		     PMD_SECT_CACHEABLE | PMD_BIT4 | PMD_SECT_AP_WRITE
 	b	cpu_resume_mmu
 ENDPROC(cpu_arm926_do_resume)
-#else
-#define cpu_arm926_do_suspend	0
-#define cpu_arm926_do_resume	0
 #endif
 
 	__CPUINIT
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 4ae9b44..307a4de 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -276,8 +276,13 @@ ENTRY(\name\()_processor_functions)
 
 	.if \suspend
 	.word	cpu_\name\()_suspend_size
+#ifdef CONFIG_PM_SLEEP
 	.word	cpu_\name\()_do_suspend
 	.word	cpu_\name\()_do_resume
+#else
+	.word	0
+	.word	0
+#endif
 	.else
 	.word	0
 	.word	0

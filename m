From: hari.vyas@broadcom.com (Hari Vyas)
Date: Thu, 7 Dec 2017 12:29:24 +0530
Subject: ARM64: Need to ignore exception in bad_mode()
In-Reply-To: 4291b531f85f9f0fd29754fc9f90a911@mail.gmail.com
References: 4291b531f85f9f0fd29754fc9f90a911@mail.gmail.com
Message-ID: <15cacc5dd3fea86b1989d6c5fdc15425@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Re-sending mail in plain text format)

Hi Will , Catalin,
	One of our Broadcom SoC "Stingray" is based on ARM64 architecture.
In pcie hot-plug-out scenario where EP card is surprisingly plugged-out,
few ongoing memory transaction times out and our pcie IDM wrapper
eventually  results in an exception which is expected one in
this case.
	If we don't ignore exception in this case, kernel crashes.
	We are planning to ignore "expected exception" by changing entry.S
and traps.c.  Please check and provide us your opinion  regarding below
approach. I have highlighted important changes of
arch/arm64/kernel/entry.S and arch/arm64/kernel/traps.c


hariv at vijay-Precision-WorkStation-T3400:~/BCM_MASTER/kernel$ git diff
arch/arm64/kernel/entry.S
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e1c59d4..54b5eb2 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -430,6 +430,9 @@ __bad_stack:
        mov     x1, #\reason
        mrs     x2, esr_el1
        bl      bad_mode
+       cbnz    x0, 2f
+       kernel_exit el
+2:
        ASM_BUG()
        .endm

hariv at vijay-Precision-WorkStation-T3400:~/BCM_MASTER/kernel$ git diff
arch/arm64/kernel/traps.c
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8383af1..709f399 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -48,6 +48,8 @@
 #include <asm/exception.h>
 #include <asm/system_misc.h>
 #include <asm/sysreg.h>

 int show_unhandled_signals = 1;

+struct exception_list {
+       struct list_head head;
+       long unsigned data;
+       int (*cb)(long unsigned data);
+};
+struct list_head exception_head = LIST_HEAD_INIT(exception_head);
+
+int register_exception(int (*cb)(long unsigned data), long unsigned data)
+{
+       struct exception_list *entry;
+
+       entry=kmalloc(sizeof(struct exception_list *),GFP_KERNEL);
+       entry->data = data;
+       entry->cb = cb;
+       list_add(&entry->head,&exception_head);
+       return 0;
+}
+EXPORT_SYMBOL(register_exception);
+
 /*
  * Dump out the contents of some kernel memory nicely...
  */
+
 static void dump_mem(const char *lvl, const char *str, unsigned long
bottom,
                     unsigned long top)
 {
@@ -633,10 +655,22 @@ const char *esr_get_class_string(u32 esr)
  * bad_mode handles the impossible case in the exception vector. This is
always
  * fatal.
  */
-asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int
esr)
+asmlinkage int bad_mode(struct pt_regs *regs, int reason, unsigned int
esr)
 {
+       struct exception_list *entry;
+       struct list_head *ptr;
+       int ret;
+
        console_verbose();

+       list_for_each(ptr,&exception_head) {
+               entry=list_entry(ptr,struct exception_list,head);
+               ret = entry->cb(entry->data);
+               if (ret == NOTIFY_STOP) {
+                       pr_crit("Expected exception so ignoring\n");
+                       return 0;
+               }
+       }
        pr_crit("Bad mode in %s handler detected on CPU%d, code 0x%08x --
%s\n",
                handler[reason], smp_processor_id(), esr,
                esr_get_class_string(esr));
@@ -644,6 +678,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int
reason, u
        die("Oops - bad mode", regs, 0);
        local_irq_disable();
        panic("bad mode");
+       return 1; /* Must not reach */
 }

 /*
hariv at vijay-Precision-WorkStation-T3400:~/BCM_MASTER/kernel$


Regards,
hari

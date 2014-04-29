From: yinghai@kernel.org (Yinghai Lu)
Date: Tue, 29 Apr 2014 15:00:34 -0700
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <CAL_JsqKCJvYSrFSBVCfijLhZEojm29JCY8ubQV1eAoyCCZDRZA@mail.gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVp5u-jF_xjCu68BgbZ=e0D508tn_-auoiT6cbkYtX8Og@mail.gmail.com>
 <CAL_JsqKiYmCNGrkiwS7m-OAt3rHZBq_yNGycen-AojbV-7famg@mail.gmail.com>
 <CAE9FiQVdwumX7Dsmt8NJhw4uWsj2sjUKaKS1wJQujW1fn1szLw@mail.gmail.com>
 <CAL_Jsq+uNunqfsvPNxZLQQ3y1ay_XMZKb4c=HNWvKtwuiZGQ0g@mail.gmail.com>
 <CAE9FiQU40p-e8mqZKzaGg6nTuPdep3inRdpQtNu5txPOJ6Aw-Q@mail.gmail.com>
 <CAL_JsqKCJvYSrFSBVCfijLhZEojm29JCY8ubQV1eAoyCCZDRZA@mail.gmail.com>
Message-ID: <CAE9FiQXUMHQxRZOOb+XNg0xbU7d6QY=VL3qhd0JdAw=wYc4W-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 1:41 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Apr 29, 2014 at 1:22 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> You want to obsolete "console=uart,io,0x3f8,115200n8" ?
>>
>>  Let's check with Andrew. He suggested to use uart and uart8250 at that time.
>
> No, that is not what I'm saying. For the 2 callers of
> setup_early_serial8250_console which are crafting a console string
> from firmware data, they can and do use uart8250. I don't expect this
> mechanism for setting up early console to expand to other users. The
> whole point of this series is to allow any uart to be supported for
> earlycon. For anyone using the kernel command line, both uart and
> uart8250 are still supported.

That is confusing, why not keeping them consistent?

I posted one patch before about "early early console for x86", and it
is in my local tree
 for some time.support both "uart,io" and "uart8250,io".

Peter, Can you check that patch again?  --- updated version attached.
and inlined.

Thanks

Yinghai

Subject: [PATCH -v4] x86: Setup early console as early as possible in
x86_start_kernel()

Analyze "console=uart8250,io,0x3f8,115200n8" in
i386_start_kernel/x86_64_start_kernel,
and call setup_early_serial8250_console() to init early serial console.

Only can handle io port kind of 8250, because mmio need ioremap.

Use boot_params.hdr.version instead of adding another variable,
Suggested by hpa.
Also need to apply this one after x86 memblock patchset.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/setup.h |    2 ++
 arch/x86/kernel/head.c       |   26 ++++++++++++++++++++++++++
 arch/x86/kernel/head32.c     |    1 +
 arch/x86/kernel/head64.c     |    5 ++++-
 kernel/printk/printk.c       |   11 +++++++----
 5 files changed, 40 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/x86/include/asm/setup.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/setup.h
+++ linux-2.6/arch/x86/include/asm/setup.h
@@ -49,6 +49,8 @@ static inline void x86_acpi_override_fin
 #endif

 extern unsigned long saved_video_mode;
+int setup_early_serial8250_console(char *cmdline);
+void setup_early_console(void);

 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
Index: linux-2.6/arch/x86/kernel/head.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head.c
+++ linux-2.6/arch/x86/kernel/head.c
@@ -69,3 +69,29 @@ void __init reserve_ebda_region(void)
     /* reserve all memory between lowmem and the 1MB mark */
     memblock_reserve(lowmem, 0x100000 - lowmem);
 }
+
+void __init setup_early_console(void)
+{
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+    char constr[64], *p, *q;
+
+    /* Can not handle mmio type 8250 uart yet, too early */
+    p = strstr(boot_command_line, "console=uart8250,io,");
+    if (!p)
+        p = strstr(boot_command_line, "console=uart,io,");
+    if (!p)
+        return;
+
+    p += 8;    /* sizeof "console=" */
+    q = strchr(p, ' ');
+    if ((q - p) >= sizeof(constr))
+        return;
+
+    memset(constr, 0, sizeof(constr));
+    memcpy(constr, p, q - p);
+
+    lockdep_init();
+
+    setup_early_serial8250_console(constr);
+#endif
+}
Index: linux-2.6/arch/x86/kernel/head32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head32.c
+++ linux-2.6/arch/x86/kernel/head32.c
@@ -32,6 +32,7 @@ static void __init i386_default_early_se
 void __init i386_start_kernel(void)
 {
     sanitize_boot_params(&boot_params);
+    setup_early_console();

     /* Call the subarch specific early setup function */
     switch (boot_params.hdr.hardware_subarch) {
Index: linux-2.6/arch/x86/kernel/head64.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head64.c
+++ linux-2.6/arch/x86/kernel/head64.c
@@ -166,6 +166,7 @@ void __init x86_64_start_kernel(char * r
     load_idt((const struct desc_ptr *)&idt_descr);

     copy_bootdata(__va(real_mode_data));
+    setup_early_console();

     /*
      * Load microcode early on BSP.
@@ -187,8 +188,10 @@ void __init x86_64_start_kernel(char * r
 void __init x86_64_start_reservations(char *real_mode_data)
 {
     /* version is always not zero if it is copied */
-    if (!boot_params.hdr.version)
+    if (!boot_params.hdr.version) {
         copy_bootdata(__va(real_mode_data));
+        setup_early_console();
+    }

     reserve_ebda_region();

Index: linux-2.6/kernel/printk/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk/printk.c
+++ linux-2.6/kernel/printk/printk.c
@@ -2227,11 +2227,14 @@ void register_console(struct console *ne
     struct console_cmdline *c;

     if (console_drivers)
-        for_each_console(bcon)
-            if (WARN(bcon == newcon,
-                    "console '%s%d' already registered\n",
-                    bcon->name, bcon->index))
+        for_each_console(bcon) {
+            /* not again */
+            if (bcon == newcon) {
+                printk(KERN_INFO "console '%s%d' already registered\n",
+                    bcon->name, bcon->index);
                 return;
+            }
+    }

     /*
      * before we register a new CON_BOOT console, make sure we don't
-------------- next part --------------
A non-text attachment was scrubbed...
Name: setup_early_console_x1_pa_symbol_before_earlcon.patch
Type: text/x-patch
Size: 4105 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/f527c861/attachment.bin>

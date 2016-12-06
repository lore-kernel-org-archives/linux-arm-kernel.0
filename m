From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Dec 2016 18:18:59 +0000
Subject: [PATCHv4 09/10] mm/usercopy: Switch to using lm_alias
In-Reply-To: <CAGXu5jKrBc6R9JYay1L6pd958Vm5-6p=37tiUYgg6uPeZb1HtQ@mail.gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-10-git-send-email-labbott@redhat.com>
 <CAGXu5jKrBc6R9JYay1L6pd958Vm5-6p=37tiUYgg6uPeZb1HtQ@mail.gmail.com>
Message-ID: <20161206181859.GH24177@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 11:39:44AM -0800, Kees Cook wrote:
> On Tue, Nov 29, 2016 at 10:55 AM, Laura Abbott <labbott@redhat.com> wrote:
> >
> > The usercopy checking code currently calls __va(__pa(...)) to check for
> > aliases on symbols. Switch to using lm_alias instead.
> >
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> I should probably add a corresponding alias test to lkdtm...
> 
> -Kees

Something like the below?

It uses lm_alias(), so it depends on Laura's patches. We seem to do the
right thing, anyhow:

root at ribbensteg:/home/nanook# echo USERCOPY_KERNEL_ALIAS > /sys/kernel/debug/provoke-crash/DIRECT
[   44.493400] usercopy: kernel memory exposure attempt detected from ffff80000031a730 (<linear kernel text>) (4096 bytes)
[   44.504263] kernel BUG at mm/usercopy.c:75!

Thanks,
Mark.

---->8----
diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
index fdf954c..96d8d76 100644
--- a/drivers/misc/lkdtm.h
+++ b/drivers/misc/lkdtm.h
@@ -56,5 +56,6 @@
 void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
 void lkdtm_USERCOPY_STACK_BEYOND(void);
 void lkdtm_USERCOPY_KERNEL(void);
+void lkdtm_USERCOPY_KERNEL_ALIAS(void);
 
 #endif
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index f9154b8..f6bc6d6 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -228,6 +228,7 @@ struct crashtype crashtypes[] = {
        CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
        CRASHTYPE(USERCOPY_STACK_BEYOND),
        CRASHTYPE(USERCOPY_KERNEL),
+       CRASHTYPE(USERCOPY_KERNEL_ALIAS),
 };
 
 
diff --git a/drivers/misc/lkdtm_usercopy.c b/drivers/misc/lkdtm_usercopy.c
index 1dd6114..955f2dc 100644
--- a/drivers/misc/lkdtm_usercopy.c
+++ b/drivers/misc/lkdtm_usercopy.c
@@ -279,9 +279,16 @@ void lkdtm_USERCOPY_STACK_BEYOND(void)
        do_usercopy_stack(true, false);
 }
 
-void lkdtm_USERCOPY_KERNEL(void)
+static void do_usercopy_kernel(bool use_alias)
 {
        unsigned long user_addr;
+       const void *rodata = test_text;
+       void *text = vm_mmap;
+
+       if (use_alias) {
+               rodata = lm_alias(rodata);
+               text = lm_alias(text);
+       }
 
        user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
                            PROT_READ | PROT_WRITE | PROT_EXEC,
@@ -292,14 +299,14 @@ void lkdtm_USERCOPY_KERNEL(void)
        }
 
        pr_info("attempting good copy_to_user from kernel rodata\n");
-       if (copy_to_user((void __user *)user_addr, test_text,
+       if (copy_to_user((void __user *)user_addr, rodata,
                         unconst + sizeof(test_text))) {
                pr_warn("copy_to_user failed unexpectedly?!\n");
                goto free_user;
        }
 
        pr_info("attempting bad copy_to_user from kernel text\n");
-       if (copy_to_user((void __user *)user_addr, vm_mmap,
+       if (copy_to_user((void __user *)user_addr, text,
                         unconst + PAGE_SIZE)) {
                pr_warn("copy_to_user failed, but lacked Oops\n");
                goto free_user;
@@ -309,6 +316,16 @@ void lkdtm_USERCOPY_KERNEL(void)
        vm_munmap(user_addr, PAGE_SIZE);
 }
 
+void lkdtm_USERCOPY_KERNEL(void)
+{
+       do_usercopy_kernel(false);
+}
+
+void lkdtm_USERCOPY_KERNEL_ALIAS(void)
+{
+       do_usercopy_kernel(true);
+}
+
 void __init lkdtm_usercopy_init(void)
 {
        /* Prepare cache that lacks SLAB_USERCOPY flag. */

From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Sat, 26 Mar 2016 21:45:53 +0800
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160321184012.GA26563@yury-N73SV>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de> <20160225202855.GD16123@yury-N73SV>
 <56EBD84D.2060009@huawei.com> <20160318154918.GA1595@yury-N73SV>
 <mvmoaa8dwre.fsf@hawking.suse.de> <20160321184012.GA26563@yury-N73SV>
Message-ID: <56F69291.4050205@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, guys

Does any body test the bigendian? We found lots of failures in be in
our arm64 hardware. E.g. the signal issue.

IIUC, the signal of struct in ILP32 is align with the aarch32. If so,
we need to revert the following patch wrote by Andrew in 2014 which
align the kernel_sigaction of ilp32 to lp64:
Revert "[AARCH64] Add kernel_sigaction.h for AARCH64 ILP32"

And we also need to handle the uc_stack properly in kernel. After
apply these two patches, we could fix lots of failure in bigendian.

Regards

Bamvor

 From cb08043a1f14eb997892711c2e1e5016b0e9eef6 Mon Sep 17 00:00:00 2001
From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Date: Thu, 24 Mar 2016 10:40:47 +0800
Subject: [PATCH] try to fix the signal issue in be

Currently, there is different layout in uc_stack in le and be.
Try to fix the issue by processing uc_stack through corresponding
compat function.

Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
---
  arch/arm64/kernel/signal_ilp32.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
index 26b3121..9af29e0 100644
--- a/arch/arm64/kernel/signal_ilp32.c
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -60,7 +60,7 @@ asmlinkage int ilp32_sys_rt_sigreturn(struct pt_regs *regs)
         if (restore_sigframe(regs, &frame->sig))
                 goto badframe;

-       if (restore_altstack(&frame->sig.uc.uc_stack))
+       if (compat_restore_altstack(&frame->sig.uc.uc_stack))
                 goto badframe;

         return regs->regs[0];
@@ -112,7 +112,7 @@ int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
         __put_user_error(0, &frame->sig.uc.uc_flags, err);
         __put_user_error(NULL, &frame->sig.uc.uc_link, err);

-       err |= __save_altstack(&frame->sig.uc.uc_stack, regs->sp);
+       err |= __compat_save_altstack(&frame->sig.uc.uc_stack, regs->sp);
         err |= setup_sigframe(&frame->sig, regs, set);
         if (err == 0) {
                 setup_return(regs, &ksig->ka, frame,
--
1.8.4.5

 From f6cde6e2a75a4b153758eea679c5a839fc1c39d2 Mon Sep 17 00:00:00 2001
From: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
Date: Sat, 26 Mar 2016 18:10:38 +0800
Subject: [PATCH] Revert "[AARCH64] Add kernel_sigaction.h for AARCH64 ILP32"

This reverts commit 68e11d8643cfd08a62cea3555e92d77a21bf41de.
---
  sysdeps/unix/sysv/linux/aarch64/kernel_sigaction.h | 12 ------------
  sysdeps/unix/sysv/linux/aarch64/sigaction.c        | 10 ++++------
  2 files changed, 4 insertions(+), 18 deletions(-)
  delete mode 100644 sysdeps/unix/sysv/linux/aarch64/kernel_sigaction.h

diff --git a/sysdeps/unix/sysv/linux/aarch64/kernel_sigaction.h b/sysdeps/unix/sysv/linux/aarch64/kernel_sigaction.h
deleted file mode 100644
index 7b3023b..0000000
--- a/sysdeps/unix/sysv/linux/aarch64/kernel_sigaction.h
+++ /dev/null
@@ -1,12 +0,0 @@
-
-#define HAVE_SA_RESTORER
-
-/* This is the sigaction structure in aarch64 kernel.
-   Note the ILP32 struct uses the same struct as LP64
-   which is why the fields are 64bit in size. */
-struct kernel_sigaction {
-	unsigned long long k_sa_handler;
-	unsigned long long sa_flags;
-	unsigned long long sa_restorer;
-	sigset_t sa_mask;
-};
diff --git a/sysdeps/unix/sysv/linux/aarch64/sigaction.c b/sysdeps/unix/sysv/linux/aarch64/sigaction.c
index 5d22b68..2679acd 100644
--- a/sysdeps/unix/sysv/linux/aarch64/sigaction.c
+++ b/sysdeps/unix/sysv/linux/aarch64/sigaction.c
@@ -39,17 +39,15 @@ __libc_sigaction (int sig, const struct sigaction *act, struct sigaction *oact)

    if (act)
      {
-      kact.k_sa_handler = (unsigned long long)(uintptr_t)act->sa_handler;
+      kact.k_sa_handler = act->sa_handler;
        memcpy (&kact.sa_mask, &act->sa_mask, sizeof (sigset_t));
        kact.sa_flags = act->sa_flags;
  #ifdef HAVE_SA_RESTORER
        if (kact.sa_flags & SA_RESTORER)
-	kact.sa_restorer = (unsigned long long)(uintptr_t)act->sa_restorer;
+	kact.sa_restorer = act->sa_restorer;
  #endif
      }

-  /* This is needed for ILP32 as the structures are two different sizes due to
-     using the LP64 structure.  */
    result = INLINE_SYSCALL (rt_sigaction, 4, sig,
  			   act ? &kact : NULL,
  			   oact ? &koact : NULL, _NSIG / 8);
@@ -57,11 +55,11 @@ __libc_sigaction (int sig, const struct sigaction *act, struct sigaction *oact)
      {
        if (oact && result >= 0)
  	{
-	  oact->sa_handler = (void*)(uintptr_t)koact.k_sa_handler;
+	  oact->sa_handler = koact.k_sa_handler;
  	  memcpy (&oact->sa_mask, &koact.sa_mask, sizeof (sigset_t));
  	  oact->sa_flags = koact.sa_flags;
  #ifdef HAVE_SA_RESTORER
-	  oact->sa_restorer = (void*)(uintptr_t)koact.sa_restorer;
+	  oact->sa_restorer = koact.sa_restorer;
  #endif
  	}
      }
-- 
1.8.4.5

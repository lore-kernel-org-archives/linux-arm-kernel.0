From: ldv@altlinux.org (Dmitry V. Levin)
Date: Thu, 12 Apr 2018 14:03:14 +0300
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180412095811.GC16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
Message-ID: <20180412110314.GA28070@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 10:58:11AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> > A similar commit v4.16-rc1~159^2~37
> > ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> > introduced a similar ABI regression to compat arm.
> 
> So, could you explain how can this change cause a regression?
> 
> +#define FPE_FIXME      0
> -               vfp_raise_sigfpe(0, regs);
> +               vfp_raise_sigfpe(FPE_FIXME, regs);

No, this hunk hasn't caused the regression, but another one did:

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
new file mode 100644
index 0000000..d051388
--- /dev/null
+++ b/arch/arm/include/uapi/asm/siginfo.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME      0       /* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+#endif

This is due to FPE_FIXME handling in kernel/signal.c


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/0dccfbf9/attachment-0001.sig>

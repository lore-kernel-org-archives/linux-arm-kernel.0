From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Jul 2016 18:16:36 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <5790F960.5050007@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
Message-ID: <20160721171636.GG16666@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 12:33:36PM -0400, David Long wrote:
> On 07/20/2016 12:09 PM, Marc Zyngier wrote:
> >On 08/07/16 17:35, David Long wrote:
> >>diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
> >>new file mode 100644
> >>index 0000000..79c9511
> >>--- /dev/null
> >>+++ b/arch/arm64/include/asm/kprobes.h
> >>@@ -0,0 +1,60 @@
> >>+/*
> >>+ * arch/arm64/include/asm/kprobes.h
> >>+ *
> >>+ * Copyright (C) 2013 Linaro Limited
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License version 2 as
> >>+ * published by the Free Software Foundation.
> >>+ *
> >>+ * This program is distributed in the hope that it will be useful,
> >>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >>+ * General Public License for more details.
> >>+ */
> >>+
> >>+#ifndef _ARM_KPROBES_H
> >>+#define _ARM_KPROBES_H
> >>+
> >>+#include <linux/types.h>
> >>+#include <linux/ptrace.h>
> >>+#include <linux/percpu.h>
> >>+
> >>+#define __ARCH_WANT_KPROBES_INSN_SLOT
> >>+#define MAX_INSN_SIZE			1
> >>+#define MAX_STACK_SIZE			128
> >
> >Where is that value coming from? Because even on my 6502, I have a 256
> >byte stack.
> 
> Although I don't claim to know the original author's thoughts I would guess
> it is based on the seven other existing implementations for kprobes on
> various architectures, all of which appear to use either 64 or 128 for
> MAX_STACK_SIZE.  The code is not trying to duplicate the whole stack.

This seems to be some random choice in the hope that arguments passed on
the stack cannot exceed MAX_STACK_SIZE.

I'll put a patch together which checks the previous stack frame and
limit the copying. If the fp information or if the size to be copied
exceeds MAX_STACK_SIZE, just skip the probe hook (return 0 in
setjmp_pre_handler).

-- 
Catalin

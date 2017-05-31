From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 31 May 2017 11:08:17 +0100
Subject: [RFC PATCH v3 0/4] Simplify kernel-mode NEON
In-Reply-To: <CAKv+Gu-FxRLKxTvC68Wu0_o1zjSfjWDtdA7hdK79ZTNWNXPj=Q@mail.gmail.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
 <20170530180219.GR3559@e103592.cambridge.arm.com>
 <CAKv+Gu-FxRLKxTvC68Wu0_o1zjSfjWDtdA7hdK79ZTNWNXPj=Q@mail.gmail.com>
Message-ID: <20170531100758.GA30160@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 08:41:01AM +0000, Ard Biesheuvel wrote:
> On 30 May 2017 at 18:02, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, May 25, 2017 at 07:24:57PM +0100, Dave Martin wrote:
> >> This series aims to simplify kernel-mode NEON.
> >
> > Hi Ard, do you have any further comments on this series?
> >
> > I'd like to have it finalised as far as possible (modulo minor tweaks
> > and bugfixes) so that I can port the SVE patches on top of it.
> >
> > Also, how do you think we should handle merging of this change?  There's
> > a flag-day issue here, since the kernel_mode_neon() API is being changed
> > in an incompatible way.
> >
> 
> I think the patches look fine now. The best way to merge these imo is
> to start with the changes in the clients, i.e., add an arm64 specific
> asm/simd.h that defines may_use_simd() as { return true; }, update all
> the crypto code with the fallbacks, and put this stuff on top of that.

Yes, that sounds feasible.

Something like [1] below?  Either way, it probably makes sense for that
stub function to be added by your series.

> That way, there is a small window where the 'hint' is interpreted
> differently in the sha256 code, but apart from that, we should be
> bisection proof without a flag day AFAICT.
> 
> BTW I got my ZD1211 working on my MacchiatioBin board. The performance
> is terrible, but that should not matter: if I can saturate a CPU doing

Do you mean that my series causes a performance regression here, or is
the performance terrible anyway?

> NEON from userland and/or kernel process context, the softirq
> interruptions by the mac80211 code should exercise the updated code
> paths. I haven't tried that yet: let me get the code changes out
> today, so you can put your stuff on top. Then we can give it a good
> spin.

That would be great, thanks.

Cheers
---Dave

[1]:

>From 325ba5718ee0f136bfb3b4a43f7f42b1d8f2ab12 Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Wed, 31 May 2017 10:31:26 +0100
Subject: [PATCH] arm64: neon: Add stub may_use_simd() in preparation for
 refactoring

In preparation for refactoring that will make the conditions for
kernel-mode NEON use non-trivial, this patch adds a stub
may_use_simd() function.

Since arm64 currently supports kernel-mode NEON from any context
(excluding NMI) this function will return true for now.

This should allow drivers to be ported to use
kernel_neon_begin()/_end() based on this check, without impacting
rebaseability.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/simd.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/arm64/include/asm/simd.h

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
new file mode 100644
index 0000000..bd3acd8
--- /dev/null
+++ b/arch/arm64/include/asm/simd.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017  ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_SIMD_H
+#define __ASM_SIMD_H
+
+/* arm64 kernel_mode_neon() currently supports all contexts up to hardirq */
+static inline bool may_use_simd(void) { return true; }
+
+#endif /* ! __ASM_SIMD_H */
-- 
2.1.4

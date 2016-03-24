From: james.morse@arm.com (James Morse)
Date: Thu, 24 Mar 2016 16:54:34 +0000
Subject: [PATCH] arm64: opcodes.h: Add arm big-endian config options before
 including arm header
Message-ID: <1458838474-8625-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm and arm64 use different config options to specify big endian. This
needs taking into account when including code/headers between the two
architectures.

A case in point is PAN, which uses the __instr_arm() macro to output
instructions. The macro comes from opcodes.h, which lives under arch/arm.
On a big-endian build the mismatched config options mean the instruction
isn't byte swapped correctly, resulting in undefined instruction exceptions
during boot:
> alternatives: patching kernel code
> kdevtmpfs[87]: undefined instruction: pc=ffffffc0004505b4
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> kdevtmpfs[87]: undefined instruction: pc=ffffffc00076231c
> Internal error: Oops - undefined instruction: 0 [#1] SMP
> Modules linked in:
> CPU: 0 PID: 87 Comm: kdevtmpfs Not tainted 4.1.16+ #5
> Hardware name: Hisilicon PhosphorHi1382 EVB (DT)
> task: ffffffc336591700 ti: ffffffc3365a4000 task.ti: ffffffc3365a4000
> PC is at dump_instr+0x68/0x100
> LR is at do_undefinstr+0x1d4/0x2a4
> pc : [<ffffffc00076231c>] lr : [<ffffffc0000811d4>] pstate: 604001c5
> sp : ffffffc3365a6450

Reported-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> #4.3.x-
---
 arch/arm64/include/asm/opcodes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/opcodes.h b/arch/arm64/include/asm/opcodes.h
index 4e603ea36ad3..123f45d92cd1 100644
--- a/arch/arm64/include/asm/opcodes.h
+++ b/arch/arm64/include/asm/opcodes.h
@@ -1 +1,5 @@
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define CONFIG_CPU_ENDIAN_BE8 CONFIG_CPU_BIG_ENDIAN
+#endif
+
 #include <../../arm/include/asm/opcodes.h>
-- 
2.8.0.rc3

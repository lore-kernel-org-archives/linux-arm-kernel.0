From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2016 15:53:26 +0100
Subject: [PATCH 1/2] arm64: kernel: Add SMC Session ID to results
In-Reply-To: <20160822140246.GA30923@hector.attlocal.net>
References: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
 <1471672274-19317-2-git-send-email-andy.gross@linaro.org>
 <20160822134313.GJ14680@arm.com>
 <20160822140246.GA30923@hector.attlocal.net>
Message-ID: <20160822145326.GK14680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 09:02:46AM -0500, Andy Gross wrote:
> On Mon, Aug 22, 2016 at 02:43:14PM +0100, Will Deacon wrote:
> > On Sat, Aug 20, 2016 at 12:51:13AM -0500, Andy Gross wrote:
> > > This patch adds the SMC Session ID to the results passed back from SMC
> > > calls.  The Qualcomm SMC implementation provides for interrupted SMC
> > > functions.  When this occurs, the SMC call will return a session ID that
> > > is required to be used when resuming the interrupted SMC call.
> > > 
> > > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > > ---
> > >  arch/arm64/kernel/asm-offsets.c | 1 +
> > >  arch/arm64/kernel/smccc-call.S  | 1 +
> > >  include/linux/arm-smccc.h       | 4 +++-
> > >  3 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > [...]
> > 
> > > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > > index b5abfda..82d919f 100644
> > > --- a/include/linux/arm-smccc.h
> > > +++ b/include/linux/arm-smccc.h
> > > @@ -63,18 +63,20 @@
> > >  /**
> > >   * struct arm_smccc_res - Result from SMC/HVC call
> > >   * @a0-a3 result values from registers 0 to 3
> > > + * @a6 Session ID register (optional)
> > >   */
> > >  struct arm_smccc_res {
> > >  	unsigned long a0;
> > >  	unsigned long a1;
> > >  	unsigned long a2;
> > >  	unsigned long a3;
> > > +	unsigned long a6;
> > >  };
> > >  
> > >  /**
> > >   * arm_smccc_smc() - make SMC calls
> > >   * @a0-a7: arguments passed in registers 0 to 7
> > > - * @res: result values from registers 0 to 3
> > > + * @res: result values from registers 0 to 3 and optional register 6
> > 
> > AFAICT from reading the SMCCC spec, parameter register 6 is "Unpredictable,
> > Scratch registers" in return state, so I don't think this is correct.
> > 
> > What am I missing?
> 
> In the case of Qualcomm's implementation, they return a value in register 6 that
> may or may not be used in subsequent calls.  If I want to leverage the arm_smccc
> functions, then I need to extend them to include the optional return value.  The
> downside to this is that everyone who uses this is exposed to it.

Yes, I'm not keen on forcing this behaviour for everybody, as you never
know what other firmware might do with unexpected a6 values. Could we
perhaps quirk it, along the lines of the completely untested patch below?

Will

--->8

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 05070b72fc28..1895e87d0240 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -141,6 +141,8 @@ int main(void)
 #endif
   DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
   DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
+  DEFINE(ARM_SMCCC_RES_QUIRK_ID_OFFS,		offsetof(struct arm_smccc_res, quirk.id));
+  DEFINE(ARM_SMCCC_RES_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_res, quirk.state));
   BLANK();
   DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
   DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index ae0496fa4235..3c6c976eaf5c 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -12,6 +12,7 @@
  *
  */
 #include <linux/linkage.h>
+#include <linux/arm-smccc.h>
 #include <asm/asm-offsets.h>
 
 	.macro SMCCC instr
@@ -20,7 +21,12 @@
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
 	stp	x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
-	ret
+	ldr	x9, [x4, #ARM_SMCCC_RES_QUIRK_ID_OFFS]
+	cbz	x9, 1f /* ARM_SMCCC_QUIRK_NONE */
+	cmp	x9, #ARM_SMCCC_QUIRK_QCOM_A6
+	b.ne	1f
+	str	x6, [x4, ARM_SMCCC_RES_QUIRK_STATE_OFFS]
+1:	ret
 	.cfi_endproc
 	.endm
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index b5abfda80465..a3a6e291feb6 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -14,9 +14,6 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
-#include <linux/linkage.h>
-#include <linux/types.h>
-
 /*
  * This file provides common defines for ARM SMC Calling Convention as
  * specified in
@@ -60,6 +57,21 @@
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
 #define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
 
+#define ARM_SMCCC_QUIRK_NONE	0
+#define ARM_SMCCC_QUIRK_QCOM_A6	1 /* Save/restore register a6 */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/linkage.h>
+#include <linux/types.h>
+
+struct arm_smccc_quirk {
+	int	id;
+	union {
+		unsigned long a6;
+	} state;
+};
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
@@ -69,6 +81,7 @@ struct arm_smccc_res {
 	unsigned long a1;
 	unsigned long a2;
 	unsigned long a3;
+	struct arm_smccc_quirk quirk;
 };
 
 /**
@@ -101,4 +114,5 @@ asmlinkage void arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			unsigned long a5, unsigned long a6, unsigned long a7,
 			struct arm_smccc_res *res);
 
+#endif /* !__ASSEMBLY__ */
 #endif /*__LINUX_ARM_SMCCC_H*/

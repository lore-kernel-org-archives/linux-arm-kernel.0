From: jay.foad@gmail.com (Jay Foad)
Date: Wed, 26 Mar 2014 16:49:09 +0000
Subject: [PATCH] ARM: VFP: Fix emulation of multiply accumulate instructions
Message-ID: <1395852549-2745-1-git-send-email-jay.foad@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The emulation for single and double precision multiply accumulate
instructions correctly normalised any denormal values in the operand
registers, but failed to normalise the destination (accumulator)
register.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=70501

Signed-off-by: Jay Foad <jay.foad@gmail.com>
---
 arch/arm/vfp/vfpdouble.c | 2 ++
 arch/arm/vfp/vfpsingle.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/vfp/vfpdouble.c b/arch/arm/vfp/vfpdouble.c
index 6cac43bd1d86..423f56dd4028 100644
--- a/arch/arm/vfp/vfpdouble.c
+++ b/arch/arm/vfp/vfpdouble.c
@@ -866,6 +866,8 @@ vfp_double_multiply_accumulate(int dd, int dn, int dm, u32 fpscr, u32 negate, ch
 		vdp.sign = vfp_sign_negate(vdp.sign);
 
 	vfp_double_unpack(&vdn, vfp_get_double(dd));
+	if (vdn.exponent == 0 && vdn.significand)
+		vfp_double_normalise_denormal(&vdn);
 	if (negate & NEG_SUBTRACT)
 		vdn.sign = vfp_sign_negate(vdn.sign);
 
diff --git a/arch/arm/vfp/vfpsingle.c b/arch/arm/vfp/vfpsingle.c
index b252631b406b..4f96c1617aae 100644
--- a/arch/arm/vfp/vfpsingle.c
+++ b/arch/arm/vfp/vfpsingle.c
@@ -915,6 +915,8 @@ vfp_single_multiply_accumulate(int sd, int sn, s32 m, u32 fpscr, u32 negate, cha
 	v = vfp_get_float(sd);
 	pr_debug("VFP: s%u = %08x\n", sd, v);
 	vfp_single_unpack(&vsn, v);
+	if (vsn.exponent == 0 && vsn.significand)
+		vfp_single_normalise_denormal(&vsn);
 	if (negate & NEG_SUBTRACT)
 		vsn.sign = vfp_sign_negate(vsn.sign);
 
-- 
1.8.3.2

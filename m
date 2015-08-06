From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 05 Aug 2015 18:27:24 -0700
Subject: [PATCH v5 2/2] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1430249038-30987-2-git-send-email-galak@codeaurora.org>
References: <1430249038-30987-1-git-send-email-galak@codeaurora.org>
 <1430249038-30987-2-git-send-email-galak@codeaurora.org>
Message-ID: <55C2B7FC.5090402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2015 12:23 PM, Kumar Gala wrote:
> +
> +int __qcom_scm_call_armv8_64(u64 x0, u64 x1, u64 x2, u64 x3, u64 x4, u64 x5,
> +				u64 *ret1, u64 *ret2, u64 *ret3)
> +{
> +	register u64 r0 asm("r0") = x0;
> +	register u64 r1 asm("r1") = x1;
> +	register u64 r2 asm("r2") = x2;
> +	register u64 r3 asm("r3") = x3;
> +	register u64 r4 asm("r4") = x4;
> +	register u64 r5 asm("r5") = x5;

This should set x6 to 0.

     register u32 r6 asm("r6") = 0;

for example.

> +
> +	do {
> +		asm volatile(
> +			__asmeq("%0", "x0")
> +			__asmeq("%1", "x1")
> +			__asmeq("%2", "x2")
> +			__asmeq("%3", "x3")
> +			__asmeq("%4", "x0")
> +			__asmeq("%5", "x1")
> +			__asmeq("%6", "x2")
> +			__asmeq("%7", "x3")
> +			__asmeq("%8", "x4")
> +			__asmeq("%9", "x5")

And then the asmeq thing here for x6.

> +#ifdef REQUIRES_SEC
> +			".arch_extension sec\n"
> +#endif
> +			"smc	#0\n"
> +			: "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
> +			: "r" (r0), "r" (r1), "r" (r2), "r" (r3), "r" (r4),
> +			  "r" (r5)

And add x6 as an input here.

> +			: "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",

and remove x6 as a clobber.

> +			  "x14", "x15", "x16", "x17");
> +	} while (r0 == QCOM_SCM_INTERRUPTED);
> +
> +	if (ret1)
> +		*ret1 = r1;
> +	if (ret2)
> +		*ret2 = r2;
> +	if (ret3)
> +		*ret3 = r3;
> +
> +	return r0;
> +}
> +
> +int __qcom_scm_call_armv8_32(u32 w0, u32 w1, u32 w2, u32 w3, u32 w4, u32 w5,
> +				u64 *ret1, u64 *ret2, u64 *ret3)
> +{
> +	register u32 r0 asm("r0") = w0;
> +	register u32 r1 asm("r1") = w1;
> +	register u32 r2 asm("r2") = w2;
> +	register u32 r3 asm("r3") = w3;
> +	register u32 r4 asm("r4") = w4;
> +	register u32 r5 asm("r5") = w5;

This needs to set r6 to 0 as well

     register u32 r6 asm("r6") = 0;

for example.

> +
> +	do {
> +		asm volatile(
> +			__asmeq("%0", "x0")
> +			__asmeq("%1", "x1")
> +			__asmeq("%2", "x2")
> +			__asmeq("%3", "x3")
> +			__asmeq("%4", "x0")
> +			__asmeq("%5", "x1")
> +			__asmeq("%6", "x2")
> +			__asmeq("%7", "x3")
> +			__asmeq("%8", "x4")
> +			__asmeq("%9", "x5")

And then another asmeq thing here for x6.

> +#ifdef REQUIRES_SEC
> +			".arch_extension sec\n"
> +#endif
> +			"smc	#0\n"
> +			: "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
> +			: "r" (r0), "r" (r1), "r" (r2), "r" (r3), "r" (r4),
> +			  "r" (r5)

And then add r6 here as an input

> +			: "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",

And remove r6 from the clobber.

> +			"x14", "x15", "x16", "x17");
> +
> +	} while (r0 == QCOM_SCM_INTERRUPTED);
> +
> +	if (ret1)
> +		*ret1 = r1;
> +	if (ret2)
> +		*ret2 = r2;
> +	if (ret3)
> +		*ret3 = r3;
> +
> +	return r0;
> +}
> +
>

Here's a totally untested patch for that.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
----8<-----

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index a95fd9b5d576..8f7e65ff524c 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -114,6 +114,7 @@ int __qcom_scm_call_armv8_64(u64 x0, u64 x1, u64 x2, u64 x3, u64 x4, u64 x5,
  	register u64 r3 asm("r3") = x3;
  	register u64 r4 asm("r4") = x4;
  	register u64 r5 asm("r5") = x5;
+	register u64 r6 asm("r5") = 0;
  
  	do {
  		asm volatile(
@@ -127,14 +128,15 @@ int __qcom_scm_call_armv8_64(u64 x0, u64 x1, u64 x2, u64 x3, u64 x4, u64 x5,
  			__asmeq("%7", "x3")
  			__asmeq("%8", "x4")
  			__asmeq("%9", "x5")
+			__asmeq("%10", "x6")
  #ifdef REQUIRES_SEC
  			".arch_extension sec\n"
  #endif
  			"smc	#0\n"
  			: "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
  			: "r" (r0), "r" (r1), "r" (r2), "r" (r3), "r" (r4),
-			  "r" (r5)
-			: "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",
+			  "r" (r5), "r" (r6)
+			: "x7", "x8", "x9", "x10", "x11", "x12", "x13",
  			  "x14", "x15", "x16", "x17");
  	} while (r0 == QCOM_SCM_INTERRUPTED);
  
@@ -157,6 +159,7 @@ int __qcom_scm_call_armv8_32(u32 w0, u32 w1, u32 w2, u32 w3, u32 w4, u32 w5,
  	register u32 r3 asm("r3") = w3;
  	register u32 r4 asm("r4") = w4;
  	register u32 r5 asm("r5") = w5;
+	register u32 r6 asm("r6") = 0;
  
  	do {
  		asm volatile(
@@ -170,14 +173,15 @@ int __qcom_scm_call_armv8_32(u32 w0, u32 w1, u32 w2, u32 w3, u32 w4, u32 w5,
  			__asmeq("%7", "x3")
  			__asmeq("%8", "x4")
  			__asmeq("%9", "x5")
+			__asmeq("%10", "x6")
  #ifdef REQUIRES_SEC
  			".arch_extension sec\n"
  #endif
  			"smc	#0\n"
  			: "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)
  			: "r" (r0), "r" (r1), "r" (r2), "r" (r3), "r" (r4),
-			  "r" (r5)
-			: "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",
+			  "r" (r5), "r" (r6)
+			: "x7", "x8", "x9", "x10", "x11", "x12", "x13",
  			"x14", "x15", "x16", "x17");
  
  	} while (r0 == QCOM_SCM_INTERRUPTED);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

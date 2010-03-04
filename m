From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: indirect s2div and idx2s arrays via icst_params
References: <git-1267729916-d6819e2672c1b28c5b4e50c4f22e1895b85881aa@rmk-PC>
Message-ID: <git-1267729916-85cd101b49493ef8f37bb61c2b28c6905b9852e1@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/icst307.c                |   18 +++++++++++-------
 arch/arm/common/icst525.c                |   18 +++++++++++-------
 arch/arm/include/asm/hardware/icst.h     |    2 ++
 arch/arm/include/asm/hardware/icst307.h  |    3 +++
 arch/arm/include/asm/hardware/icst525.h  |    3 +++
 arch/arm/mach-integrator/cpu.c           |    4 ++++
 arch/arm/mach-integrator/impd1.c         |    2 ++
 arch/arm/mach-integrator/integrator_cp.c |    2 ++
 arch/arm/mach-realview/core.c            |    2 ++
 arch/arm/mach-versatile/core.c           |    2 ++
 10 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index 312485f..8332c07 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -22,11 +22,13 @@
 /*
  * Divisors for each OD setting.
  */
-static unsigned char s2div[8] = { 10, 2, 8, 4, 5, 7, 3, 6 };
+const unsigned char icst307_s2div[8] = { 10, 2, 8, 4, 5, 7, 3, 6 };
+
+EXPORT_SYMBOL(icst307_s2div);
 
 unsigned long icst307_hz(const struct icst_params *p, struct icst_vco vco)
 {
-	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * s2div[vco.s]);
+	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * p->s2div[vco.s]);
 }
 
 EXPORT_SYMBOL(icst307_hz);
@@ -34,7 +36,9 @@ EXPORT_SYMBOL(icst307_hz);
 /*
  * Ascending divisor S values.
  */
-static unsigned char idx2s[8] = { 1, 6, 3, 4, 7, 5, 2, 0 };
+const unsigned char icst307_idx2s[8] = { 1, 6, 3, 4, 7, 5, 2, 0 };
+
+EXPORT_SYMBOL(icst307_idx2s);
 
 struct icst_vco
 icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
@@ -48,19 +52,19 @@ icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
 	 * that the PLL output is within spec.
 	 */
 	do {
-		f = freq * s2div[idx2s[i]];
+		f = freq * p->s2div[p->idx2s[i]];
 
 		/*
 		 * f must be between 6MHz and 200MHz (3.3 or 5V)
 		 */
 		if (f > p->vco_min && f <= p->vco_max)
 			break;
-	} while (i < ARRAY_SIZE(idx2s));
+	} while (i < 8);
 
-	if (i >= ARRAY_SIZE(idx2s))
+	if (i >= 8)
 		return vco;
 
-	vco.s = idx2s[i];
+	vco.s = p->idx2s[i];
 
 	/*
 	 * Now find the closest divisor combination
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index da58965..4180255 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -19,11 +19,13 @@
 /*
  * Divisors for each OD setting.
  */
-static unsigned char s2div[8] = { 10, 2, 8, 4, 5, 7, 9, 6 };
+const unsigned char icst525_s2div[8] = { 10, 2, 8, 4, 5, 7, 9, 6 };
+
+EXPORT_SYMBOL(icst525_s2div);
 
 unsigned long icst525_hz(const struct icst_params *p, struct icst_vco vco)
 {
-	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * s2div[vco.s]);
+	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * p->s2div[vco.s]);
 }
 
 EXPORT_SYMBOL(icst525_hz);
@@ -31,7 +33,9 @@ EXPORT_SYMBOL(icst525_hz);
 /*
  * Ascending divisor S values.
  */
-static unsigned char idx2s[] = { 1, 3, 4, 7, 5, 2, 6, 0 };
+const unsigned char icst525_idx2s[8] = { 1, 3, 4, 7, 5, 2, 6, 0 };
+
+EXPORT_SYMBOL(icst525_idx2s);
 
 struct icst_vco
 icst525_hz_to_vco(const struct icst_params *p, unsigned long freq)
@@ -45,7 +49,7 @@ icst525_hz_to_vco(const struct icst_params *p, unsigned long freq)
 	 * that the PLL output is within spec.
 	 */
 	do {
-		f = freq * s2div[idx2s[i]];
+		f = freq * p->s2div[p->idx2s[i]];
 
 		/*
 		 * f must be between 10MHz and
@@ -53,12 +57,12 @@ icst525_hz_to_vco(const struct icst_params *p, unsigned long freq)
 		 */
 		if (f > p->vco_min && f <= p->vco_max)
 			break;
-	} while (i < ARRAY_SIZE(idx2s));
+	} while (i < 8);
 
-	if (i >= ARRAY_SIZE(idx2s))
+	if (i >= 8)
 		return vco;
 
-	vco.s = idx2s[i];
+	vco.s = p->idx2s[i];
 
 	/*
 	 * Now find the closest divisor combination
diff --git a/arch/arm/include/asm/hardware/icst.h b/arch/arm/include/asm/hardware/icst.h
index 6707c6a..4d40368 100644
--- a/arch/arm/include/asm/hardware/icst.h
+++ b/arch/arm/include/asm/hardware/icst.h
@@ -22,6 +22,8 @@ struct icst_params {
 	unsigned short	vd_max;		/* inclusive */
 	unsigned char	rd_min;		/* inclusive */
 	unsigned char	rd_max;		/* inclusive */
+	const unsigned char *s2div;	/* chip specific s2div array */
+	const unsigned char *idx2s;	/* chip specific idx2s array */
 };
 
 struct icst_vco {
diff --git a/arch/arm/include/asm/hardware/icst307.h b/arch/arm/include/asm/hardware/icst307.h
index 0f09618..d76fc6e 100644
--- a/arch/arm/include/asm/hardware/icst307.h
+++ b/arch/arm/include/asm/hardware/icst307.h
@@ -28,4 +28,7 @@ struct icst_vco icst307_hz_to_vco(const struct icst_params *p, unsigned long fre
 #define ICST307_VCO_MIN	6000000
 #define ICST307_VCO_MAX	200000000
 
+extern const unsigned char icst307_s2div[];
+extern const unsigned char icst307_idx2s[];
+
 #endif
diff --git a/arch/arm/include/asm/hardware/icst525.h b/arch/arm/include/asm/hardware/icst525.h
index 1000a60..2f9b953 100644
--- a/arch/arm/include/asm/hardware/icst525.h
+++ b/arch/arm/include/asm/hardware/icst525.h
@@ -27,4 +27,7 @@ struct icst_vco icst525_hz_to_vco(const struct icst_params *p, unsigned long fre
 #define ICST525_VCO_MAX_3V	200000000
 #define ICST525_VCO_MAX_5V	320000000
 
+extern const unsigned char icst525_s2div[];
+extern const unsigned char icst525_idx2s[];
+
 #endif
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 569306b..9481c54 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -39,6 +39,8 @@ static const struct icst_params lclk_params = {
 	.vd_max		= 132,
 	.rd_min		= 24,
 	.rd_max		= 24,
+	.s2div		= icst525_s2div,
+	.idx2s		= icst525_idx2s,
 };
 
 static const struct icst_params cclk_params = {
@@ -49,6 +51,8 @@ static const struct icst_params cclk_params = {
 	.vd_max		= 160,
 	.rd_min		= 24,
 	.rd_max		= 24,
+	.s2div		= icst525_s2div,
+	.idx2s		= icst525_idx2s,
 };
 
 /*
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 036cfb4..e24cfc3 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -48,6 +48,8 @@ static const struct icst_params impd1_vco_params = {
 	.vd_max		= 519,
 	.rd_min		= 3,
 	.rd_max		= 120,
+	.s2div		= icst525_s2div,
+	.idx2s		= icst525_idx2s,
 };
 
 static void impd1_setvco(struct clk *clk, struct icst_vco vco)
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 34c120a..9997d1f 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -276,6 +276,8 @@ static const struct icst_params cp_auxvco_params = {
 	.vd_max 	= 263,
 	.rd_min 	= 3,
 	.rd_max 	= 65,
+	.s2div		= icst525_s2div,
+	.idx2s		= icst525_idx2s,
 };
 
 static void cp_auxvco_set(struct clk *clk, struct icst_vco vco)
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 3ac4413..26d44ca 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -281,6 +281,8 @@ static const struct icst_params realview_oscvco_params = {
 	.vd_max		= 511 + 8,
 	.rd_min		= 1 + 2,
 	.rd_max		= 127 + 2,
+	.s2div		= icst307_s2div,
+	.idx2s		= icst307_idx2s,
 };
 
 static void realview_oscvco_set(struct clk *clk, struct icst_vco vco)
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index c4bf680..51d7aeb 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -387,6 +387,8 @@ static const struct icst_params versatile_oscvco_params = {
 	.vd_max		= 511 + 8,
 	.rd_min		= 1 + 2,
 	.rd_max		= 127 + 2,
+	.s2div		= icst307_s2div,
+	.idx2s		= icst307_idx2s,
 };
 
 static void versatile_oscvco_set(struct clk *clk, struct icst_vco vco)

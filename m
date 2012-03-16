From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 16 Mar 2012 18:37:23 +0100
Subject: [RFC/PATCH 3/4] pxa2xx: checkpatch fixes for clock-pxa25x.c and
 clock-pxa27x.c
Message-ID: <1331919443.31118.22.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

checkpatch.pl loudly complains about the previous patch. So we could use
the opportunity and squash this patch into it to address style issues.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/clock-pxa25x.c |   19 +++++++++----------
 arch/arm/mach-pxa/clock-pxa27x.c |   24 ++++++++++++------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-pxa/clock-pxa25x.c b/arch/arm/mach-pxa/clock-pxa25x.c
index d6f525c..53fd568 100644
--- a/arch/arm/mach-pxa/clock-pxa25x.c
+++ b/arch/arm/mach-pxa/clock-pxa25x.c
@@ -41,7 +41,7 @@ unsigned int pxa25x_get_clk_frequency_khz(int info)
 	unsigned int l, L, m, M, n2, N;
 
 	cccr = CCCR;
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (turbo) );
+	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (turbo));
 
 	l  =  L_clk_mult[(cccr >> 0) & 0x1f];
 	m  =  M_clk_mult[(cccr >> 5) & 0x03];
@@ -51,18 +51,17 @@ unsigned int pxa25x_get_clk_frequency_khz(int info)
 	M = m * L;
 	N = n2 * M / 2;
 
-	if(info)
-	{
+	if (info) {
 		L += 5000;
-		printk( KERN_INFO "Memory clock: %d.%02dMHz (*%d)\n",
-			L / 1000000, (L % 1000000) / 10000, l );
+		pr_info("Memory clock: %d.%02dMHz (*%d)\n",
+			L / 1000000, (L % 1000000) / 10000, l);
 		M += 5000;
-		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
-			M / 1000000, (M % 1000000) / 10000, m );
+		pr_info("Run Mode clock: %d.%02dMHz (*%d)\n",
+			M / 1000000, (M % 1000000) / 10000, m);
 		N += 5000;
-		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
-			N / 1000000, (N % 1000000) / 10000, n2 / 2, (n2 % 2) * 5,
-			(turbo & 1) ? "" : "in" );
+		pr_info("Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
+			N / 1000000, (N % 1000000) / 10000, n2 / 2,
+			(n2 % 2) * 5, (turbo & 1) ? "" : "in");
 	}
 
 	return (turbo & 1) ? (N/1000) : (M/1000);
diff --git a/arch/arm/mach-pxa/clock-pxa27x.c b/arch/arm/mach-pxa/clock-pxa27x.c
index dd97c6d..734864d 100644
--- a/arch/arm/mach-pxa/clock-pxa27x.c
+++ b/arch/arm/mach-pxa/clock-pxa27x.c
@@ -31,7 +31,7 @@ unsigned int pxa27x_get_clk_frequency_khz(int info)
 	cccr_a = CCCR & (1 << 25);
 
 	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
+	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
 	t  = clkcfg & (1 << 0);
 	ht = clkcfg & (1 << 2);
 	b  = clkcfg & (1 << 3);
@@ -46,15 +46,15 @@ unsigned int pxa27x_get_clk_frequency_khz(int info)
 	S  = (b) ? L : (L/2);
 
 	if (info) {
-		printk( KERN_INFO "Run Mode clock: %d.%02dMHz (*%d)\n",
-			L / 1000000, (L % 1000000) / 10000, l );
-		printk( KERN_INFO "Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
-			N / 1000000, (N % 1000000)/10000, n2 / 2, (n2 % 2)*5,
-			(t) ? "" : "in" );
-		printk( KERN_INFO "Memory clock: %d.%02dMHz (/%d)\n",
-			M / 1000000, (M % 1000000) / 10000, m );
-		printk( KERN_INFO "System bus clock: %d.%02dMHz \n",
-			S / 1000000, (S % 1000000) / 10000 );
+		pr_info("Run Mode clock: %d.%02dMHz (*%d)\n",
+			L / 1000000, (L % 1000000) / 10000, l);
+		pr_info("Turbo Mode clock: %d.%02dMHz (*%d.%d, %sactive)\n",
+			N / 1000000, (N % 1000000) / 10000, n2 / 2,
+			(n2 % 2) * 5, (t) ? "" : "in");
+		pr_info("Memory clock: %d.%02dMHz (/%d)\n",
+			M / 1000000, (M % 1000000) / 10000, m);
+		pr_info("System bus clock: %d.%02dMHz\n",
+			S / 1000000, (S % 1000000) / 10000);
 	}
 
 	return (t) ? (N/1000) : (L/1000);
@@ -73,7 +73,7 @@ static unsigned long clk_pxa27x_mem_getrate(struct clk *clk)
 	cccr_a = CCCR & (1 << 25);
 
 	/* Read clkcfg register: it has turbo, b, half-turbo (and f) */
-	asm( "mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg) );
+	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
 	b = clkcfg & (1 << 3);
 
 	l = ccsr & 0x1f;
@@ -107,7 +107,7 @@ static unsigned int pxa27x_get_lcdclk_frequency_10khz(void)
 	L = l * BASE_CLK;
 	K = L / k;
 
-	return (K / 10000);
+	return K / 10000;
 }
 
 static unsigned long clk_pxa27x_lcd_getrate(struct clk *clk)
-- 
1.7.9.1

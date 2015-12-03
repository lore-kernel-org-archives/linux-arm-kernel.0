From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2015 11:00:41 +0000
Subject: Domain faults when CONFIG_CPU_SW_DOMAIN_PAN is enabled
In-Reply-To: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
References: <1267b061b66c4d1fa8af1955825bc97a@EMAIL.axentia.se>
Message-ID: <20151203110041.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 08:33:13AM +0000, Peter Rosin wrote:
> I wrote:
> > If I enable CONFIG_CPU_SW_DOMAIN_PAN, I sometimes (but not always) get the
> > following (or very similar) on boot.
> 
> I should have said "if I don't disable", as the option is "default y".
> 
> Also, if it survives on boot, below is an example of later trouble (after
> 30+ minutes on this occasion).

Please apply this patch so we (might) get a slightly better oops dump,
and then try to reproduce.

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 7a7c4ce..92789ce 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -95,6 +95,22 @@ void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags;
 	char buf[64];
+#ifndef CONFIG_CPU_V7M
+	unsigned int domain;
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	/*
+	 * Get the domain register for the parent context. In user
+	 * mode, we don't save the DACR, so lets use what it should
+	 * be. For other modes, we place it after the pt_regs struct.
+	 */
+	if (user_mode(regs))
+		domain = DACR_UACCESS_ENABLE;
+	else
+		domain = *(unsigned int *)(regs + 1);
+#else
+	domain = get_domain();
+#endif
+#endif
 
 	show_regs_print_info(KERN_DEFAULT);
 
@@ -123,21 +139,8 @@ void __show_regs(struct pt_regs *regs)
 
 #ifndef CONFIG_CPU_V7M
 	{
-		unsigned int domain = get_domain();
 		const char *segment;
 
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
-		/*
-		 * Get the domain register for the parent context. In user
-		 * mode, we don't save the DACR, so lets use what it should
-		 * be. For other modes, we place it after the pt_regs struct.
-		 */
-		if (user_mode(regs))
-			domain = DACR_UACCESS_ENABLE;
-		else
-			domain = *(unsigned int *)(regs + 1);
-#endif
-
 		if ((domain & domain_mask(DOMAIN_USER)) ==
 		    domain_val(DOMAIN_USER, DOMAIN_NOACCESS))
 			segment = "none";
@@ -163,11 +166,11 @@ void __show_regs(struct pt_regs *regs)
 		buf[0] = '\0';
 #ifdef CONFIG_CPU_CP15_MMU
 		{
-			unsigned int transbase, dac = get_domain();
+			unsigned int transbase;
 			asm("mrc p15, 0, %0, c2, c0\n\t"
 			    : "=r" (transbase));
 			snprintf(buf, sizeof(buf), "  Table: %08x  DAC: %08x",
-			  	transbase, dac);
+			  	transbase, domain);
 		}
 #endif
 		asm("mrc p15, 0, %0, c1, c0\n" : "=r" (ctrl));

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

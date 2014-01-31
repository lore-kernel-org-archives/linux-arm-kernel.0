From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jan 2014 17:08:27 +0000
Subject: Why are imprecise external aborts masked on recent kernel
 while booting ?
In-Reply-To: <52EBC86D.1010509@st.com>
References: <52EBC86D.1010509@st.com>
Message-ID: <20140131170827.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 04:59:41PM +0100, Fabrice Gasnier wrote:
> Is it a desired change in recent kernels ?

I think it was an unnoticed behavioural change.

> Is it possible to unmask imprecise data aborts earlier in the boot  
> process (e.g. before PCIe bus enumeration, when drivers are being probed) 
> ?

How about this patch?

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 172ee18ff124..b0ff06f49cd0 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -900,6 +900,15 @@ void __init early_trap_init(void *vectors_base)
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
+
+	/* Enable imprecise aborts */
+	asm volatile(
+		"mrs	%0, cpsr\n"
+	"	bic	%0, %0, %1\n"
+	"	msr	cpsr_c, %0"
+		: "=&r" (i)
+		: "r" (PSR_A_BIT));
+
 #else /* ifndef CONFIG_CPU_V7M */
 	/*
 	 * on V7-M there is no need to copy the vector table to a dedicated


-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

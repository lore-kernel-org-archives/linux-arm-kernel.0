From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Feb 2012 12:15:44 +0000
Subject: [BUG] LPAE can be enabled with non-LPAE capable CPUs
In-Reply-To: <20120214082129.GD15338@n2100.arm.linux.org.uk>
References: <20120214082129.GD15338@n2100.arm.linux.org.uk>
Message-ID: <20120214121544.GB9050@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 08:21:29AM +0000, Russell King - ARM Linux wrote:
> The latest OMAP randconfig kautobuildv2 build has found the following issue:
> 
> arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
> arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
> arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
> arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
> 
> The config file indicates:
> 
> CONFIG_CPU_V6=y
> CONFIG_CPU_V7=y
> CONFIG_ARM_LPAE=y
> 
> As V6 CPUs don't support LPAE, this is an invalid configuration, which
> suggests that the constraints within Kconfig are insufficient for LPAE.
> Should ARM_LPAE depend on CPU_V7 && !CPU_32v6 && !CPU_32v5 && !CPU_32v4T
> && !CPU_32v4 && !CPU_32v3 ?

It makes sense. Something like this, unless you've already done it (I
also changed to CPU_32v7 for consistency):


commit d8d34065edfdc1b81f6e3886e15b5c2b2bd30b4e
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Tue Feb 14 12:12:58 2012 +0000

    ARM: Do not allow ARM_LPAE on pre-ARMv7 architectures
    
    This patch expands the Kconfig dependencies for ARM_LPAE to not allow
    enabling when architectures other than ARMv7 are built into the kernel.
    
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Reported-by: Russell King <linux@arm.linux.org.uk>

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 1a3ca24..7edef91 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -631,7 +631,8 @@ comment "Processor Features"
 
 config ARM_LPAE
 	bool "Support for the Large Physical Address Extension"
-	depends on MMU && CPU_V7
+	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
+		!CPU_32v4 && !CPU_32v3
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the


-- 
Catalin

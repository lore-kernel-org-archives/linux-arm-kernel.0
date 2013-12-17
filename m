From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 17 Dec 2013 15:34:18 -0500 (EST)
Subject: [PATCH 2/2] ARM: kconfig: select HAVE_EFFICIENT_UNALIGNED_ACCESS
 for CPUv6+ && MMU
In-Reply-To: <1387282577-2753-2-git-send-email-will.deacon@arm.com>
References: <1387282577-2753-1-git-send-email-will.deacon@arm.com>
 <1387282577-2753-2-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.10.1312171528130.7480@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Dec 2013, Will Deacon wrote:

> Modern ARM CPUs can perform efficient unaligned memory accesses in
> hardware and this feature is relied up on by code such as the dcache
> word-at-a-time name hashing.
> 
> This patch selects HAVE_EFFICIENT_UNALIGNED_ACCESS for these cores and
> reworks the kconfig select logic for DCACHE_WORD_ACCESS to use the new
> symbol.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

This symbol could be used in some more places too.  For example this 
would make the code a bit clearer:

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 72abdc541f..12c3a5decc 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -19,7 +19,7 @@
 #include <asm/unified.h>
 #include <asm/compiler.h>
 
-#if __LINUX_ARM_ARCH__ < 6
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 #include <asm-generic/uaccess-unaligned.h>
 #else
 #define __get_user_unaligned __get_user


Nicolas

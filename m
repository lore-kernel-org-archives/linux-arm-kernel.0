From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 12:29:20 -0800
Subject: [PATCH 1/7] ARM: v7: allow setting different cache functions
In-Reply-To: <20170118202927.28740-1-f.fainelli@gmail.com>
References: <20170118202927.28740-1-f.fainelli@gmail.com>
Message-ID: <20170118202927.28740-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding support for the Broadcom Brahma-B15 read-ahead
cache which requires a different set of cache functions, allow the
__v7_proc macro to override the cache_fns settings, and default to
v7_cache_fns unless specified otherwise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/proc-v7.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d00d52c9de3e..a7b270970e03 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -562,7 +562,7 @@ __v7_setup_stack:
 	/*
 	 * Standard v7 proc info content
 	 */
-.macro __v7_proc name, initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0, proc_fns = v7_processor_functions
+.macro __v7_proc name, initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0, proc_fns = v7_processor_functions, cache_fns = v7_cache_fns
 	ALT_SMP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
 			PMD_SECT_AF | PMD_FLAGS_SMP | \mm_mmuflags)
 	ALT_UP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
@@ -578,7 +578,7 @@ __v7_setup_stack:
 	.long	\proc_fns
 	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
-	.long	v7_cache_fns
+	.long	\cache_fns
 .endm
 
 #ifndef CONFIG_ARM_LPAE
-- 
2.9.3

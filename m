From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:11 +0200
Subject: [RFC PATCH 8/8] ARM: vmlinux.lds: Setup correct entry point to
 physical address
In-Reply-To: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
Message-ID: <1340019011-18642-9-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linker script setups entry point to virtual address.

Signed-off-by: Michal Simek <monstr@monstr.eu>

---
Not sure what is the reason to setup entry point to virtual address.
---
 arch/arm/kernel/vmlinux.lds.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b996bc0..de43b01 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -39,7 +39,7 @@
 #endif
 
 OUTPUT_ARCH(arm)
-ENTRY(stext)
+ENTRY(arm_start)
 
 #ifndef __ARMEB__
 jiffies = jiffies_64;
@@ -83,8 +83,10 @@ SECTIONS
 
 #ifdef CONFIG_XIP_KERNEL
 	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
+	arm_start = . ;
 #else
 	. = PAGE_OFFSET + TEXT_OFFSET;
+	arm_start = CONFIG_PHYS_OFFSET + TEXT_OFFSET;
 #endif
 	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
 		_text = .;
-- 
1.7.0.4

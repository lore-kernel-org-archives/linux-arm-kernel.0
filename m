From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:33 +0000
Subject: [RFC v3 PATCH 15/25] ARM: kexec: disallow kexec for NOMMU builds
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-16-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building for NOMMU the following error shows up:

kernel/built-in.o: In function `kimage_free_entry':
memremap.c:(.text+0x4dafc): undefined reference to `arch_phys_to_idmap_offset'
memremap.c:(.text+0x4db04): undefined reference to `arch_phys_to_idmap_offset'
kernel/built-in.o: In function `kimage_alloc_page':
memremap.c:(.text+0x4dbc0): undefined reference to `arch_phys_to_idmap_offset'
memremap.c:(.text+0x4dbc8): undefined reference to `arch_phys_to_idmap_offset'
memremap.c:(.text+0x4dc1c): undefined reference to `arch_phys_to_idmap_offset'

That comes from Kexec, add dependency on MMU there.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b5d529f..90c91de 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2019,7 +2019,7 @@ config XIP_PHYS_ADDR
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on (!SMP || PM_SLEEP_SMP)
-	depends on !CPU_V7M
+	depends on MMU
 	select KEXEC_CORE
 	help
 	  kexec is a system call that implements the ability to shutdown your
-- 
1.7.9.5

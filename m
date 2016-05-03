From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:22:26 +0100
Subject: [PATCH kexec-tools 16/32] arm: fix ELF32/ELF64 check
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXTG-0004iV-C6@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using ULONG_MAX to decide whether to use the ELF64 or ELF32
core dump format, use UINT32_MAX instead - we include stdint.h, so we
might as well use a constant which is meaningful for the limits of
the 32-bit ELF format.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index a390187..fcc4d42 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -369,8 +369,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	if (last_ranges < 0)
 		last_ranges = 0;
 
-	if (crash_memory_ranges[last_ranges].end > ULONG_MAX) {
-
+	if (crash_memory_ranges[last_ranges].end > UINT32_MAX) {
 		/* for support LPAE enabled kernel*/
 		elf_info.class = ELFCLASS64;
 
-- 
1.9.1

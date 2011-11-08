From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 14:46:06 +0000
Subject: [PATCH] ARM: setup: avoid overflowing {elf,
 arch}_name from proc_info_list
Message-ID: <1320763566-12183-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

setup_processor copies the arch_name and elf_name fields out of
the selected proc_info_list into two fixed size buffers.

Since the proc_info_list structure is defined in a proc_*.S
assembly file, this can lead to subtle errors if the strings
defined there are too long (for example, corrupting the machine ID).

This patch uses snprintf instead of sprintf to ensure that these
buffers are not overrun.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

I appreciate this is borderline pedantry, but it doesn't hurt. Plus, if
you are (for whatever reason) messing around with arch_name and elf_name,
hitting this bug is seriously painful!

 arch/arm/kernel/setup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7e7977a..3448a3f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -461,8 +461,10 @@ static void __init setup_processor(void)
 	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
 	       proc_arch[cpu_architecture()], cr_alignment);
 
-	sprintf(init_utsname()->machine, "%s%c", list->arch_name, ENDIANNESS);
-	sprintf(elf_platform, "%s%c", list->elf_name, ENDIANNESS);
+	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
+		 list->arch_name, ENDIANNESS);
+	snprintf(elf_platform, ELF_PLATFORM_SIZE, "%s%c",
+		 list->elf_name, ENDIANNESS);
 	elf_hwcap = list->elf_hwcap;
 #ifndef CONFIG_ARM_THUMB
 	elf_hwcap &= ~HWCAP_THUMB;
-- 
1.7.4.1

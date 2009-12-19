From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2009 17:10:51 -0800
Subject: [PATCH] arm: Flush TLB entries in setup_mm_for_reboot()
Message-ID: <mailman.99.1261245271.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to do that if we tinker with the MMU entries.

This fixes the occasional bug with kexec where the new
fails to uncompress with "crc error". Most likely at
least kexec on v6 and v7 need this fix.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8c7fbd1..a311080 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1068,4 +1068,6 @@ void setup_mm_for_reboot(char mode)
 		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
 		flush_pmd_entry(pmd);
 	}
+
+	local_flush_tlb_all();
 }

--jRHKVT23PllUwdXP--

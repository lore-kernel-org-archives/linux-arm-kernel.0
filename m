From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 01:10:19 -0000
Subject: [RFC 17/23] ARM: add machine desc hook for early memory/paging
 initialization
In-Reply-To: <1343092165-9470-1-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
Message-ID: <1343092165-9470-18-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a machine descriptor hook that gives control to machine
specific code prior to memory and paging initialization.

On Keystone platforms, this hook is used to switch the PHYS_OFFSET over
to the "real" non-32-bit-addressable address range.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/kernel/setup.c          |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 0b1c94b..49e9c2a 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -39,6 +39,7 @@ struct machine_desc {
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
+	void			(*init_meminfo)(void);
 	void			(*init_early)(void);
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e15d83b..7cbe292 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -964,6 +964,9 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	if (mdesc->init_meminfo)
+		mdesc->init_meminfo();
+
 	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
-- 
1.7.9.5

From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Wed, 18 Feb 2015 16:59:33 +0200
Subject: [PATCH 1/4] arm: of: Add a DT quirk method after unflattening
In-Reply-To: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
Message-ID: <1424271576-1952-2-git-send-email-pantelis.antoniou@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a per-machine dt_quirk() method to allow us to perform
device tree quirk processing after unflattening.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 arch/arm/include/asm/mach/arch.h | 1 +
 arch/arm/kernel/setup.c          | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 0406cb3..e873434 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -51,6 +51,7 @@ struct machine_desc {
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
 	void			(*dt_fixup)(void);
+	void			(*dt_quirk)(void);
 	void			(*init_meminfo)(void);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e55408e..e4c6eb5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -934,6 +934,9 @@ void __init setup_arch(char **cmdline_p)
 
 	unflatten_device_tree();
 
+	if (mdesc->dt_quirk)
+		mdesc->dt_quirk();
+
 	arm_dt_init_cpu_maps();
 	psci_init();
 #ifdef CONFIG_SMP
-- 
1.7.12

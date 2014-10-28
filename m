From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Oct 2014 13:24:20 +0100
Subject: [PATCH] arm64/dt: add machine name to kernel call stack dump output
Message-ID: <1414499060-6350-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This installs the machine name as recorded by setup_machine_fdt()
as dump stack arch description. This results in the string to be
included in call stack dumps, as is shown here:

  ...
  Bad mode in Synchronous Abort handler detected, code 0x84000005
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc2+ #548
> Hardware name: linux,dummy-virt (DT)
  task: ffffffc07c870000 ti: ffffffc07c878000 task.ti: ffffffc07c878000
  PC is at 0x0
  ...

Note that systems that support DMI/SMBIOS may override this later.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index a6028490a28f..da5dd36e4353 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -312,6 +312,7 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	}
 
 	machine_name = of_flat_dt_get_machine_name();
+	dump_stack_set_arch_desc("%s (DT)", machine_name);
 }
 
 /*
-- 
1.8.3.2

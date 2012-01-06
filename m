From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 6 Jan 2012 12:03:33 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120106120333.e3a0d1685099750bcba8606d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/mach-at91/at91cap9.c, arch/arm/mach-at91/at91sam9260.c,
arch/arm/mach-at91/at91sam9261.c, arch/arm/mach-at91/at91sam9263.c
arch/arm/mach-at91/at91sam9g45.c and arch/arm/mach-at91/at91sam9rl.c
between commits 1b2073e77894 ("ARM: restart: at91: use new restart hook")
and 8994cb50fee0 ("ARM: mach-at91: move special idle code out of line")
from the arm tree and commit f22deee523e0 ("ARM: at91: make shutdown
controler soc independent") from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-at91/at91cap9.c
index f1c829f,506a26c..0000000
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@@ -13,9 -13,7 +13,8 @@@
   */
  
  #include <linux/module.h>
- #include <linux/pm.h>
  
 +#include <asm/proc-fns.h>
  #include <asm/irq.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
@@@ -340,11 -328,16 +335,17 @@@ static void __init at91cap9_map_io(void
  	at91_init_sram(0, AT91CAP9_SRAM_BASE, AT91CAP9_SRAM_SIZE);
  }
  
+ static void __init at91cap9_ioremap_registers(void)
+ {
+ 	at91_ioremap_shdwc(AT91CAP9_BASE_SHDWC);
+ 	at91sam926x_ioremap_pit(AT91CAP9_BASE_PIT);
+ 	at91sam9_ioremap_smc(0, AT91CAP9_BASE_SMC);
+ }
+ 
  static void __init at91cap9_initialize(void)
  {
 -	at91_arch_reset = at91cap9_reset;
 +	arm_pm_idle = at91cap9_idle;
 +	arm_pm_restart = at91cap9_restart;
- 	pm_power_off = at91cap9_poweroff;
  	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
  
  	/* Register GPIO subsystem */

diff --cc arch/arm/mach-at91/at91sam9260.c
index f2237ac,3a960d2..0000000
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@@ -11,9 -11,7 +11,8 @@@
   */
  
  #include <linux/module.h>
- #include <linux/pm.h>
  
 +#include <asm/proc-fns.h>
  #include <asm/irq.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
@@@ -326,17 -320,16 +321,23 @@@ static void __init at91sam9260_map_io(v
  	}
  }
  
 +static void at91sam9260_idle(void)
 +{
 +	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
 +	cpu_do_idle();
 +}
 +
+ static void __init at91sam9260_ioremap_registers(void)
+ {
+ 	at91_ioremap_shdwc(AT91SAM9260_BASE_SHDWC);
+ 	at91sam926x_ioremap_pit(AT91SAM9260_BASE_PIT);
+ 	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
+ }
+ 
  static void __init at91sam9260_initialize(void)
  {
 -	at91_arch_reset = at91sam9_alt_reset;
 +	arm_pm_idle = at91sam9260_idle;
 +	arm_pm_restart = at91sam9_alt_restart;
- 	pm_power_off = at91sam9260_poweroff;
  	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
  			| (1 << AT91SAM9260_ID_IRQ2);
  
diff --cc arch/arm/mach-at91/at91sam9261.c
index 40ac620,a0538c5..0000000
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@@ -11,9 -11,7 +11,8 @@@
   */
  
  #include <linux/module.h>
- #include <linux/pm.h>
  
 +#include <asm/proc-fns.h>
  #include <asm/irq.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
@@@ -286,17 -278,16 +279,23 @@@ static void __init at91sam9261_map_io(v
  		at91_init_sram(0, AT91SAM9261_SRAM_BASE, AT91SAM9261_SRAM_SIZE);
  }
  
 +static void at91sam9261_idle(void)
 +{
 +	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
 +	cpu_do_idle();
 +}
 +
+ static void __init at91sam9261_ioremap_registers(void)
+ {
+ 	at91_ioremap_shdwc(AT91SAM9261_BASE_SHDWC);
+ 	at91sam926x_ioremap_pit(AT91SAM9261_BASE_PIT);
+ 	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
+ }
+ 
  static void __init at91sam9261_initialize(void)
  {
 -	at91_arch_reset = at91sam9_alt_reset;
 +	arm_pm_idle = at91sam9261_idle;
 +	arm_pm_restart = at91sam9_alt_restart;
- 	pm_power_off = at91sam9261_poweroff;
  	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
  			| (1 << AT91SAM9261_ID_IRQ2);
  
diff --cc arch/arm/mach-at91/at91sam9263.c
index 5e2485b,5ffbbb0..0000000
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@@ -11,9 -11,7 +11,8 @@@
   */
  
  #include <linux/module.h>
- #include <linux/pm.h>
  
 +#include <asm/proc-fns.h>
  #include <asm/irq.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
@@@ -304,17 -298,17 +299,24 @@@ static void __init at91sam9263_map_io(v
  	at91_init_sram(1, AT91SAM9263_SRAM1_BASE, AT91SAM9263_SRAM1_SIZE);
  }
  
 +static void at91sam9263_idle(void)
 +{
 +	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
 +	cpu_do_idle();
 +}
 +
+ static void __init at91sam9263_ioremap_registers(void)
+ {
+ 	at91_ioremap_shdwc(AT91SAM9263_BASE_SHDWC);
+ 	at91sam926x_ioremap_pit(AT91SAM9263_BASE_PIT);
+ 	at91sam9_ioremap_smc(0, AT91SAM9263_BASE_SMC0);
+ 	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
+ }
+ 
  static void __init at91sam9263_initialize(void)
  {
 -	at91_arch_reset = at91sam9_alt_reset;
 +	arm_pm_idle = at91sam9263_idle;
 +	arm_pm_restart = at91sam9_alt_restart;
- 	pm_power_off = at91sam9263_poweroff;
  	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
  
  	/* Register GPIO subsystem */
diff --cc arch/arm/mach-at91/at91sam9g45.c
index e3a0f0c,f61eb64..0000000
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@@ -344,11 -333,16 +339,17 @@@ static void __init at91sam9g45_map_io(v
  	init_consistent_dma_size(SZ_4M);
  }
  
+ static void __init at91sam9g45_ioremap_registers(void)
+ {
+ 	at91_ioremap_shdwc(AT91SAM9G45_BASE_SHDWC);
+ 	at91sam926x_ioremap_pit(AT91SAM9G45_BASE_PIT);
+ 	at91sam9_ioremap_smc(0, AT91SAM9G45_BASE_SMC);
+ }
+ 
  static void __init at91sam9g45_initialize(void)
  {
 -	at91_arch_reset = at91sam9g45_reset;
 +	arm_pm_idle = at91sam9g45_idle;
 +	arm_pm_restart = at91sam9g45_restart;
- 	pm_power_off = at91sam9g45_poweroff;
  	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
  
  	/* Register GPIO subsystem */
diff --cc arch/arm/mach-at91/at91sam9rl.c
index 5309b44,96247f6..0000000
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@@ -10,9 -10,7 +10,8 @@@
   */
  
  #include <linux/module.h>
- #include <linux/pm.h>
  
 +#include <asm/proc-fns.h>
  #include <asm/irq.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
@@@ -291,17 -283,16 +284,23 @@@ static void __init at91sam9rl_map_io(vo
  	at91_init_sram(0, AT91SAM9RL_SRAM_BASE, sram_size);
  }
  
 +static void at91sam9rl_idle(void)
 +{
 +	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
 +	cpu_do_idle();
 +}
 +
+ static void __init at91sam9rl_ioremap_registers(void)
+ {
+ 	at91_ioremap_shdwc(AT91SAM9RL_BASE_SHDWC);
+ 	at91sam926x_ioremap_pit(AT91SAM9RL_BASE_PIT);
+ 	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
+ }
+ 
  static void __init at91sam9rl_initialize(void)
  {
 -	at91_arch_reset = at91sam9_alt_reset;
 +	arm_pm_idle = at91sam9rl_idle;
 +	arm_pm_restart = at91sam9_alt_restart;
- 	pm_power_off = at91sam9rl_poweroff;
  	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
  
  	/* Register GPIO subsystem */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/f9f64d86/attachment-0001.sig>

From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 23 Jan 2013 16:25:37 +1100
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20130123162537.b4285c002892dde1405559a6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in
arch/arm/mach-tegra/common.c between commit 0529e315bbda ("ARM: use
common irqchip_init for GIC init") from the arm-soc tree and commit
567f70da22d2 ("ARM: tegra: migrate to new clock code") from the tegra
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/common.c
index 3599959,87dd69c..0000000
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@@ -21,9 -21,11 +21,10 @@@
  #include <linux/io.h>
  #include <linux/clk.h>
  #include <linux/delay.h>
 -#include <linux/of_irq.h>
 +#include <linux/irqchip.h>
+ #include <linux/clk/tegra.h>
  
  #include <asm/hardware/cache-l2x0.h>
 -#include <asm/hardware/gic.h>
  
  #include <mach/powergate.h>
  
@@@ -56,10 -58,16 +57,11 @@@ u32 tegra_uart_config[4] = 
  };
  
  #ifdef CONFIG_OF
 -static const struct of_device_id tegra_dt_irq_match[] __initconst = {
 -	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
 -	{ }
 -};
 -
  void __init tegra_dt_init_irq(void)
  {
+ 	tegra_clocks_init();
  	tegra_init_irq();
 -	of_irq_init(tegra_dt_irq_match);
 +	irqchip_init();
  }
  #endif
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/0d84bbac/attachment.sig>

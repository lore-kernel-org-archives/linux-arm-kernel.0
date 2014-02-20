From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Feb 2014 11:42:42 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20140220114242.b3ce4d77b677544d2feebd3e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got conflicts in
arch/arm/mach-imx/Makefile and arch/arm/mach-imx/common.h between commit
28a9f3b078c5 ("ARM: imx6: build pm-imx6q.c independently of CONFIG_PM")
from the arm-soc tree and commits 8dd751932545 ("ARM: imx: add suspend in
ocram support for i.mx6q") and 79a8eef47d12 ("RM: imx: add suspend in
ocram support for i.mx6sl") from the imx-mxs tree.

I fixed it up (I think, see below) and can carry the fix as necessary (no
action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/Makefile
index ec419649320f,02cbb48c1d0a..000000000000
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@@ -101,10 -102,13 +102,17 @@@ obj-$(CONFIG_HOTPLUG_CPU) += hotplug.
  obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
  
 +obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
 +# i.MX6SL reuses i.MX6Q code
 +obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
 +
+ ifeq ($(CONFIG_PM),y)
+ AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 -obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o suspend-imx6.o
++obj-$(CONFIG_SOC_IMX6Q) += suspend-imx6.o
+ # i.MX6SL reuses i.MX6Q code
 -obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o suspend-imx6.o
++obj-$(CONFIG_SOC_IMX6SL) += suspend-imx6.o
+ endif
+ 
  # i.MX5 based machines
  obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
  obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
diff --cc arch/arm/mach-imx/common.h
index baf439dc22d8,4dd932af708c..000000000000
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@@ -144,11 -145,19 +145,17 @@@ void imx6sl_set_wait_clk(bool enter)
  void imx_cpu_die(unsigned int cpu);
  int imx_cpu_kill(unsigned int cpu);
  
 +void imx6q_pm_init(void);
 +void imx6q_pm_set_ccm_base(void __iomem *base);
  #ifdef CONFIG_PM
+ void imx6_suspend(void __iomem *ocram_vbase);
 -void imx6q_pm_init(void);
+ void imx6dl_pm_init(void);
+ void imx6sl_pm_init(void);
 -void imx6q_pm_set_ccm_base(void __iomem *base);
  void imx5_pm_init(void);
  #else
+ static inline void imx6_suspend(void __iomem *ocram_vbase) {}
 -static inline void imx6q_pm_init(void) {}
+ static inline void imx6dl_pm_init(void) {}
+ static inline void imx6sl_pm_init(void) {}
 -static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
  static inline void imx5_pm_init(void) {}
  #endif
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/6369c240/attachment.sig>

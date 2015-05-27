From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 27 May 2015 21:30:51 +0300
Subject: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
In-Reply-To: <20150526163931.GO26599@saruman.tx.rr.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <20150526160557.GD16525@atomide.com> <20150526163216.GF16525@atomide.com>
 <20150526163931.GO26599@saruman.tx.rr.com>
Message-ID: <55660D5B.8020607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 07:39 PM, Felipe Balbi wrote:
> On Tue, May 26, 2015 at 09:32:16AM -0700, Tony Lindgren wrote:
>> * Tony Lindgren <tony@atomide.com> [150526 09:08]:
>>> * Tero Kristo <t-kristo@ti.com> [150525 08:01]:
>>>> Hi,
>>>>
>>>> As requested, posting v3 with somewhat changed diff parameters and
>>>> diffstat attached. Just some minor Makefile changes compared to v2,
>>>> these were discussed under that set.
>>>>
>>>> Set has been pushed to:
>>>> - tree: https://github.com/t-kristo/linux-pm.git
>>>> - branch: for-4.2/ti-clk-move
>>>
>>> Looks like this causes a build error for at least omap2 only .config:
>>>
>>> drivers/clk/ti/dpll3xxx.o:(.rodata+0x1c): multiple definition of `clkhwops_omap3_dpll'
>>> drivers/clk/ti/dpll.o:(.rodata+0x0): first defined here
>>>
>>> You may want to create a file selecting ARCH_OMAP2PLUS=y, then point
>>> KCONFIG_ALLCONFIG to that file for make randconfig. Then just build
>>> randconfigs :) Usually the issues like this are exposed within few
>>> randconfig builds, some take longer if the options have dependencies.
>
> alternatively, just clone the repository at [1] and use the example
> script provided in README.md.
>
> [1] https://github.com/felipebalbi/omap-seeds
>

Ok, I pushed an updated branch named: for-4.2/ti-clk-move-v4

This definitely compiles with OMAP2 / OMAP3 / OMAP4 / OMAP5 / DRA7 / 
AM33xx / AM43xx only setups (tried it out.)

The extra diff compared to v3 inlined here, the changes have been 
squashed to the branch itself:
====================

diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index fc6fe8c..9b93e69 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,18 +1,19 @@
  obj-y					+= clk.o autoidle.o clockdomain.o
  clk-common				= dpll.o composite.o divider.o gate.o \
  					  fixed-factor.o mux.o apll.o \
-					  clkt_dpll.o clkt_iclk.o dpll3xxx.o \
-					  clkt_dflt.o
-obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
+					  clkt_dpll.o clkt_iclk.o clkt_dflt.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o dpll3xxx.o
  obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
  obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
  obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o \
-					   clk-3xxx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o dpll44xx.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o dpll44xx.o
+					   clk-3xxx.o dpll3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o \
+					   dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o \
+					   dpll3xxx.o dpll44xx.o
  obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o \
-					   clk-dra7-atl.o dpll44xx.o
-obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
+					   clk-dra7-atl.o dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) dpll3xxx.o clk-43xx.o

  ifdef CONFIG_ATAGS
  obj-$(CONFIG_ARCH_OMAP3)                += clk-3xxx-legacy.o
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 786ab59..e8d7d13 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -402,6 +402,7 @@ int __init ti_clk_register_legacy_clks(struct 
ti_clk_alias *clks)

  	return 0;
  }
+#endif

  /**
   * ti_clk_setup_features - setup clock features flags
@@ -449,4 +450,3 @@ void omap2_clk_enable_init_clocks(const char 
**clk_names, u8 num_clocks)
  		clk_prepare_enable(init_clk);
  	}
  }
-#endif

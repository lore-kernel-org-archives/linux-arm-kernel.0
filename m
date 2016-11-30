From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 16:41:44 +0100
Subject: [GIT PULL] Renesas ARM Based SoC r8a7745 SYSC Driver Updates for
 v4.10
In-Reply-To: <cover.1479929914.git.horms+renesas@verge.net.au>
References: <cover.1479929914.git.horms+renesas@verge.net.au>
Message-ID: <6771303.aO3HWCNlGW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 9:13:10 PM CET Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC r8a7745 SYSC Driver updates for
> v4.10.
> 
> This pull request is based on v4.9-rc1.
> 
> This pull request is broken out of an earlier pull request,
> "Second Round of Renesas ARM Based SoC Drivers Updates for v4.10".
> The motivation for breaking up the pull request is to provide
> branches with minimal dependencies.
> 
> This pull request is targeted at the next/drivers branch of the arm-soc tree.
> 
> It introduces some minor merge conflicts in:
>     Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
>     drivers/soc/renesas/Makefile
>     drivers/soc/renesas/rcar-sysc.c
>     drivers/soc/renesas/rcar-sysc.h
> The resolution is to take both sides. A sample merge resolution is
> provided in the renesas-next-20161123v2-v4.9-rc1 tag of the renesas tree.
> 

Pulled into next/drivers, thanks!

	Arnd


diff --cc Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index c16ec18,1375758..d91715b
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@@ -7,7 -7,7 +7,8 @@@ and various coprocessors
  
  Required properties:
    - compatible: Must contain exactly one of the following:
 +      - "renesas,r8a7743-sysc" (RZ/G1M)
+       - "renesas,r8a7745-sysc" (RZ/G1E)
        - "renesas,r8a7779-sysc" (R-Car H1)
        - "renesas,r8a7790-sysc" (R-Car H2)
        - "renesas,r8a7791-sysc" (R-Car M2-W)
diff --cc drivers/soc/renesas/Makefile
index 9e0bb32,a25a628..e2249f0
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@@ -1,4 -1,4 +1,5 @@@
 +obj-$(CONFIG_ARCH_R8A7743)	+= rcar-sysc.o r8a7743-sysc.o
+ obj-$(CONFIG_ARCH_R8A7745)	+= rcar-sysc.o r8a7745-sysc.o
  obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
  obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
  obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
diff --cc drivers/soc/renesas/rcar-sysc.c
index 71acd45,a4e1bb0..225c35c
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@@ -275,9 -275,9 +275,12 @@@ finalize
  }
  
  static const struct of_device_id rcar_sysc_matches[] = {
 +#ifdef CONFIG_ARCH_R8A7743
 +	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
 +#endif
+ #ifdef CONFIG_ARCH_R8A7745
+ 	{ .compatible = "renesas,r8a7745-sysc", .data = &r8a7745_sysc_info },
+ #endif
  #ifdef CONFIG_ARCH_R8A7779
  	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
  #endif
diff --cc drivers/soc/renesas/rcar-sysc.h
index 8ab9ca8,3048dd3..f6e842e
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@@ -50,7 -50,7 +50,8 @@@ struct rcar_sysc_info 
  	unsigned int num_areas;
  };
  
 +extern const struct rcar_sysc_info r8a7743_sysc_info;
+ extern const struct rcar_sysc_info r8a7745_sysc_info;
  extern const struct rcar_sysc_info r8a7779_sysc_info;
  extern const struct rcar_sysc_info r8a7790_sysc_info;
  extern const struct rcar_sysc_info r8a7791_sysc_info;

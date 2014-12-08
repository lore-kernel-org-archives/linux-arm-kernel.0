From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 17:21:46 +0100
Subject: [PATCH for-next] bus: brcmstb_gisb: use gdev_{read,
 write} in suspend/resume paths
In-Reply-To: <1417806943-1200-1-git-send-email-f.fainelli@gmail.com>
References: <1417806943-1200-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <2389008.cu7vrshMx6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 December 2014 11:15:43 Florian Fainelli wrote:
> This patch fixes a small merge issue between:
> Commit 2b53eadcea05 ("bus: brcmstb_gisb: Introduce wrapper functions for
> MMIO accesses") and 203bb85ed605 ("bus: brcmstb_gisb: save and restore
> GISB timeout"), the former introducing wrapper I/O accessors to be
> decoupled from the register offsets and use table, while the latter had
> not been converted to using these wrapper.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Arnd, Olof,
> 
> This applies on top of your arm-soc/for-next branch as of
> 921caee4a849443bcda286f903b6ec01c5aa7fd8 ("arm-soc: document merges")

I've resolved this now by merging the brcm/stb-smp-uart branch that
we already had in next/soc into next/drivers as well, which also saves
Linus from having to do the same merge.

I have folded both Olof's fixup and your patch into the merge.

commit 7135466151f0560604c2bfc4c27ff9cc2a40f8cd
Merge: 6b34df9e30c8 203bb85ed605
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Dec 8 17:16:03 2014 +0100

    Merge branch 'brcm/stb-smp-uart' into next/drivers
    
    This resolves a nonobvious merge conflict that I got wrong the
    first time.
    
    * brcm/stb-smp-uart:
      bus: brcmstb_gisb: save and restore GISB timeout
      bus: brcmstb_gisb: register the fault code hook
      ARM: brcmstb: Kconfig: drop unneeded symbol selections
      ARM: brcmstb: reintroduce SMP support
      ARM: brcmstb: add debug UART for earlyprintk support
    
    Conflicts:
    	drivers/bus/brcmstb_gisb.c
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Reported-by: Florian Fainelli <f.fainelli@gmail.com>

diff --cc drivers/bus/brcmstb_gisb.c
index bfd40f11e921,e7ccd21a45c9..46de8dc39eb4
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@@ -23,13 -23,18 +23,14 @@@
  #include <linux/list.h>
  #include <linux/of.h>
  #include <linux/bitops.h>
+ #include <linux/pm.h>
  
 +#ifdef CONFIG_ARM
  #include <asm/bug.h>
  #include <asm/signal.h>
 +#endif
  
 -#define ARB_TIMER			0x008
 -#define ARB_ERR_CAP_CLR			0x7e4
  #define  ARB_ERR_CAP_CLEAR		(1 << 0)
 -#define ARB_ERR_CAP_HI_ADDR		0x7e8
 -#define ARB_ERR_CAP_ADDR		0x7ec
 -#define ARB_ERR_CAP_DATA		0x7f0
 -#define ARB_ERR_CAP_STATUS		0x7f4
  #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
  #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
  #define  ARB_ERR_CAP_STATUS_BS_SHIFT	(1 << 2)
@@@ -226,13 -161,6 +228,7 @@@ static int brcmstb_bus_error_handler(un
  
  	return ret;
  }
- 
- void __init brcmstb_hook_fault_code(void)
- {
- 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
- 			"imprecise external abort");
- }
 +#endif
  
  static irqreturn_t brcmstb_gisb_timeout_handler(int irq, void *dev_id)
  {
@@@ -346,13 -257,55 +342,51 @@@ static int __init brcmstb_gisb_arb_prob
  
  	list_add_tail(&gdev->next, &brcmstb_gisb_arb_device_list);
  
++#ifdef CONFIG_ARM
+ 	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
+ 			"imprecise external abort");
++#endif
+ 
  	dev_info(&pdev->dev, "registered mem: %p, irqs: %d, %d\n",
  			gdev->base, timeout_irq, tea_irq);
  
  	return 0;
  }
  
+ #ifdef CONFIG_PM_SLEEP
+ static int brcmstb_gisb_arb_suspend(struct device *dev)
+ {
+ 	struct platform_device *pdev = to_platform_device(dev);
+ 	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+ 
 -	gdev->saved_timeout = ioread32(gdev->base + ARB_TIMER);
++	gdev->saved_timeout = gisb_read(gdev, ARB_TIMER);
+ 
+ 	return 0;
+ }
+ 
+ /* Make sure we provide the same timeout value that was configured before, and
+  * do this before the GISB timeout interrupt handler has any chance to run.
+  */
+ static int brcmstb_gisb_arb_resume_noirq(struct device *dev)
+ {
+ 	struct platform_device *pdev = to_platform_device(dev);
+ 	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+ 
 -	iowrite32(gdev->saved_timeout, gdev->base + ARB_TIMER);
++	gisb_write(gdev, gdev->saved_timeout, ARB_TIMER);
+ 
+ 	return 0;
+ }
+ #else
+ #define brcmstb_gisb_arb_suspend       NULL
+ #define brcmstb_gisb_arb_resume_noirq  NULL
+ #endif
+ 
+ static const struct dev_pm_ops brcmstb_gisb_arb_pm_ops = {
+ 	.suspend	= brcmstb_gisb_arb_suspend,
+ 	.resume_noirq	= brcmstb_gisb_arb_resume_noirq,
+ };
+ 
 -static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
 -	{ .compatible = "brcm,gisb-arb" },
 -	{ },
 -};
 -
  static struct platform_driver brcmstb_gisb_arb_driver = {
 -	.probe	= brcmstb_gisb_arb_probe,
  	.driver = {
  		.name	= "brcm-gisb-arb",
  		.owner	= THIS_MODULE,

From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 8 Aug 2012 12:53:59 +0200
Subject: imx6q restart is broken
In-Reply-To: <20120808101817.GA14718@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
Message-ID: <50224547.9020000@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2012 12:18, Shawn Guo wrote:
> Thanks Dirk for reporting that imx6q restart (reboot command) is broken.
> 
> I tracked down the issue a little bit and found imx6q_restart hangs
> on the of_iomap/ioremap call.  The following change, moving the call
> somewhere else than imx6q_restart, will just fix the problem.
> 
> Does that mean ioremap call is not allowed in platform restart hook?
> I'm not sure about that, because I found it works just fine if I build
> imx_v6_v7_defconfig with V6 (imx3) platforms excluded (IOW, build a V7
> only kernel - imx5 and imx6), which is the case how I tested imx6q
> restart feature when I was adding it.
> 
> To summarize, the imx6q_restart hangs at ioremap call on a V6 + V7
> kernel, while it works fine on a V7 only image.  I need some help to
> understand that.

Some additional information from my debugging:

a) Having a JTAG debugger attached to the i.MX6 SabreLite board I use 
(kernel built with imx_v6_v7_defconfig) the reboot does work. No hang. 
This does mean I can't debug the reboot hang with a JTAG debugger. 
Therefore I added some printk debugging:

b) Adding some printk statements [1] in the of_iomap/ioremap call, it 
looks to me that the system hangs in

of_iomap() -> ... -> set_pte_at() -> set_pte_ext() / 
cpu_v7_set_pte_ext() <= hang

On our system, set_pte_ext() is translated to cpu_v7_set_pte_ext() in 
proc-v7-2level.S.

As cpu_v7_set_pte_ext() is assembly, I can't add additional printk's, 
and JTAG doesn't work, so I don't have more details@the moment.

 From this it looks like that cpu_v7_set_pte_ext() hangs if called from 
within machine_restart() after machine_shutdown() was called (?).

Best regards

Dirk

[1] To be able to add some printk's to set_pte_at() which is a inline 
function in pgtable.h, I copied this to ioremap.c:

--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -13,6 +13,19 @@
  #include <asm/cacheflush.h>
  #include <asm/pgtable.h>

+void set_pte_debug(struct mm_struct *mm, unsigned long addr,
+                             pte_t *ptep, pte_t pteval)
+{
+       if (addr >= TASK_SIZE) {
+               printk("=> set_pte_debug #1\n");
+               set_pte_ext(ptep, pteval, 0);
+               printk("=> set_pte_debug #2\n");
+       } else {
+               __sync_icache_dcache(pteval);
+               set_pte_ext(ptep, pteval, PTE_EXT_NG);
+       }
+}
+
  static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
                 unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
  {
@@ -25,7 +38,7 @@ static int ioremap_pte_range(pmd_t *pmd, unsigned long 
addr,
                 return -ENOMEM;
         do {
                 BUG_ON(!pte_none(*pte));
-               set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
+               set_pte_debug(&init_mm, addr, pte, pfn_pte(pfn, prot));
                 pfn++;
         } while (pte++, addr += PAGE_SIZE, addr != end);
         return 0;

With this I get:

# reboot -f
Restarting system.
=> set_pte_debug #1

-- no further output, hang, 'set_pte_debug #2' missing

> --8<---
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 5ec0608..01e7489 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -37,14 +37,10 @@
>  #include <mach/cpuidle.h>
>  #include <mach/hardware.h>
> 
> +static void __iomem *wdog_base;
> 
>  void imx6q_restart(char mode, const char *cmd)
>  {
> -       struct device_node *np;
> -       void __iomem *wdog_base;
> -
> -       np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> -       wdog_base = of_iomap(np, 0);
>         if (!wdog_base)
>                 goto soft;
> 
> @@ -159,6 +155,11 @@ static void __init imx6q_usb_init(void)
> 
>  static void __init imx6q_init_machine(void)
>  {
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> +       wdog_base = of_iomap(np, 0);
> +
>         /*
>          * This should be removed when all imx6q boards have pinctrl
>          * states for devices defined in device tree.

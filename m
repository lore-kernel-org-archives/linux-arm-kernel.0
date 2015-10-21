From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Oct 2015 13:47:49 +0200
Subject: [RFC PATCH v6 3/3] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
Message-ID: <CAMuHMdWyvaecQHOzFnxVZus_Pfkxjw1XfkGdcLK=D2ThaoJMzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 11:32 AM, Yang Yingliang
<yangyingliang@huawei.com> wrote:
> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, the old affinity need
> to be updated and if irq_set_affinity's return value is IRQ_SET_MASK_OK_DONE,
> the old affinity can not be updated. Fix it by using irq_do_set_affinity.
>
> And migrating interrupts is a core code matter, so use the generic
> function irq_migrate_all_off_this_cpu() to migrate interrupts in
> kernel/irq/migration.c.
>
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/arm/Kconfig           |  1 +
>  arch/arm/include/asm/irq.h |  1 -
>  arch/arm/kernel/irq.c      | 62 ----------------------------------------------
>  arch/arm/kernel/smp.c      |  2 +-
>  4 files changed, 2 insertions(+), 64 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 72ad724..bffba78 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1492,6 +1492,7 @@ config NR_CPUS
>  config HOTPLUG_CPU
>         bool "Support for hot-pluggable CPUs"
>         depends on SMP
> +       select GENERIC_IRQ_MIGRATION

This causes the following warnings during s2ram on r8a7791/koelsch
(dual-core CA15):

 Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
 PM: Suspending system (mem)
 Suspending console(s) (use no_console_suspend to debug)
 PM: suspend of devices complete after 56.533 msecs
 PM: late suspend of devices complete after 21.229 msecs
 PM: noirq suspend of devices complete after 21.093 msecs
 Disabling non-boot CPUs ...
+IRQ0: unable to set affinity
+IRQ1: unable to set affinity
+IRQ2: unable to set affinity
+IRQ3: unable to set affinity
+IRQ4: unable to set affinity
+IRQ5: unable to set affinity
+IRQ6: unable to set affinity
+IRQ7: unable to set affinity
+IRQ8: unable to set affinity
+IRQ9: unable to set affinity
 CPU1: shutdown
 Enabling non-boot CPUs ...
 CPU1 is up
 PM: noirq resume of devices complete after 13.605 msecs
 PM: early resume of devices complete after 15.177 msecs

/proc/interrupts doesn't have IRQ[0-9].

Printing the irqchip's name and removing the rate limiting reveals:

chip none IRQ0: unable to set affinity
chip none IRQ1: unable to set affinity
chip none IRQ2: unable to set affinity
chip none IRQ3: unable to set affinity
chip none IRQ4: unable to set affinity
chip none IRQ5: unable to set affinity
chip none IRQ6: unable to set affinity
chip none IRQ7: unable to set affinity
chip none IRQ8: unable to set affinity
chip none IRQ9: unable to set affinity
chip none IRQ10: unable to set affinity
chip none IRQ11: unable to set affinity
chip none IRQ12: unable to set affinity
chip none IRQ13: unable to set affinity
chip none IRQ14: unable to set affinity
chip none IRQ15: unable to set affinity
chip e6050000.gpio IRQ128: unable to set affinity
chip e6050000.gpio IRQ129: unable to set affinity
chip e6050000.gpio IRQ130: unable to set affinity
chip e6050000.gpio IRQ131: unable to set affinity
chip e6050000.gpio IRQ132: unable to set affinity
chip e6050000.gpio IRQ133: unable to set affinity
chip e6050000.gpio IRQ134: unable to set affinity
chip e6050000.gpio IRQ135: unable to set affinity
chip e6050000.gpio IRQ136: unable to set affinity
chip e6050000.gpio IRQ137: unable to set affinity
chip e6050000.gpio IRQ138: unable to set affinity
chip e6050000.gpio IRQ139: unable to set affinity
chip e6050000.gpio IRQ140: unable to set affinity
chip e6050000.gpio IRQ141: unable to set affinity
chip e6050000.gpio IRQ142: unable to set affinity
chip e6050000.gpio IRQ143: unable to set affinity
chip e6050000.gpio IRQ144: unable to set affinity
chip e6050000.gpio IRQ145: unable to set affinity
chip e6050000.gpio IRQ146: unable to set affinity
chip e6050000.gpio IRQ147: unable to set affinity
chip e6050000.gpio IRQ148: unable to set affinity
chip e6050000.gpio IRQ149: unable to set affinity
chip e6050000.gpio IRQ150: unable to set affinity
chip e6050000.gpio IRQ151: unable to set affinity
chip e6050000.gpio IRQ152: unable to set affinity
chip e6050000.gpio IRQ153: unable to set affinity
chip e6050000.gpio IRQ154: unable to set affinity
chip e6050000.gpio IRQ155: unable to set affinity
chip e6050000.gpio IRQ156: unable to set affinity
chip e6050000.gpio IRQ157: unable to set affinity
chip e6050000.gpio IRQ158: unable to set affinity
chip e6050000.gpio IRQ159: unable to set affinity
chip e6051000.gpio IRQ160: unable to set affinity
chip e6051000.gpio IRQ161: unable to set affinity
chip e6051000.gpio IRQ162: unable to set affinity
chip e6051000.gpio IRQ163: unable to set affinity
chip e6051000.gpio IRQ164: unable to set affinity
chip e6051000.gpio IRQ165: unable to set affinity
chip e6051000.gpio IRQ166: unable to set affinity
chip e6051000.gpio IRQ167: unable to set affinity
chip e6051000.gpio IRQ168: unable to set affinity
chip e6051000.gpio IRQ169: unable to set affinity
chip e6051000.gpio IRQ170: unable to set affinity
chip e6051000.gpio IRQ171: unable to set affinity
chip e6051000.gpio IRQ172: unable to set affinity
chip e6051000.gpio IRQ173: unable to set affinity
chip e6051000.gpio IRQ174: unable to set affinity
chip e6051000.gpio IRQ175: unable to set affinity
chip e6051000.gpio IRQ176: unable to set affinity
chip e6051000.gpio IRQ177: unable to set affinity
chip e6051000.gpio IRQ178: unable to set affinity
chip e6051000.gpio IRQ179: unable to set affinity
chip e6051000.gpio IRQ180: unable to set affinity
chip e6051000.gpio IRQ181: unable to set affinity
chip e6051000.gpio IRQ182: unable to set affinity
chip e6051000.gpio IRQ183: unable to set affinity
chip e6051000.gpio IRQ184: unable to set affinity
chip e6051000.gpio IRQ185: unable to set affinity
chip e6051000.gpio IRQ186: unable to set affinity
chip e6051000.gpio IRQ187: unable to set affinity
chip e6051000.gpio IRQ188: unable to set affinity
chip e6051000.gpio IRQ189: unable to set affinity
chip e6051000.gpio IRQ190: unable to set affinity
chip e6051000.gpio IRQ191: unable to set affinity
chip e6052000.gpio IRQ192: unable to set affinity
chip e6052000.gpio IRQ193: unable to set affinity
chip e6052000.gpio IRQ194: unable to set affinity
chip e6052000.gpio IRQ195: unable to set affinity
chip e6052000.gpio IRQ196: unable to set affinity
chip e6052000.gpio IRQ197: unable to set affinity
chip e6052000.gpio IRQ198: unable to set affinity
chip e6052000.gpio IRQ199: unable to set affinity
chip e6052000.gpio IRQ200: unable to set affinity
chip e6052000.gpio IRQ201: unable to set affinity
chip e6052000.gpio IRQ202: unable to set affinity
chip e6052000.gpio IRQ203: unable to set affinity
chip e6052000.gpio IRQ204: unable to set affinity
chip e6052000.gpio IRQ205: unable to set affinity
chip e6052000.gpio IRQ206: unable to set affinity
chip e6052000.gpio IRQ207: unable to set affinity
chip e6052000.gpio IRQ208: unable to set affinity
chip e6052000.gpio IRQ209: unable to set affinity
chip e6052000.gpio IRQ210: unable to set affinity
chip e6052000.gpio IRQ211: unable to set affinity
chip e6052000.gpio IRQ212: unable to set affinity
chip e6052000.gpio IRQ213: unable to set affinity
chip e6052000.gpio IRQ214: unable to set affinity
chip e6052000.gpio IRQ215: unable to set affinity
chip e6052000.gpio IRQ216: unable to set affinity
chip e6052000.gpio IRQ217: unable to set affinity
chip e6052000.gpio IRQ218: unable to set affinity
chip e6052000.gpio IRQ219: unable to set affinity
chip e6052000.gpio IRQ220: unable to set affinity
chip e6052000.gpio IRQ221: unable to set affinity
chip e6052000.gpio IRQ222: unable to set affinity
chip e6052000.gpio IRQ223: unable to set affinity
chip e6053000.gpio IRQ224: unable to set affinity
chip e6053000.gpio IRQ225: unable to set affinity
chip e6053000.gpio IRQ226: unable to set affinity
chip e6053000.gpio IRQ227: unable to set affinity
chip e6053000.gpio IRQ228: unable to set affinity
chip e6053000.gpio IRQ229: unable to set affinity
chip e6053000.gpio IRQ230: unable to set affinity
chip e6053000.gpio IRQ231: unable to set affinity
chip e6053000.gpio IRQ232: unable to set affinity
chip e6053000.gpio IRQ233: unable to set affinity
chip e6053000.gpio IRQ234: unable to set affinity
chip e6053000.gpio IRQ235: unable to set affinity
chip e6053000.gpio IRQ236: unable to set affinity
chip e6053000.gpio IRQ237: unable to set affinity
chip e6053000.gpio IRQ238: unable to set affinity
chip e6053000.gpio IRQ239: unable to set affinity
chip e6053000.gpio IRQ240: unable to set affinity
chip e6053000.gpio IRQ241: unable to set affinity
chip e6053000.gpio IRQ242: unable to set affinity
chip e6053000.gpio IRQ243: unable to set affinity
chip e6053000.gpio IRQ244: unable to set affinity
chip e6053000.gpio IRQ245: unable to set affinity
chip e6053000.gpio IRQ246: unable to set affinity
chip e6053000.gpio IRQ247: unable to set affinity
chip e6053000.gpio IRQ248: unable to set affinity
chip e6053000.gpio IRQ249: unable to set affinity
chip e6053000.gpio IRQ250: unable to set affinity
chip e6053000.gpio IRQ251: unable to set affinity
chip e6053000.gpio IRQ252: unable to set affinity
chip e6053000.gpio IRQ253: unable to set affinity
chip e6053000.gpio IRQ254: unable to set affinity
chip e6053000.gpio IRQ255: unable to set affinity
chip e6054000.gpio IRQ256: unable to set affinity
chip e6054000.gpio IRQ257: unable to set affinity
chip e6054000.gpio IRQ258: unable to set affinity
chip e6054000.gpio IRQ259: unable to set affinity
chip e6054000.gpio IRQ260: unable to set affinity
chip e6054000.gpio IRQ261: unable to set affinity
chip e6054000.gpio IRQ262: unable to set affinity
chip e6054000.gpio IRQ263: unable to set affinity
chip e6054000.gpio IRQ264: unable to set affinity
chip e6054000.gpio IRQ265: unable to set affinity
chip e6054000.gpio IRQ266: unable to set affinity
chip e6054000.gpio IRQ267: unable to set affinity
chip e6054000.gpio IRQ268: unable to set affinity
chip e6054000.gpio IRQ269: unable to set affinity
chip e6054000.gpio IRQ270: unable to set affinity
chip e6054000.gpio IRQ271: unable to set affinity
chip e6054000.gpio IRQ272: unable to set affinity
chip e6054000.gpio IRQ273: unable to set affinity
chip e6054000.gpio IRQ274: unable to set affinity
chip e6054000.gpio IRQ275: unable to set affinity
chip e6054000.gpio IRQ276: unable to set affinity
chip e6054000.gpio IRQ277: unable to set affinity
chip e6054000.gpio IRQ278: unable to set affinity
chip e6054000.gpio IRQ279: unable to set affinity
chip e6054000.gpio IRQ280: unable to set affinity
chip e6054000.gpio IRQ281: unable to set affinity
chip e6054000.gpio IRQ282: unable to set affinity
chip e6054000.gpio IRQ283: unable to set affinity
chip e6054000.gpio IRQ284: unable to set affinity
chip e6054000.gpio IRQ285: unable to set affinity
chip e6054000.gpio IRQ286: unable to set affinity
chip e6054000.gpio IRQ287: unable to set affinity
chip e6055000.gpio IRQ288: unable to set affinity
chip e6055000.gpio IRQ289: unable to set affinity
chip e6055000.gpio IRQ290: unable to set affinity
chip e6055000.gpio IRQ291: unable to set affinity
chip e6055000.gpio IRQ292: unable to set affinity
chip e6055000.gpio IRQ293: unable to set affinity
chip e6055000.gpio IRQ294: unable to set affinity
chip e6055000.gpio IRQ295: unable to set affinity
chip e6055000.gpio IRQ296: unable to set affinity
chip e6055000.gpio IRQ297: unable to set affinity
chip e6055000.gpio IRQ298: unable to set affinity
chip e6055000.gpio IRQ299: unable to set affinity
chip e6055000.gpio IRQ300: unable to set affinity
chip e6055000.gpio IRQ301: unable to set affinity
chip e6055000.gpio IRQ302: unable to set affinity
chip e6055000.gpio IRQ303: unable to set affinity
chip e6055000.gpio IRQ304: unable to set affinity
chip e6055000.gpio IRQ305: unable to set affinity
chip e6055000.gpio IRQ306: unable to set affinity
chip e6055000.gpio IRQ307: unable to set affinity
chip e6055000.gpio IRQ308: unable to set affinity
chip e6055000.gpio IRQ309: unable to set affinity
chip e6055000.gpio IRQ310: unable to set affinity
chip e6055000.gpio IRQ311: unable to set affinity
chip e6055000.gpio IRQ312: unable to set affinity
chip e6055000.gpio IRQ313: unable to set affinity
chip e6055000.gpio IRQ314: unable to set affinity
chip e6055000.gpio IRQ315: unable to set affinity
chip e6055000.gpio IRQ316: unable to set affinity
chip e6055000.gpio IRQ317: unable to set affinity
chip e6055000.gpio IRQ318: unable to set affinity
chip e6055000.gpio IRQ319: unable to set affinity
chip e6055400.gpio IRQ320: unable to set affinity
chip e6055400.gpio IRQ321: unable to set affinity
chip e6055400.gpio IRQ322: unable to set affinity
chip e6055400.gpio IRQ323: unable to set affinity
chip e6055400.gpio IRQ324: unable to set affinity
chip e6055400.gpio IRQ325: unable to set affinity
chip e6055400.gpio IRQ326: unable to set affinity
chip e6055400.gpio IRQ327: unable to set affinity
chip e6055400.gpio IRQ328: unable to set affinity
chip e6055400.gpio IRQ329: unable to set affinity
chip e6055400.gpio IRQ330: unable to set affinity
chip e6055400.gpio IRQ331: unable to set affinity
chip e6055400.gpio IRQ332: unable to set affinity
chip e6055400.gpio IRQ333: unable to set affinity
chip e6055400.gpio IRQ334: unable to set affinity
chip e6055400.gpio IRQ335: unable to set affinity
chip e6055400.gpio IRQ336: unable to set affinity
chip e6055400.gpio IRQ337: unable to set affinity
chip e6055400.gpio IRQ338: unable to set affinity
chip e6055400.gpio IRQ339: unable to set affinity
chip e6055400.gpio IRQ340: unable to set affinity
chip e6055400.gpio IRQ341: unable to set affinity
chip e6055400.gpio IRQ342: unable to set affinity
chip e6055400.gpio IRQ343: unable to set affinity
chip e6055400.gpio IRQ344: unable to set affinity
chip e6055400.gpio IRQ345: unable to set affinity
chip e6055400.gpio IRQ346: unable to set affinity
chip e6055400.gpio IRQ347: unable to set affinity
chip e6055400.gpio IRQ348: unable to set affinity
chip e6055400.gpio IRQ349: unable to set affinity
chip e6055400.gpio IRQ350: unable to set affinity
chip e6055400.gpio IRQ351: unable to set affinity
chip e6055800.gpio IRQ352: unable to set affinity
chip e6055800.gpio IRQ353: unable to set affinity
chip e6055800.gpio IRQ354: unable to set affinity
chip e6055800.gpio IRQ355: unable to set affinity
chip e6055800.gpio IRQ356: unable to set affinity
chip e6055800.gpio IRQ357: unable to set affinity
chip e6055800.gpio IRQ358: unable to set affinity
chip e6055800.gpio IRQ359: unable to set affinity
chip e6055800.gpio IRQ360: unable to set affinity
chip e6055800.gpio IRQ361: unable to set affinity
chip e6055800.gpio IRQ362: unable to set affinity
chip e6055800.gpio IRQ363: unable to set affinity
chip e6055800.gpio IRQ364: unable to set affinity
chip e6055800.gpio IRQ365: unable to set affinity
chip e6055800.gpio IRQ366: unable to set affinity
chip e6055800.gpio IRQ367: unable to set affinity
chip e6055800.gpio IRQ368: unable to set affinity
chip e6055800.gpio IRQ369: unable to set affinity
chip e6055800.gpio IRQ370: unable to set affinity
chip e6055800.gpio IRQ371: unable to set affinity
chip e6055800.gpio IRQ372: unable to set affinity
chip e6055800.gpio IRQ373: unable to set affinity
chip e6055800.gpio IRQ374: unable to set affinity
chip e6055800.gpio IRQ375: unable to set affinity
chip e6055800.gpio IRQ376: unable to set affinity
chip e6055800.gpio IRQ377: unable to set affinity
chip e61c0000.interrupt-controller IRQ378: unable to set affinity
chip da9063-irq IRQ379: unable to set affinity
chip da9063-irq IRQ380: unable to set affinity
chip da9063-irq IRQ381: unable to set affinity
chip da9063-irq IRQ382: unable to set affinity
chip da9063-irq IRQ383: unable to set affinity
chip da9063-irq IRQ384: unable to set affinity
chip da9063-irq IRQ385: unable to set affinity
chip da9063-irq IRQ386: unable to set affinity
chip da9063-irq IRQ387: unable to set affinity
chip da9063-irq IRQ388: unable to set affinity
chip da9063-irq IRQ389: unable to set affinity
chip da9063-irq IRQ390: unable to set affinity
chip da9063-irq IRQ391: unable to set affinity
chip da9063-irq IRQ392: unable to set affinity
chip da9063-irq IRQ393: unable to set affinity
chip da9063-irq IRQ394: unable to set affinity
chip da9063-irq IRQ395: unable to set affinity
chip da9063-irq IRQ396: unable to set affinity
chip da9063-irq IRQ397: unable to set affinity
chip da9063-irq IRQ398: unable to set affinity
chip da9063-irq IRQ399: unable to set affinity
chip da9063-irq IRQ400: unable to set affinity
chip da9063-irq IRQ401: unable to set affinity
chip da9063-irq IRQ402: unable to set affinity
chip da9063-irq IRQ403: unable to set affinity
chip da9063-irq IRQ404: unable to set affinity
chip da9063-irq IRQ405: unable to set affinity
chip da9063-irq IRQ406: unable to set affinity
chip da9063-irq IRQ407: unable to set affinity
chip e61c0000.interrupt-controller IRQ408: unable to set affinity

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

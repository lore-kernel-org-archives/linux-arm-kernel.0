From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 27 Apr 2017 16:41:54 +0200
Subject: [PATCH 1/3] ARM: at91: pm: Add sama5d2 backup mode
In-Reply-To: <CAMiSF3AZ9i2ywtTMYxjK8amaLEuez_0H_Jzy_pPS15CAe_FMRg@mail.gmail.com>
References: <20170426160419.22401-1-alexandre.belloni@free-electrons.com>
 <CAMiSF3AZ9i2ywtTMYxjK8amaLEuez_0H_Jzy_pPS15CAe_FMRg@mail.gmail.com>
Message-ID: <20170427144154.kxlsb42yug5mve67@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/2017 at 15:34:07 +0200, Romain Izard wrote:
> Hello Alexandre,
> 
> This series might also be of interest for the linux-pm mailing list.
> 

I don't think they care enough to review that.

> 2017-04-26 18:04 GMT+02:00 Alexandre Belloni
> > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> > index cfd8f60a9268..87fe17dbdb56 100644
> > --- a/arch/arm/mach-at91/Makefile
> > +++ b/arch/arm/mach-at91/Makefile
> > @@ -14,6 +14,10 @@ obj-$(CONFIG_PM)             += pm_suspend.o
> >  ifeq ($(CONFIG_CPU_V7),y)
> >  AFLAGS_pm_suspend.o := -march=armv7-a
> >  endif
> > +# Backup mode will not compile for ARMv5 because of movt
> > +ifeq ($(CONFIG_SOC_SAMA5D2),y)
> > +AFLAGS_pm_suspend.o += -DBACKUP_MODE
> > +endif
> >  ifeq ($(CONFIG_PM_DEBUG),y)
> >  CFLAGS_pm.o += -DDEBUG
> >  endif
> 
> We can rewrite the assembly to avoid using movt, and remove some ifdefs
> from the code.
> 

I'm kind of balanced there because I'm wondering whether we should
better separate what is in that assembly file because there are part of
it that have no chance to run on some platforms anyway.

But your solution is correct, I'll remove that.

> > +static void __init at91_pm_bu_sram_init(void)
> > +{
> > +       struct gen_pool *sram_pool;
> > +       struct device_node *node;
> > +       struct platform_device *pdev = NULL;
> > +
> > +       pm_bu = NULL;
> > +
> > +       for_each_compatible_node(node, NULL, "atmel,sama5d2-securam") {
> > +               pdev = of_find_device_by_node(node);
> > +               if (pdev) {
> > +                       of_node_put(node);
> > +                       break;
> > +               }
> > +       }
> > +
> 
> Do we really need to iterate over compatible nodes ?
> 

You're right, this can probably be avoided.

> > +       if (!pdev) {
> > +               pr_warn("%s: failed to find securam device!\n", __func__);
> > +               return;
> > +       }
> > +
> > +       sram_pool = gen_pool_get(&pdev->dev, NULL);
> > +       if (!sram_pool) {
> > +               pr_warn("%s: securam pool unavailable!\n", __func__);
> > +               return;
> > +       }
> > +
> > +       pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
> > +       if (!pm_bu) {
> > +               pr_warn("%s: unable to alloc securam!\n", __func__);
> > +               return;
> > +       }
> > +
> > +       pm_bu->suspended = 0;
> > +       pm_bu->canary = virt_to_phys(&canary);
> > +       pm_bu->resume = virt_to_phys(cpu_resume);
> > +}
> > +
> 
> at91_pm_bu_sram_init and at91_dt_shdwc are necessary to use backup mode.
> But those functions do not return error codes, and do no cleanup in case
> of error.  I believe that it would be simpler if we only had a single
> function.
> 

Yeah, this is kind of solved by adding the fallback in a latter patch
but I agree it can be done better.

> > diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> > index 96781daa671a..b5ffa8e1f203 100644
> > --- a/arch/arm/mach-at91/pm_suspend.S
> > +++ b/arch/arm/mach-at91/pm_suspend.S
> > @@ -97,15 +97,74 @@ ENTRY(at91_pm_suspend_in_sram)
> >         str     tmp1, .memtype
> >         ldr     tmp1, [r0, #PM_DATA_MODE]
> >         str     tmp1, .pm_mode
> > +       ldr     tmp1, [r0, #PM_DATA_SHDWC]
> > +#if defined(BACKUP_MODE)
> > +       str     tmp1, .shdwc
> > +       cmp     tmp1, #0
> > +       ldrne   tmp2, [tmp1, #0]
> > +       ldr     tmp1, [r0, #PM_DATA_SFRBU]
> > +       str     tmp1, .sfr
> > +       cmp     tmp1, #0
> > +       ldrne   tmp2, [tmp1, #0x10]
> > +#endif
> 
> If I understand this well, we are doing this to fill the TLB in advance
> before the external RAM is put in self-refresh. It might be worthy of a
> comment. Moreover, .pm_mode and .memtype do not need to be protected as
> they are accessed during the at91_sramc_self_refresh, but .pmc_base
> may need to be loaded in the TLB as well.

We never had issue with .pmc_base because it is used in the C part of
the code, right before calling the assembly.
I'll add a comment.

> 
> > +#if defined(BACKUP_MODE)
> > +ENTRY(at91_backup_mode)
> > +       #if 0
> > +       /* Read LPR */
> > +       ldr     r2, .sramc_base
> > +       ldr     r3, [r2, #AT91_DDRSDRC_LPR]
> > +       #endif
> > +
> 
> Do we need to keep this commented code ?
> 

Nope, leftover from development


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

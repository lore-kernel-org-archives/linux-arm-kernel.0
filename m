From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 10 Dec 2009 01:20:28 +0530
Subject: [PATCH 1/6] OMAP4: Fix cpu detection
In-Reply-To: <782515bb0912091130r2fabec47v5c48057592edb070@mail.gmail.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	<782515bb0912091130r2fabec47v5c48057592edb070@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A826E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Nishant !!

> > + ? ? ? if ((hawkeye == 0xb852) && (rev == 0x0)) {
> > + ? ? ? ? ? ? ? omap_revision = OMAP4430_REV_ES1_0;
> > + ? ? ? ? ? ? ? pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
> > + ? ? ? ? ? ? ? return;
> > + ? ? ? }
> > +
> > + ? ? ? printk(KERN_ERR "Unknown OMAP CPU id\n");
> a) Do you want to state unknown OMAP4 CPU id?
> b) why not use pr_err?
OK

> > @@ -280,7 +280,7 @@ void __init omap2_set_globals_343x(void)
> > ?#if defined(CONFIG_ARCH_OMAP4)
> > ?static struct omap_globals omap4_globals = {
> > ? ? ? ?.class ?= OMAP443X_CLASS,
> > - ? ? ? .tap ? ?= OMAP2_L4_IO_ADDRESS(0x4830a000),
> > + ? ? ? .tap ? ?= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
> 
> What does this have to do with the subject of the patch? I agree it is
> a good thing to have, but probably belongs elsewhere.
This is everything to do with subject. ID_CODE reg is in SCM and you
Need a right base to read that reg, Isn't it ?
> 
> > ? ? ? ?.ctrl ? = OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
> > ? ? ? ?.prm ? ?= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
> > ? ? ? ?.cm ? ? = OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> > index 2e17890..2a141ba 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -443,7 +443,8 @@ IS_OMAP_TYPE(3517, 0x3517)
> > ?#define OMAP3505_REV(v) ? ? ? ? ? ? ? ?(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
> > ?#define OMAP3517_REV(v) ? ? ? ? ? ? ? ?(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
> >
> > -#define OMAP443X_CLASS ? ? ? ? 0x44300034
> > +#define OMAP443X_CLASS ? ? ? ? 0x44300044
> > +#define OMAP4430_REV_ES1_0 ? ? 0x44300044
> Errr.. why? I suspect this might be to get the class and subclass right..
> 
> Dont we need an cpu_is_omap_4430() to use it correctly? (unless I
> missed a pending patch series as I am checking l-o kernel codebase)..
> do we need the following?
> IS_OMAP_CLASS(44xx, 0x44)
> IS_OMAP_SUBCLASS(443x, 0x443)
> 
> then you will have is_omap_443x() and you can now:
> #define cpu_is_omap4430 is_omap443x()
This has to be done and I planning to do this in next series. This series just
enables the basic boot on ES1.0.

Regards, 
Santosh

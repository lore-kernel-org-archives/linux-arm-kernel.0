From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 16 Nov 2010 18:10:02 +0530
Subject: [PATCH] ARM: SAMSUNG: Add support for clock debugging through
	debug-fs interface
In-Reply-To: <AANLkTi=NtRETnsOp-bRC6SgGsfncTibMOziv54VUDGuo@mail.gmail.com>
References: <1289904860-30951-1-git-send-email-amit.daniel@samsung.com>
	<AANLkTi=NtRETnsOp-bRC6SgGsfncTibMOziv54VUDGuo@mail.gmail.com>
Message-ID: <20101116124002.GE2344@sahyadri-mini10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yong,

No. The work that you're doing is long-term. It will take time for platforms
to move to the common struct clk - almost unlikely for the next Linaro release.

In the short-term, we still need all partner platforms to expose this debug
information for our tools in a consistent way - OMAP already does it this
way.  So we want this patch applied to the Samsung platform after review and
similar ones for other SoC kernels.

/Amit

On 10 Nov 16, Yong Shen wrote:
> Hi Amit,
> 
> We are trying to make this clock debug interface generic, so every platform
> can benefit from it. Maybe it is better to wait for a while until the common
> interface comes out.
> 
> Yong
> 
> On Tue, Nov 16, 2010 at 6:54 PM, <amit.daniel@samsung.com> wrote:
> 
> > From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >
> > This patch adds support for clock information exposed to debug-fs
> > interface.
> >
> > Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > ---
> >  arch/arm/plat-samsung/clock.c              |   92
> > ++++++++++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/clock.h |    3 +
> >  2 files changed, 95 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> > index e8d20b0..0ba209d 100644
> > --- a/arch/arm/plat-samsung/clock.c
> > +++ b/arch/arm/plat-samsung/clock.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/io.h>
> > +#include <linux/debugfs.h>
> >
> >  #include <mach/hardware.h>
> >  #include <asm/irq.h>
> > @@ -447,3 +448,94 @@ int __init s3c24xx_register_baseclocks(unsigned long
> > xtal)
> >        return 0;
> >  }
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +/*
> > + *     debugfs support to trace clock tree hierarchy and attributes
> > + */
> > +static struct dentry *clk_debugfs_root;
> > +
> > +static int clk_debugfs_register_one(struct clk *c)
> > +{
> > +       int err;
> > +       struct dentry *d, *child, *child_tmp;
> > +       struct clk *pa = c->parent;
> > +       char s[255];
> > +       char *p = s;
> > +
> > +       p += sprintf(p, "%s", c->name);
> > +#ifdef CONFIG_PLAT_SAMSUNG
> > +       /*Append id field with name also*/
> > +       if (c->id >= 0)
> > +               p += sprintf(p, ":%d", c->id);
> > +#endif
> > +
> > +       d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
> > +       if (!d)
> > +               return -ENOMEM;
> > +
> > +       c->dent = d;
> > +
> > +       d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8
> > *)&c->usage);
> > +       if (!d) {
> > +               err = -ENOMEM;
> > +               goto err_out;
> > +       }
> > +       d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
> > +       if (!d) {
> > +               err = -ENOMEM;
> > +               goto err_out;
> > +       }
> > +       return 0;
> > +
> > +err_out:
> > +       d = c->dent;
> > +       list_for_each_entry_safe(child, child_tmp, &d->d_subdirs,
> > d_u.d_child)
> > +               debugfs_remove(child);
> > +       debugfs_remove(c->dent);
> > +       return err;
> > +}
> > +
> > +static int clk_debugfs_register(struct clk *c)
> > +{
> > +       int err;
> > +       struct clk *pa = c->parent;
> > +
> > +       if (pa && !pa->dent) {
> > +               err = clk_debugfs_register(pa);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       if (!c->dent) {
> > +               err = clk_debugfs_register_one(c);
> > +               if (err)
> > +                       return err;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int __init clk_debugfs_init(void)
> > +{
> > +       struct clk *c;
> > +       struct dentry *d;
> > +       int err;
> > +
> > +       d = debugfs_create_dir("clock", NULL);
> > +       if (!d)
> > +               return -ENOMEM;
> > +       clk_debugfs_root = d;
> > +
> > +       list_for_each_entry(c, &clocks, list) {
> > +               err = clk_debugfs_register(c);
> > +               if (err)
> > +                       goto err_out;
> > +       }
> > +       return 0;
> > +err_out:
> > +       debugfs_remove_recursive(clk_debugfs_root);
> > +       return err;
> > +}
> > +late_initcall(clk_debugfs_init);
> > +
> > +#endif /* defined(CONFIG_DEBUG_FS) */
> > +
> > diff --git a/arch/arm/plat-samsung/include/plat/clock.h
> > b/arch/arm/plat-samsung/include/plat/clock.h
> > index 0fbcd0e..f6180ab 100644
> > --- a/arch/arm/plat-samsung/include/plat/clock.h
> > +++ b/arch/arm/plat-samsung/include/plat/clock.h
> > @@ -47,6 +47,9 @@ struct clk {
> >
> >        struct clk_ops          *ops;
> >        int                 (*enable)(struct clk *, int enable);
> > +#if defined(CONFIG_DEBUG_FS)
> > +       struct dentry           *dent;  /* For visible tree hierarchy */
> > +#endif
> >  };
> >
> >  /* other clocks which may be registered by board support */
> > --
> > 1.6.0.6
> >
> >
> > _______________________________________________
> > linaro-dev mailing list
> > linaro-dev at lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-dev
> >

> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev

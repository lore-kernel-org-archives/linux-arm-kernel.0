From: amit.kachhap@linaro.org (Amit Kachhap)
Date: Fri, 11 Feb 2011 04:22:23 -0500
Subject: [PATCH] ARM: SAMSUNG: Removing dependency on CONFIG_PM_DEBUG for
	clock debugging
In-Reply-To: <AANLkTinjhPP9NxLsOMovETAZLzFO70zmVWtPQ+E4PZj9@mail.gmail.com>
References: <1297530374-32635-1-git-send-email-amit.kachhap@linaro.org>
	<AANLkTinjhPP9NxLsOMovETAZLzFO70zmVWtPQ+E4PZj9@mail.gmail.com>
Message-ID: <AANLkTinPP5Qi5KbQSwPbQoBVdNdkOV-mDMiTkJvzrcS8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

yes this is a temporary patch untill all the PM
components(sleep/resume) are mainlined.
The exact compilation error is,

 CC      arch/arm/plat-samsung/pm.o
arch/arm/plat-samsung/pm.c:32: fatal error: mach/pm-core.h: No such
file or directory
compilation terminated.
make[1]: *** [arch/arm/plat-samsung/pm.o] Error 1

Thanks,
Amit Daniel


On 11 February 2011 02:57, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Sat, Feb 12, 2011 at 7:06 PM, Amit Daniel Kachhap
> <amit.kachhap@linaro.org> wrote:
> > Enabling the macro CONFIG_PM_DEBUG is causing compilation error as all PM components
> > are included which is not in mainline for samsung V310 platform, therefore, this patch
> > removes the dependency on macro CONFIG_PM_DEBUG for clock debugging through debugfs
> > interface.
>
> What is the exact error? Might be helpful to have it in the patch description.
>
> Presumably, this is a temporary patch until PM components
> (suspend/resume hooks?) are mainlined and then we can put all this
> back under PM_DEBUG? In that case, it might be a good idea to mark it
> as such.
>
> Regards,
> Amit
>
> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> > ---
> > ?arch/arm/plat-samsung/clock.c ? ? ? ? ? ? ?| ? ?4 ++--
> > ?arch/arm/plat-samsung/include/plat/clock.h | ? ?2 +-
> > ?2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> > index 7728928..aca5a25 100644
> > --- a/arch/arm/plat-samsung/clock.c
> > +++ b/arch/arm/plat-samsung/clock.c
> > @@ -450,7 +450,7 @@ int __init s3c24xx_register_baseclocks(unsigned long xtal)
> > ? ? ? ?return 0;
> > ?}
> >
> > -#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> > +#if defined(CONFIG_DEBUG_FS)
> > ?/* debugfs support to trace clock tree hierarchy and attributes */
> >
> > ?static struct dentry *clk_debugfs_root;
> > @@ -538,4 +538,4 @@ err_out:
> > ?}
> > ?late_initcall(clk_debugfs_init);
> >
> > -#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
> > +#endif /* defined(CONFIG_DEBUG_FS) */
> > diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
> > index 9a82b88..f6180ab 100644
> > --- a/arch/arm/plat-samsung/include/plat/clock.h
> > +++ b/arch/arm/plat-samsung/include/plat/clock.h
> > @@ -47,7 +47,7 @@ struct clk {
> >
> > ? ? ? ?struct clk_ops ? ? ? ? ?*ops;
> > ? ? ? ?int ? ? ? ? ? ? ? ? (*enable)(struct clk *, int enable);
> > -#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> > +#if defined(CONFIG_DEBUG_FS)
> > ? ? ? ?struct dentry ? ? ? ? ? *dent; ?/* For visible tree hierarchy */
> > ?#endif
> > ?};
> > --
> > 1.7.1
> >
> >
> > _______________________________________________
> > linaro-dev mailing list
> > linaro-dev at lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-dev
> >

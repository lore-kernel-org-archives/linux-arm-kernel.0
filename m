From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 16:02:04 +0200
Subject: [PATCH, RFC 06/22] gpu/drm: host1x: add dependency on Tegra
In-Reply-To: <20130503134539.GA18652@avionic-0098.adnet.avionic-design.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-7-git-send-email-arnd@arndb.de>
 <20130503134539.GA18652@avionic-0098.adnet.avionic-design.de>
Message-ID: <3432070.tv7Jup0G8r@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 15:45:39 Thierry Reding wrote:
> > diff --git a/drivers/gpu/host1x/drm/Kconfig b/drivers/gpu/host1x/drm/Kconfig
> > index 69853a4..5a6a5cd 100644
> > --- a/drivers/gpu/host1x/drm/Kconfig
> > +++ b/drivers/gpu/host1x/drm/Kconfig
> > @@ -1,6 +1,7 @@
> >  config DRM_TEGRA
> >       bool "NVIDIA Tegra DRM"
> >       depends on DRM
> > +     depends on ARCH_TEGRA
> >       select DRM_KMS_HELPER
> >       select FB_SYS_FILLRECT
> >       select FB_SYS_COPYAREA
> 
> This was solved by a patch that went into Dave's DRM pull request for
> 3.10 by adding:
> 
>         depends on ARCH_TEGRA || ARCH_MULTIPLATFORM
> 
> to the Kconfig entry for TEGRA_HOST1X. The plan was to eventually remove
> ARCH_TEGRA from that condition after 3.10 since ARCH_MULTIPLATFORM will
> include ARCH_TEGRA anyway. I'm not sure why that patch hasn't made it
> into linux-next yet, though.

I saw the problem with ARCH_MULTIPLATFORM enabled, so I don't understand
how adding the dependency above would help. A possible alternative
would be to define an empty alternative for the interface used here,
as the patch below.

	Arnd

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 642789b..1397190 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -120,8 +120,13 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
 
+#ifdef ARCH_TEGRA
 void tegra_periph_reset_deassert(struct clk *c);
 void tegra_periph_reset_assert(struct clk *c);
+#else
+static inline void tegra_periph_reset_deassert(struct clk *c) {}
+static inline void tegra_periph_reset_assert(struct clk *c) {}
+#endif
 void tegra_clocks_init(void);
 void tegra_clocks_apply_init_table(void);
 

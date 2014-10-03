From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Oct 2014 18:01:17 +0200 (CEST)
Subject: [PATCH v3 07/13] ARM: shmobile: R-Mobile: Use
 generic_pm_domain.attach_dev() for pm_clk setup
In-Reply-To: <CAMuHMdVZmhpKcRO0rnXFMu7RJ4zFNPdvzuW=TBpvE5B4JviAZA@mail.gmail.com>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
 <1411662520-22795-8-git-send-email-geert+renesas@glider.be>
 <CAMuHMdVZmhpKcRO0rnXFMu7RJ4zFNPdvzuW=TBpvE5B4JviAZA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1410031756580.14789@ayla.of.borg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Sep 2014, Geert Uytterhoeven wrote:
> On Thu, Sep 25, 2014 at 6:28 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
> > index 717e6413d29cb998..ae846dfcd69293f7 100644
> > --- a/arch/arm/mach-shmobile/pm-rmobile.c
> > +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> > @@ -101,6 +101,17 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
> >         return true;
> >  }
> >
> > +static void rmobile_pd_attach_dev(struct device *dev)
> > +{
> > +       if (pm_clk_no_clocks(dev))
> > +               pm_clk_add(dev, NULL);
> 
> With !CONFIG_PM_RUNTIME, this doesn't work well in the DT case,
> as the clocks are no longer enabled by runtime PM
> (some clocks may have been enabled by boot loader/reset state though).
> 
> In the legacy case, this works more or less, as genpd takes over after
> the pm_clk domain has been initialized, which implies enabling the clocks
> if !CONFIG_PM_RUNTIME.
> 
> Will fix...

The patch below fixes that.

I'll update the whole series, and will repost after v3.18-rc1, after the
prerequisites are in.

>From cf40afcfab65fef8e6e6fa84bd3b49434afcb5eb Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 1 Oct 2014 20:05:53 +0200
Subject: [PATCH] ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME

ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME

If CONFIG_PM_RUNTIME is not set, the clocks must be enabled before the
devices can be used.  Also add missing pm_clk_create()/pm_clk_destroy()
calls.

Currently these clocks are enabled by the !CONFIG_PM_RUNTIME version of
pm_clk_notify, activated by the hack in drivers/sh/pm_runtime.c, but
this will go away soon (at least for DT, cfr. "[PATCH] drivers: sh:
Disable PM runtime for multi-platform r8a7740 with genpd").

On detach, disabling the clocks is already handled by pm_clk_destroy().
On system suspend/resume, disabling/enabling clocks is already handled
from the genpd->dev_ops.{start,stop}() callbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "PM / clock_ops: Fix crash in clocks management code if
!CONFIG_PM_RUNTIME".

 arch/arm/mach-shmobile/pm-rmobile.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 80be5848adc8f15c..e5a2c568d96cdd6b 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -121,13 +121,23 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
 
 static void rmobile_pd_attach_dev(struct device *dev)
 {
-	if (pm_clk_no_clocks(dev))
-		pm_clk_add(dev, NULL);
+	int error;
+
+	error = pm_clk_create(dev);
+	if (error) {
+		dev_err(dev, "pm_clk_create failed %d\n", error);
+		return;
+	}
+
+	pm_clk_add(dev, NULL);
+
+	if (!IS_ENABLED(CONFIG_PM_RUNTIME))
+		pm_clk_resume(dev);
 }
 
 static void rmobile_pd_detach_dev(struct device *dev)
 {
-	pm_clk_remove(dev, NULL);
+	pm_clk_destroy(dev);
 }
 
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

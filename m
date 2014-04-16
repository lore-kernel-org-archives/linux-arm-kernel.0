From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Apr 2014 20:14:27 +0200
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <534E9AA3.10409@samsung.com>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <CAJuA9ajXa+mejdUvWATHjmmin8hoRhX0wueg5g8rDbJR4AWZ7A@mail.gmail.com>
 <534E9AA3.10409@samsung.com>
Message-ID: <5094962.iM2Kd6gfjd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 April 2014 16:58:43 Tomasz Figa wrote:

> On 16.04.2014 16:55, Thomas Abraham wrote:
> > On Wed, Apr 16, 2014 at 8:18 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> >> On 16.04.2014 16:31, Arnd Bergmann wrote:
> >>> sparsemem is still not supported in multiplatform, but after I looked
> >>> at it in more detail, I came to the conclusion that there is no
> >>> reason why it couldn't be. It just needs testing so we are confident
> >>> that it doesn't break other platforms, and we need to find good
> >>> platform-independent values for MAX_PHYSMEM_BITS and SECTION_SIZE_BITS
> >>> to put into asm/memory.h, since we can't have them set in mach/memory.h
> >>> for multiplatform.
> >>>
> >>> Looking at my patch again now, I would actually prefer to kill off
> >>> the single-platform support for exynos right away. I don't see
> >>> any reason to keep it now, and it complicates the test matrix.
> >>
> >>
> >> That would be the best option, assuming that it wouldn't introduce feature
> >> regressions. Unfortunately there is still ongoing work on cpufreq driver to
> >> make it multiplatform-aware, so dropping single platform support right now
> >> would introduce at least this one regression.
> >>
> >> Thomas, is there any progress on new version of Exynos cpufreq rework
> >> series?
> >
> > Hi Tomasz,
> >
> > Yes, I am preparing the fourth version of the cpufreq patches and will
> > post it next week. Mostly, the changes will be addressing your review
> > comments.
> 
> OK. Looking forward to it. Thanks for an update on this.
> 

Cool! This is the only major issue I'm aware of, so I think we're good.

If SPARSEMEM support is still relevant to anybody, I'm sure we can
get that to work as well.

There is one small issue with the sound drivers that came up, and I
assume it was just a mistake. If not, some more work on that might
be needed. See patch below.

	Arnd

8<-------
>From 6f3921c3218509114e855a8ea5932aeea5d3ddfd Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Mar 2014 17:04:59 +0100
Subject: [PATCH] ASoC: samsung: don't build pcm and spdif on exynos

In commit d37bdf736d9b "ASoC: samsung: Use ASoC dmaengine code where
possible", Mark Brown changed the EXYNOS ASoC code to no longer
use the private dma interfaces that are standing in the way of
multiplatform enablement.

However, in 313367e7bfa "ASoC: Samsung: Update Kconfig for I2S,SPDIF
and PCM audio", two new users of that interface appeared, since it
is now possible to enable SND_SOC_SAMSUNG_SMDK_SPDIF and
SND_SOC_SMDK_WM8994_PCM on all Samsung SoCs including EXYNOS.

This patch does a partial revert of 313367e7bfa by allowing these
drivers on all samsung platforms except EXYNOS, so we can proceed
with the multiplatform patches.

If support for these drivers is actually needed on EXYNOS machines,
the drivers should first be moved over to use the dmaengine code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sangsu Park <sangsu4u.park@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Padmavathi Venna <padma.v@samsung.com>
Cc: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 7b610a8..efc01e0 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -167,7 +167,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && !ARCH_EXYNOS
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
@@ -183,7 +183,7 @@ config SND_SOC_SMDK_WM8580_PCM
 
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && !ARCH_EXYNOS
 	depends on I2C=y
 	select MFD_WM8994
 	select SND_SOC_WM8994

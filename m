From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Jun 2013 12:59:53 +0200
Subject: [PATCH 0/8] ARM: move cpuidle drivers to drivers/cpuidle/
In-Reply-To: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <51CAC9A9.5070906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2013 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset moves ARM cpuidle drivers to drivers/cpuidle/ to make
> code match new driver placement rules (per commit a8e39c3 "cpuidle: add
> maintainer entry").

I second this initiative but as stated in a previous email, a bit of
code cleanup, consolidation and encapsulation should be done before.

Again, from my POV, it is worth to do that but we have to split the pm
code from the driver.

Please review some patches I sent recently to split this code and
comment them. Otherwise, we will collide on this work.

All the patches sent [1] was to unify the code to make the drivers as
unified as possible to converge to the same code pattern and to
facilitate the factoring out.

Thanks
  -- Daniel

[1]
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next&qt=author&q=daniel.lezcano%40linaro.org

> [ Please note that movement of Samsung EXYNOS cpuidle driver is handled
>   in separate patchset since it needs some other changes applied first. ]
> 
> Patches are based on linux-next (next-20130624) and are compile tested
> only.  If agreed they all should probably go together through one tree
> (linux-pm or arm-soc) since they all modify drivers/cpuidle/Makefile.
> 
> PS It seems that majority of cpuidle drivers is not used by default
> (CONFIG_CPU_IDLE is not turned on in corresponding defconfigs). The only
> exceptions are shmobile (kota2_defconfig) and tegra (tegra_defconfig).
> This is probably also something that needs updating.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (8):
>   ARM: at91: move cpuidle driver to drivers/cpuidle/
>   ARM: davinci: move cpuidle driver to drivers/cpuidle/
>   ARM: imx: move cpuidle drivers to drivers/cpuidle/
>   ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
>   ARM: S3C64XX: move cpuidle driver to drivers/cpuidle/
>   ARM: shmobile: move cpuidle driver to drivers/cpuidle/
>   ARM: tegra: move cpuidle drivers to drivers/cpuidle/
>   ARM: ux500: move cpuidle drivers to drivers/cpuidle/
> 
>  arch/arm/mach-at91/Makefile            |   1 -
>  arch/arm/mach-at91/cpuidle.c           |  68 -------
>  arch/arm/mach-davinci/Makefile         |   1 -
>  arch/arm/mach-davinci/cpuidle.c        | 105 ----------
>  arch/arm/mach-imx/Makefile             |   5 -
>  arch/arm/mach-imx/cpuidle-imx5.c       |  37 ----
>  arch/arm/mach-imx/cpuidle-imx6q.c      |  75 -------
>  arch/arm/mach-omap2/Makefile           |   5 -
>  arch/arm/mach-omap2/cpuidle34xx.c      | 344 ---------------------------------
>  arch/arm/mach-omap2/cpuidle44xx.c      | 217 ---------------------
>  arch/arm/mach-s3c64xx/Makefile         |   1 -
>  arch/arm/mach-s3c64xx/cpuidle.c        |  63 ------
>  arch/arm/mach-shmobile/Makefile        |   1 -
>  arch/arm/mach-shmobile/cpuidle.c       |  37 ----
>  arch/arm/mach-tegra/Makefile           |   9 -
>  arch/arm/mach-tegra/cpuidle-tegra114.c |  35 ----
>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 217 ---------------------
>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 149 --------------
>  arch/arm/mach-ux500/Makefile           |   1 -
>  arch/arm/mach-ux500/cpuidle.c          | 128 ------------
>  drivers/cpuidle/Makefile               |  42 ++++
>  drivers/cpuidle/cpuidle-at91.c         |  68 +++++++
>  drivers/cpuidle/cpuidle-davinci.c      | 104 ++++++++++
>  drivers/cpuidle/cpuidle-imx5.c         |  37 ++++
>  drivers/cpuidle/cpuidle-imx6q.c        |  74 +++++++
>  drivers/cpuidle/cpuidle-omap34xx.c     | 342 ++++++++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-omap44xx.c     | 216 +++++++++++++++++++++
>  drivers/cpuidle/cpuidle-s3c64xx.c      |  62 ++++++
>  drivers/cpuidle/cpuidle-shmobile.c     |  37 ++++
>  drivers/cpuidle/cpuidle-tegra114.c     |  35 ++++
>  drivers/cpuidle/cpuidle-tegra20.c      | 217 +++++++++++++++++++++
>  drivers/cpuidle/cpuidle-tegra30.c      | 149 ++++++++++++++
>  drivers/cpuidle/cpuidle-ux500.c        | 128 ++++++++++++
>  33 files changed, 1511 insertions(+), 1499 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/cpuidle.c
>  delete mode 100644 arch/arm/mach-davinci/cpuidle.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
>  delete mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
>  delete mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
>  delete mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
>  delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>  delete mode 100644 arch/arm/mach-ux500/cpuidle.c
>  create mode 100644 drivers/cpuidle/cpuidle-at91.c
>  create mode 100644 drivers/cpuidle/cpuidle-davinci.c
>  create mode 100644 drivers/cpuidle/cpuidle-imx5.c
>  create mode 100644 drivers/cpuidle/cpuidle-imx6q.c
>  create mode 100644 drivers/cpuidle/cpuidle-omap34xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-omap44xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-s3c64xx.c
>  create mode 100644 drivers/cpuidle/cpuidle-shmobile.c
>  create mode 100644 drivers/cpuidle/cpuidle-tegra114.c
>  create mode 100644 drivers/cpuidle/cpuidle-tegra20.c
>  create mode 100644 drivers/cpuidle/cpuidle-tegra30.c
>  create mode 100644 drivers/cpuidle/cpuidle-ux500.c
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

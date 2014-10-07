From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 7 Oct 2014 09:51:57 -0700
Subject: [PATCH v3 0/2] Handle reboot for Exynos SoC via restart_handler
In-Reply-To: <1412668401-21837-1-git-send-email-pankaj.dubey@samsung.com>
References: <1412668401-21837-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20141007165157.GH28835@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 01:23:19PM +0530, Pankaj Dubey wrote:
> This patch removes restart hook from machine_desc of Exynos, and moves
> respective code into reboot_notifiers.

Nitpick:

s/reboot_notifiers/restart_notifiers/

Guenter

> Exynos5440 handles reboot via clock register so let's register a
> restart_handler in Exynos5440 clock driver.
> For rest Exynos SoC, reboot is handled via PMU SWRESET register so
> let's register a restart_handler in PMU driver for handling this.
> 
> This patch is inspired and dependent on following patch series[1] from
> Geunter Roeck.
> 
> Also this patch is dependent on PMU platform driver patch [2] by me, and
> has been prepared on top of it.
> 
> [1]: kernel: Add support for kernel restart handler call chain
> https://lkml.org/lkml/2014/8/19/652
> 
> [2]: ARM: Exynos: Convert PMU implementation into a platform driver
> https://lkml.org/lkml/2014/10/6/89
> 
> I have tested reboot functionality on Exynos3250 based board, on
> kgene/for-next as well as linux-next's next-20140925 tag.
> 
> Patch v2 and related discussion can be found here
> http://www.spinics.net/lists/linux-samsung-soc/msg37457.html
> 
> Changes since v2:
>   - Used register_restart_handler instead of register_reboot_notifier.
>   - Updated notifier names and commit message accordingly.
> 
> Changes since v1:
>   - Addressed review comments from Tomasz Figa. Removed usage of 
>     local variables where ever unnecessary.
>   - Make reg_base as global in clk-exynos5440.c file, to avoid 
>     iomapping it again in reboot_notifier handler.
> 
> Pankaj Dubey (2):
>   clk: samsung: exynos5440: move restart code into clock driver
>   ARM: EXYNOS: PMU: move restart code into pmu driver
> 
>  arch/arm/mach-exynos/common.h        |    1 -
>  arch/arm/mach-exynos/exynos.c        |   23 -----------------------
>  arch/arm/mach-exynos/pmu.c           |   24 ++++++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos5440.c |   29 ++++++++++++++++++++++++++++-
>  4 files changed, 52 insertions(+), 25 deletions(-)
> 
> -- 
> 1.7.9.5
> 

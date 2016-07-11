From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 10 Jul 2016 22:58:04 -0400
Subject: [PATCH v2 05/10] power/reset: Add reset driver support for nuc900
In-Reply-To: <578304CB.8050604@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-6-git-send-email-vw@iommu.org>
 <CAP=VYLrb5ujiLTPXnPxzPHsdbHft9R45JB3LbbvRnaZ4rUAJoA@mail.gmail.com>
 <578304CB.8050604@iommu.org>
Message-ID: <20160711025804.GG30853@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH v2 05/10] power/reset: Add reset driver support for nuc900] On 11/07/2016 (Mon 10:30) Wan Zongshun wrote:

> 
> 
> On 2016?07?11? 05:56, Paul Gortmaker wrote:
> >On Sun, Jul 10, 2016 at 3:27 AM, Wan Zongshun <vw@iommu.org> wrote
> >>This driver is to add reset support for nuc900 series,
> >>currently, it only supports nuc970 SoC reset.
> >>
> >>Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
> >>---
> >>  drivers/power/reset/Kconfig        |  7 +++
> >>  drivers/power/reset/Makefile       |  1 +
> >>  drivers/power/reset/nuc900-reset.c | 93 ++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 101 insertions(+)
> >>  create mode 100644 drivers/power/reset/nuc900-reset.c
> >>
> >>diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> >>index 9bb2622..8c84892 100644
> >>--- a/drivers/power/reset/Kconfig
> >>+++ b/drivers/power/reset/Kconfig
> >>@@ -94,6 +94,13 @@ config POWER_RESET_MSM
> >>         help
> >>           Power off and restart support for Qualcomm boards.
> >>
> >>+config POWER_RESET_NUC900
> >>+       bool "Nuc900 restart driver"
> >
> >If this driver is bool and not tristate, then please remove all references
> >to MODULE_<xyz> and then the module.h include as well.
> 
> I will remove the following codes in my reset.c driver.
> 
> MODULE_DEVICE_TABLE(of, of_nuc900_reset_match);
> #include <linux/module.h>

Thanks -- it is not a specific criticism of your driver, but just a
mistake that we have consistently copied from one driver to the next,
and I hope we can stop doing that with the right reviews.

P.
--

> 
> 
> >
> >Thanks,
> >Paul.
> >--
> >
> >>+       depends on ARCH_W90X900
> >>+       help
> >>+         Power off and restart support for Nuvoton NUC900 family of
> >>+         reference boards.
> >>+
> >>  config POWER_RESET_LTC2952
> >>         bool "LTC2952 PowerPath power-off driver"
> >>         depends on OF_GPIO
> >>diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> >>index ab7aa86..d4df889 100644
> >>--- a/drivers/power/reset/Makefile
> >>+++ b/drivers/power/reset/Makefile
> >>@@ -9,6 +9,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
> >>  obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
> >>  obj-$(CONFIG_POWER_RESET_IMX) += imx-snvs-poweroff.o
> >>  obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
> >>+obj-$(CONFIG_POWER_RESET_NUC900) += nuc900-reset.o
> >>  obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
> >>  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
> >>  obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
> >>diff --git a/drivers/power/reset/nuc900-reset.c b/drivers/power/reset/nuc900-reset.c
> >>new file mode 100644
> >>index 0000000..49986b7
> >>--- /dev/null
> >>+++ b/drivers/power/reset/nuc900-reset.c
> >>@@ -0,0 +1,93 @@
> >>+/*
> >>+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
> >>+ *
> >>+ * The code contained herein is licensed under the GNU General Public
> >>+ * License. You may obtain a copy of the GNU General Public License
> >>+ * Version 2 or later at the following locations:
> >>+ *
> >>+ * http://www.opensource.org/licenses/gpl-license.html
> >>+ * http://www.gnu.org/copyleft/gpl.html
> >>+ */
> >>+#include <linux/init.h>
> >>+#include <linux/err.h>
> >>+#include <linux/io.h>
> >>+#include <linux/kernel.h>
> >>+#include <linux/mfd/syscon.h>
> >>+#include <linux/module.h>
> >>+#include <linux/notifier.h>
> >>+#include <linux/of.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/reboot.h>
> >>+#include <linux/regmap.h>
> >>
> >
> >[...]
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel at lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> >

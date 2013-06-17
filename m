From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 17 Jun 2013 11:20:12 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Add a platform bus notifier to set dma
 masks for Exynos5440
In-Reply-To: <20130418153003.GW14496@n2100.arm.linux.org.uk>
References: <1365072704-4568-1-git-send-email-kgene.kim@samsung.com>
 <20130418153003.GW14496@n2100.arm.linux.org.uk>
Message-ID: <CAJuYYwS-ipCbRijSUHpue9U97-wkjQwrHCASQJ_YHotwHKCTSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2013 21:00, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Apr 04, 2013 at 07:51:43PM +0900, Kukjin Kim wrote:
>> +static u64 dma_mask64 = DMA_BIT_MASK(64);
> ...
>> +     if (event != BUS_NOTIFY_ADD_DEVICE)
>> +             return NOTIFY_DONE;
>> +
>> +     dev->dma_mask = &dma_mask64;
>
> Sharing the dma mask in this way is a potential issue should you have a
> device driver use dma_set_mask() - which can write to this value.

Hi Russell,

Okay, I missed this point.

>
> A better solution would be:
>
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index dc662fc..51bb740 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -22,6 +22,7 @@ struct dev_archdata {
>  struct omap_device;
>
>  struct pdev_archdata {
> +       u64 dma_mask;
>  #ifdef CONFIG_ARCH_OMAP
>         struct omap_device *od;
>  #endif
>
> and then in your function do:
>
>         struct platform_device *pdev = to_platform_device(dev);
> ...
>         pdev->dev.dma_mask = &pdev->arch_data.dma_mask;
>         pdev->arch_data.dma_mask = DMA_BIT_MASK(64);

We could add a new u64 member into pdev_archdata structure, but that
would use an additional u64 for all platform_device which do not need
it. Adding a #ifdef around the u64 might not be ideal.

>
> However... are all your devices really DMA capable?  Normally on a SoC,
> it's only the DMA engine which is DMA capable and everything else is not,
> and in that case you really only want to set the DMA masks up for the
> DMA capable devices.

Yes, true. Not all devices in Exynos5440 are DMA capable and only the
OHCI, EHCI and SATA controllers need 64-bit dma transfer capability.

I have reworked this patch based on your comments, would the following
patch be acceptable? The u64 data is still in the machine file.

Sorry for the delay in replaying to your review comments.

Thanks,
Thomas.

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c
b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 753b94f..8fdcd78 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
+#include <linux/dma-mapping.h>

 #include <asm/mach/arch.h>
 #include <mach/regs-pmu.h>
@@ -23,11 +24,39 @@

 #include "common.h"

+static u64 dma_mask64 = DMA_BIT_MASK(64);
+static const struct of_device_id exynos5440_ctrl64bit_ids[] = {
+    { .compatible = "samsung,exynos5440-ohci", },
+    { .compatible = "samsung,exynos5440-ehci", },
+    { .compatible = "samsung,exynos5440-ahci", },
+};
+
 static void __init exynos5_dt_map_io(void)
 {
     exynos_init_io(NULL, 0);
 }

+static int exynos5440_platform_notifier(struct notifier_block *nb,
+  unsigned long event, void *__dev)
+{
+    struct device *dev = __dev;
+
+    if (event != BUS_NOTIFY_ADD_DEVICE)
+         return NOTIFY_DONE;
+
+    if (dev && dev->of_node &&
+         of_match_node(exynos5440_ctrl64bit_ids, dev->of_node)) {
+         dev->dma_mask = &dma_mask64;
+         dev->coherent_dma_mask = DMA_BIT_MASK(64);
+    }
+
+    return NOTIFY_OK;
+}
+
+static struct notifier_block exynos5440_platform_nb = {
+    .notifier_call = exynos5440_platform_notifier,
+};
+
 static void __init exynos5_dt_machine_init(void)
 {
  struct device_node *i2c_np;
@@ -52,6 +81,9 @@ static void __init exynos5_dt_machine_init(void)
  }
  }

+ if (of_machine_is_compatible("samsung,exynos5440"))
+     bus_register_notifier(&platform_bus_type, &exynos5440_platform_nb);
+
  of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }


> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

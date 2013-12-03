From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 3 Dec 2013 20:16:39 +0530
Subject: [RFC v2 2/4] power: asv: Add a common ASV driver for Exynos SoCs.
In-Reply-To: <1384515691-26299-3-git-send-email-sachin.kamat@linaro.org>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
 <1384515691-26299-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAM4voakmcVGTHF6zHh=GrghJexPQOVGtmAFr-w7qqaeKVDEW7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

CC'ing Doug and Andrew who have also worked on ASV.

[...]

> +
> +       chip_id = of_find_compatible_node(NULL, NULL,
> +                                               "samsung,exynos4210-chipid");
> +       if (!chip_id) {
> +               pr_err("%s: unable to find chipid\n", __func__);
> +               return -ENODEV;
> +       }
> +
> +       base = of_iomap(chip_id, 0);
> +       if (!base) {
> +               dev_err(&pdev->dev, "unable to map chip_id register\n");
> +               ret = -ENOMEM;
> +               goto err_map;
> +       }
My u-boot had the chipid clock disabled and I was getting an invalid
value at 1000_0004 (0 on the SMDK5420 and 0x43520010 on the
chromebook). Maybe it would be better if we enable the chipid clock in
the driver as well.
> +
> +       exynos_asv_info->base = base;
> +
> +       /* call SoC specific intialisation routine */
> +
> +       register_asv_member(exynos_asv_info->asv_list, exynos_asv_info->nr_mem);
> +
> +       iounmap(base);
> +err_map:
> +       of_node_put(chip_id);
> +
> +       return ret;
> +}
[...]
> diff --git a/drivers/power/asv/exynos-asv.h b/drivers/power/asv/exynos-asv.h
> new file mode 100644
> index 000000000000..89a1ae8b5e19
> --- /dev/null
> +++ b/drivers/power/asv/exynos-asv.h
> @@ -0,0 +1,21 @@
> +/*
> + * Exynos - Adaptive Supply Voltage Driver Header File
> + *
> + * copyright (c) 2013 samsung electronics co., ltd.
> + *             http://www.samsung.com/
Please fix the copyright

Thanks,
Abhilash

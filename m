From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 11 Jul 2016 16:44:06 +0200
Subject: [PATCH 2/2] soc: samsung: Add support for Exynos7 PMU
In-Reply-To: <CAJKOXPc=RZEe_zQvnmxXRttppJfGJwyjmkF0XxAnV0YnGxvcyA@mail.gmail.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
 <1467750507-13853-3-git-send-email-a.kesavan@samsung.com>
 <CAJKOXPc=RZEe_zQvnmxXRttppJfGJwyjmkF0XxAnV0YnGxvcyA@mail.gmail.com>
Message-ID: <CAM4voanpvkQJ5GcKeXoLcpmTMXkh7f8aznQHDS-0O5YeaVpeuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

[...]
>> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
>> index 0acdfd8..7cda8fb 100644
>> --- a/drivers/soc/samsung/exynos-pmu.c
>> +++ b/drivers/soc/samsung/exynos-pmu.c
>> @@ -88,6 +88,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
>>         }, {
>>                 .compatible = "samsung,exynos5420-pmu",
>>                 .data = &exynos5420_pmu_data,
>> +       }, {
>> +               .compatible = "samsung,exynos7-pmu",
>> +               .data = &exynos7_pmu_data,
>
> Hi,
>
> Thanks for the patch. Few comments:

Thanks for the review.
>
> You set here compatible for Exynos7. However there are at least three
> publicly known Exynos7 chipsets (7420, 7580, 7870 -
> https://en.wikipedia.org/wiki/Exynos). My questions are:
> 1. Are all of these share the same PMU configuration?
> 2. New different Exynos7 may be released, right?

Exynos7 is a Quad Core A57 based SoC that pre-dates all the above
mentioned SoCs. It is the closest to the exynos7420 in terms of the
IPs present. The PMU configuration between exynos7 and exynos7420 is
identical except for the extra A53 configuration required in case of
the 7420. The PMU configuration for 7580 and 7870 differ from that of
eynos7 and 7420 in terms of  the registers offsets, number of
registers being configured and some extra configurations. So, while
sharing of some functions is possible across the SoCs, each SoC should
ideally have its own PMU file. The posted patch adds PMU support for
only the exynos7 SoC.
>
> The exynos7 compatible is already spread all over DTS... but probably
> it is safer to use a specific SoC revision. Unless you are sure that
> all Exynos7 SoCs will be 100% compatible here and there won't be
> another exynos7xxx-pmu.
Please let me know if I can continue to use the exynos7 compatible
since it is a distinct SoC and not indicative of a series. However, if
you feel strongly about it then I can change the compatible to use
7420 since they are quite similar.
>
>
>>         },
>>         { /*sentinel*/ },
>>  };
[...]
>> +static void exynos7_pmu_init(void)
>> +{
>> +       unsigned int cpu;
>> +       unsigned int tmp, i;
>> +       struct device_node *node;
>> +       static void __iomem *atlas_cmu_base;
>
> 1. Why static?
> 2. This looks like used only in if() block below. Move it there so it
> will stay local to that block.

Will re-work as per your other comments below.
>
>> +
>> +        /* Enable only SC_FEEDBACK for the register list */
>> +       for (i = 0 ; i < ARRAY_SIZE(exynos7_list_feed) ; i++) {
>> +               tmp = pmu_raw_readl(exynos7_list_feed[i]);
>> +               tmp &= ~EXYNOS5_USE_SC_COUNTER;
>> +               tmp |= EXYNOS5_USE_SC_FEEDBACK;
>> +               pmu_raw_writel(tmp, exynos7_list_feed[i]);
>> +       }
>> +
>> +       /*
>> +        * Disable automatic L2 flush, Disable L2 retention and
>> +        * Enable STANDBYWFIL2, ACE/ACP
>> +        */
>> +       tmp = pmu_raw_readl(EXYNOS7_ATLAS_L2_OPTION);
>> +       tmp &= ~(EXYNOS7_USE_AUTO_L2FLUSHREQ | EXYNOS7_USE_RETENTION);
>> +       tmp |= (EXYNOS7_USE_STANDBYWFIL2 |
>> +               EXYNOS7_USE_DEACTIVATE_ACE |
>> +               EXYNOS7_USE_DEACTIVATE_ACP);
>> +       pmu_raw_writel(tmp, EXYNOS7_ATLAS_L2_OPTION);
>> +
>> +       /*
>> +        * Enable both SC_COUNTER and SC_FEEDBACK for the CPUs
>> +        * Use STANDBYWFI and SMPEN to indicate that core is ready to enter
>> +        * low power mode
>> +        */
>> +       for (cpu = 0; cpu < 4; cpu++) {
>
> '4' shouldn't be hardcoded here. num_possible_cpus()?

Will change.

[...]
>> +       /*
>> +        * Set clock freeze cycle count to 0 before and after arm clamp or
>> +        * reset signal transition
>> +        */
>> +       node = of_find_compatible_node(NULL, NULL,
>> +                               "samsung,exynos7-clock-atlas");
>> +       if (node) {
>> +               atlas_cmu_base = of_iomap(node, 0);
>> +               if (!atlas_cmu_base)
>> +                       return;
>> +
>> +               __raw_writel(0x0,
>> +                               atlas_cmu_base + EXYNOS7_CORE_ARMCLK_STOPCTRL);
>> +               iounmap(atlas_cmu_base);
>
> Missing:
> of_node_put(node);
>
> ...but I think this creates unnecessary dependency on different
> compatible. I understand that disabling the EXTENDED_CLKSTOP is needed
> after configuring the PMU so this code belongs here. However
> everything you need is just a mapping of CMU address. The PMU driver
> should receive in bindings everything it needs to do its work. Either
> it is a phandle to something or an address for iomap. In this case the
> PMU should probably get two addresses: PMU and optionally CMU (part of
> CMU for example). Of course bindings would have to be updated.

I will add an optional CMU phandle to the PMU bindings.
>
>> +       }
>> +
>> +       pr_info("Exynos7 PMU has been initialized\n");
>> +}
>> +
>> +const struct exynos_pmu_data exynos7_pmu_data = {
>> +       .pmu_config             = exynos7_pmu_config,
>> +       .pmu_init               = exynos7_pmu_init,
>> +       .pmu_config_extra       = exynos7_pmu_config_extra,
>> +       .powerdown_conf         = exynos7_powerdown_conf,
>> +};
>> diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
>> index d30186e..2de1d94 100644
>> --- a/include/linux/soc/samsung/exynos-regs-pmu.h
>> +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
>
> (...)
>
>> +/* EXYNOS7_PMU_DEBUG */
>> +#define EXYNOS7_CLKOUT_DISABLE                                 (0x1 << 0)
>> +
>> +#define EXYNOS7_USE_SMPEN                                      (0x1 << 28)
>> +#define EXYNOS7_USE_STANDBYWFE                                 (0x1 << 24)
>> +#define EXYNOS7_USE_STANDBYWFI                                 (0x1 << 16)
>> +#define EXYNOS7_USE_SC_FEEDBACK                                        (0x1 << 1)
>> +#define EXYNOS7_USE_SC_COUNTER                                 (0x1 << 0)
>> +
>> +/* EXYNOS7_PAD_RETENTION_AUD_OPTION */
>> +#define PAD_INITIATE_WAKEUP                                    (0x1 << 28)
>> +
>> +#define EXYNOS7_DUR_WAIT_RESET                                 (0xF << 20)
>> +#define EXYNOS7_DUR_SCALL                                      (0xF << 4)
>> +#define EXYNOS7_DUR_SCALL_VALUE                                        (0x1 << 4)
>> +
>> +#define EXYNOS7_SKIP_BLK_PWR_DOWN                              (0x1 << 8)
>> +#define EXYNOS7_ENABLE_ATLAS_CPU                               (0x1 << 0)
>> +
>> +#define EXYNOS7_PS_HOLD_OUTPUT                                 (0x1 << 8)
>> +#define EXYNOS7_ENABLE_HW_TRIP                                 (0x1 << 31)
>> +#define EXYNOS7_DBG_INITIATE_WAKEUP                            (0x3 << 16)
>> +
>> +#define EXYNOS7_CORE_ARMCLK_STOPCTRL                           (0x1000)
> Please add comment that this is from different block (CMU).

Will add a comment.
>> +
>>  #endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

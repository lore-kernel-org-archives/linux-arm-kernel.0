From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 9 Jan 2012 18:53:05 +0530
Subject: [PATCH v2 2/2] ARM: Exynos: Hook up power domains to generic
 power domain infrastructure
In-Reply-To: <CAH9JG2WWLrEkEMQp5m0itk7Sw3HRJ8CpDBrj3trjGPCv6qYHkw@mail.gmail.com>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
 <1325931055-14486-3-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2WWLrEkEMQp5m0itk7Sw3HRJ8CpDBrj3trjGPCv6qYHkw@mail.gmail.com>
Message-ID: <CAJuYYwSOcAtiV3fGOyzOD0eZiuf-T8wai13HpqNNDk3TXuP5Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Park.

On 9 January 2012 05:57, Kyungmin Park <kyungmin.park@samsung.com> wrote:
[...]

>> + * Exynos4 specific wrapper around the generic power domain
>> + */
>> +struct exynos4_pm_domain {
>> + ? ? void __iomem *base;
>> + ? ? char const *name;
>> + ? ? bool is_off;
>> + ? ? struct generic_pm_domain pd;
>> +};
> Even though you tested it at exynos4, we already know exynos5 will be used soon.
> so start to use the exynos prefix if possible.

Ok. I will change exynos4 to exynos.

[...]

>> +
>> +static __init int exynos4_pm_init_power_domain(void)
>> +{
>> + ? ? int idx;
>> + ? ? struct device_node *np;
> The np is only used at CONFIG_ON.

Ok. I will rework this.

>> +
>> +#ifdef CONFIG_OF
>> + ? ? if (!of_have_populated_dt())
>> + ? ? ? ? ? ? goto no_dt;
>> +
>> + ? ? for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
>> + ? ? ? ? ? ? struct exynos4_pm_domain *pd;
>> +
>> + ? ? ? ? ? ? pd = kzalloc(sizeof(*pd), GFP_KERNEL);
>> + ? ? ? ? ? ? if (!pd) {
>> + ? ? ? ? ? ? ? ? ? ? pr_err("exynos4_pm_init_power_domain: failed to "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "allocate memory for domain\n");
>> + ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? if (of_get_property(np, "samsung,exynos4210-pd-off", NULL))
>> + ? ? ? ? ? ? ? ? ? ? pd->is_off = true;
>> + ? ? ? ? ? ? pd->name = np->name;
>> + ? ? ? ? ? ? pd->base = of_iomap(np, 0);
>> + ? ? ? ? ? ? pd->pd.power_off = exynos4_pd_power_off;
>> + ? ? ? ? ? ? pd->pd.power_on = exynos4_pd_power_on;
>> + ? ? ? ? ? ? pd->pd.of_node = np;
>> + ? ? ? ? ? ? pm_genpd_init(&pd->pd, NULL, false);
>> + ? ? }
>> + ? ? return 0;
>> +#endif /* CONFIG_OF */
>> +
>> + no_dt:
> You should add the "#endif /* CONFIG_OF */ since no_dt is used at
> CONFIG_OF case.

Ok.

>> + ? ? for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++)
>> + ? ? ? ? ? ? pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? exynos4_pm_domains[idx]->is_off);
>> +

[...]

>> +#ifdef CONFIG_S5P_DEV_CSIS0
>> + ? ? if (pm_genpd_add_device(&exynos4_pd_cam.pd, &s5p_device_mipi_csis0.dev))
>> + ? ? ? ? ? ? pr_info("error in adding csis0 to cam power domain\n");
>> +#endif
> Also need to add CSIS1 as Sylwester mentioned.

Ok. I will add CSIS1.

Thanks for your review.

Regards,
Thomas.

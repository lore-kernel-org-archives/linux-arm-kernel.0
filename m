From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 9 Jan 2012 18:49:12 +0530
Subject: [PATCH v2 2/2] ARM: Exynos: Hook up power domains to generic
 power domain infrastructure
In-Reply-To: <4F085A4E.3010200@gmail.com>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
 <1325931055-14486-3-git-send-email-thomas.abraham@linaro.org>
 <4F085A4E.3010200@gmail.com>
Message-ID: <CAJuYYwQaGvAYnLY9uH91uEkVb82X5usQywpYGG36EyjHdQquoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester.

On 7 January 2012 20:14, Sylwester Nawrocki <snjw23@gmail.com> wrote:
[...]

>> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
>> new file mode 100644
>> index 0000000..95a7c55
>> --- /dev/null
>> +++ b/arch/arm/mach-exynos/pm_domains.c
>> @@ -0,0 +1,183 @@
>> +/*
>> + * Exynos4 Generic power domain support.
>> + *
>> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>
> 2012 ?

Ok. I will change this.

>
>> + * ? ? ? ? ? http://www.samsung.com

[...]

>> +static int exynos4_pd_power(struct generic_pm_domain *domain, bool power_on)
>> +{
>> + ? ? struct exynos4_pm_domain *pd;
>> + ? ? void __iomem *base;
>> + ? ? u32 timeout, pwr;
>> + ? ? char *op;
>> +
>> + ? ? pd = container_of(domain, struct exynos4_pm_domain, pd);
>> + ? ? base = pd->base;
>> +
>> + ? ? pwr = (power_on) ? S5P_INT_LOCAL_PWR_EN : 0;
>
> Is there any value in parentheses around 'power_on' ?

No. I will remove the parentheses around 'power_on'.

>
>> + ? ? __raw_writel(pwr, base);
>> +
>> + ? ? /* Wait max 1ms */
>> + ? ? timeout = 10;
>> +
>> + ? ? while ((__raw_readl(base + 0x4)& ?S5P_INT_LOCAL_PWR_EN) != pwr) {
>> + ? ? ? ? ? ? if (!timeout) {
>> + ? ? ? ? ? ? ? ? ? ? op = (power_on) ? "enable" : "disable";
>> + ? ? ? ? ? ? ? ? ? ? pr_err("Power domain %s %s failed\n", op, domain->name);
>
> How about just:
> ? ? ? pr_err("%s power domain state change (%d) failed\n",
> ? ? ? ? ? ? ?domain->name, power_on);
> ?

>From the message it will not be clear which state change failed. The
state (enable/disable) would be helpful.



>> + ? ? ? ? ? ? ? ? ? ? return -ETIMEDOUT;
>> + ? ? ? ? ? ? }
>> + ? ? ? ? ? ? timeout--;
>> + ? ? ? ? ? ? cpu_relax();
>
> Does cpu_relax() make any difference here ?

I need to check on this.

>
>> + ? ? ? ? ? ? usleep_range(80, 100);
>> + ? ? }
>> + ? ? return 0;
>> +}
>> +

[...]

>> + ? ? ? ? ? ? pd = kzalloc(sizeof(*pd), GFP_KERNEL);
>> + ? ? ? ? ? ? if (!pd) {
>> + ? ? ? ? ? ? ? ? ? ? pr_err("exynos4_pm_init_power_domain: failed to "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "allocate memory for domain\n");
>
> nit: what about:
> ? ? ? ? ? ? ? ? ? ? ? ?pr_err("%s: failed to allocate memory for domain\n",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__);
> ?

Yes. This is better. I will change this.

>> + ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
>> + ? ? ? ? ? ? }
>> +

[...]

>> +#ifdef CONFIG_S5P_DEV_CSIS0
>> + ? ? if (pm_genpd_add_device(&exynos4_pd_cam.pd,&s5p_device_mipi_csis0.dev))
>> + ? ? ? ? ? ? pr_info("error in adding csis0 to cam power domain\n");
>> +#endif
>
> Could you add CSIS1 as well ? Some boards will be using both MIPI-CSI receivers.

Ok. I will add CSIS1 here.

Thanks for your review.

Regards,
Thomas.

[...]

From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Thu, 11 Aug 2016 15:35:01 +0800
Subject: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <1466207668-10549-6-git-send-email-ynorov@caviumnetworks.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-6-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <57AC2AA5.1030808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

On 2016/6/18 7:54, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
>
> In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
> which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
>
>  From now, AARCH32_EL0 (former COMPAT) config option means the support of
> AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> and COMPAT indicates that one of them, or both, is enabled.
>
> Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0 instead
>
> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
...
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index c173d32..af200a8 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -134,15 +134,17 @@ static int c_show(struct seq_file *m, void *v)
>   		 */
>   		seq_puts(m, "Features\t:");
>   		if (compat) {
> -#ifdef CONFIG_COMPAT
> -			for (j = 0; compat_hwcap_str[j]; j++)
> -				if (compat_elf_hwcap & (1 << j))
> -					seq_printf(m, " %s", compat_hwcap_str[j]);
> -
> -			for (j = 0; compat_hwcap2_str[j]; j++)
> -				if (compat_elf_hwcap2 & (1 << j))
> -					seq_printf(m, " %s", compat_hwcap2_str[j]);
> -#endif /* CONFIG_COMPAT */
> +#ifdef CONFIG_AARCH32_EL0
I saw that compat_hwcap_str and compat_hwcap2_str is defined when
"CONFIG_COMPAT" is true. Why we only change it to CONFIG_AARCH32_EL0
in c show()?
> +			if (personality(current->personality) == PER_LINUX32) {
And "compat" is "personality(current->personality) == PER_LINUX32;",
it seems that there is no need to add this twice.

Regards

Bamvor
> +				for (j = 0; compat_hwcap_str[j]; j++)
> +					if (compat_elf_hwcap & (1 << j))
> +						seq_printf(m, " %s", compat_hwcap_str[j]);
> +
> +				for (j = 0; compat_hwcap2_str[j]; j++)
> +					if (compat_elf_hwcap2 & (1 << j))
> +						seq_printf(m, " %s", compat_hwcap2_str[j]);
> +			}
> +#endif /* CONFIG_AARCH32_EL0 */
>   		} else {
>   			for (j = 0; hwcap_str[j]; j++)
>   				if (elf_hwcap & (1 << j))

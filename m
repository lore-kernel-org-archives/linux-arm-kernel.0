From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 23:26:46 +0100
Subject: [PATCH v3 3/5] ARM: mediatek: add smp bringup code
In-Reply-To: <1436851111-2369-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1436851111-2369-1-git-send-email-yingjoe.chen@mediatek.com>
 <1436851111-2369-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20150805222646.GA4699@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 01:18:29PM +0800, Yingjoe Chen wrote:
> +static void __init __mtk_smp_prepare_cpus(unsigned int max_cpus, int trustzone)
> +{
> +	int i, num;
> +	const struct of_device_id *infos;
> +
> +	if (trustzone) {
> +		num = ARRAY_SIZE(mtk_tz_smp_boot_infos);
> +		infos = mtk_tz_smp_boot_infos;
> +	} else {
> +		num = ARRAY_SIZE(mtk_smp_boot_infos);
> +		infos = mtk_smp_boot_infos;
> +	}
> +
> +	/* Find smp boot info for this SoC */
> +	for (i = 0; i < num; i++) {
> +		if (of_machine_is_compatible(infos[i].compatible)) {
> +			mtk_smp_info = infos[i].data;
> +			break;
> +		}
> +	}
> +
> +	if (!mtk_smp_info) {
> +		pr_err("%s: Device is not supported\n", __func__);
> +		return;
> +	}
> +
> +	if (trustzone) {
> +		if (memblock_reserve(mtk_smp_info->smp_base, MTK_SMP_REG_SIZE)) {

Strong NAK.

This is _FAR_ too late to be calling memblock_reserve().  You won't be
reserving memory as you think you are (it's already handed over to the
kernel's allocators by this stage.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

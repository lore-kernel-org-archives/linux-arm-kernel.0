From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 7 Mar 2017 21:19:21 +0800
Subject: [PATCH 17/17] arm64: arch_timer: Add HISILICON_ERRATUM_161010101
 ACPI matching data
In-Reply-To: <20170306112622.13853-18-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-18-marc.zyngier@arm.com>
Message-ID: <13e4473e-e1ec-c193-4d5a-63787d149dda@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/3/6 19:26, Marc Zyngier wrote:
> In order to deal with ACPI enabled platforms suffering from the
> HISILICON_ERRATUM_161010101, let's add the required OEM data that
> allow the workaround to be enabled.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 6182871af4eb..b46584f058b6 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -270,6 +270,25 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
>  {
>  	return __hisi_161010101_read_reg(cntvct_el0);
>  }
> +
> +static struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
> +	{
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP05   ",
> +		.oem_revision	= 0,
> +	},
> +	{
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP06   ",
> +		.oem_revision	= 0,
> +	},
> +	{
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP07   ",
> +		.oem_revision	= 0,
> +	},
> +	{ },

Maybe it's better to add a comments that to say "It's needed to match
the end of oem info", but it's up to you :)

> +};
>  #endif
>
>  #ifdef CONFIG_ARM64_ERRATUM_858921
> @@ -347,6 +366,16 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.set_next_event_phys = erratum_set_next_event_tval_phys,
>  		.set_next_event_virt = erratum_set_next_event_tval_virt,
>  	},
> +	{
> +		.match_type = ate_match_acpi_oem_info,
> +		.id = hisi_161010101_oem_info,
> +		.desc_str = "HiSilicon erratum 161010101",
> +		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
> +		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
> +		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
> +		.set_next_event_phys = erratum_set_next_event_tval_phys,
> +		.set_next_event_virt = erratum_set_next_event_tval_virt,
> +	},
>  #endif
>  #ifdef CONFIG_ARM64_ERRATUM_858921
>  	{
>

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 17:10:00 +0000
Subject: [PATCH v3 6/6] kvm: arm64: Add ACPI support for virt arch timer
In-Reply-To: <1454358418-5157-7-git-send-email-fu.wei@linaro.org>
References: <1454358418-5157-1-git-send-email-fu.wei@linaro.org>
 <1454358418-5157-7-git-send-email-fu.wei@linaro.org>
Message-ID: <56B8CBE8.7020305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 20:26, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patch adds ACPI/GTDT support for virt arch timer
> using the API in GTDT driver.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  virt/kvm/arm/arch_timer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 0a279d3..4077347 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -385,6 +385,9 @@ static int kvm_timer_get_ppi(unsigned int *ppi)
>  {
>  	struct device_node *np;
>  	int ret = -EINVAL;
> +#ifdef CONFIG_ACPI_GTDT
> +	struct arch_timer_data data;
> +#endif
>  
>  	np = of_find_matching_node(NULL, arch_timer_of_match);
>  	if (!np) {
> @@ -397,6 +400,11 @@ static int kvm_timer_get_ppi(unsigned int *ppi)
>  	of_node_put(np);
>  
>  skip_of:
> +#ifdef CONFIG_ACPI_GTDT
> +	if (!*ppi && !gtdt_arch_timer_data_init(NULL, &data))
> +		*ppi = data.virt_ppi;
> +#endif
> +
>  	if (*ppi)
>  		return 0;
>  
> 

As I already pointed out in another thread hacking some KVM ACPI stuff,
this is the wrong approach.

We should have a *common* accessor in the timer code that exports the
relevant information, whatever the firmware "du jour" is.

See Julien's series, which seems to address the issue in a much more
convincing way:

https://lists.cs.columbia.edu/pipermail/kvmarm/2016-February/018531.html

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

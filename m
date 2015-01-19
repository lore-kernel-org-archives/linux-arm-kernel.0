From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Jan 2015 11:45:15 +0000
Subject: [PATCH v7 05/17] ARM64 / ACPI: If we chose to boot from acpi
 then disable FDT
In-Reply-To: <1421247905-3749-6-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150119114515.GG11835@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 03:04:53PM +0000, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> If the early boot methods of acpi are happy that we have valid ACPI
> tables and acpi=force has been passed, then do not unflat devicetree
> effectively disabling further hardware probing from DT.
> 
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 4580ed3..5d139e1 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -411,7 +411,8 @@ void __init setup_arch(char **cmdline_p)
>  	efi_idmap_init();
>  	early_ioremap_reset();
>  
> -	unflatten_device_tree();
> +	if (acpi_disabled)
> +		unflatten_device_tree();

Nitpick: you could actually squash this patch into the previous one to
keep the acpi disable/enable logic in one place.

-- 
Catalin

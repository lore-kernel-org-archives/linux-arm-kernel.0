From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Mar 2015 10:19:04 -0800
Subject: [PATCH v9 11/21] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
In-Reply-To: <1424853601-6675-12-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150305181904.GE4932@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 25, 2015 at 04:39:51PM +0800, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
> the former signals to the OS that the firmware is PSCI compliant.
> The latter selects the appropriate conduit for PSCI calls by
> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
> (SMC).
> 
> FADT table contains such information in ACPI 5.1, FADT table was
> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
> use the flags in struct acpi_gbl_FADT for PSCI init.
> 
> Since ACPI 5.1 doesn't support self defined PSCI function IDs,
> which means that only PSCI 0.2+ is supported in ACPI.
> 
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>


However, a comment on the color of the bike shed below. I'm fine with this
being addressed with an incremental patch instead of respun:

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index e8c7000..97fa7f3 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -390,10 +390,12 @@ void __init setup_arch(char **cmdline_p)
>  
>  	early_ioremap_reset();
>  
> -	if (acpi_disabled)
> +	if (acpi_disabled) {
>  		unflatten_device_tree();
> -
> -	psci_init();
> +		psci_dt_init();
> +	} else {
> +		psci_acpi_init();
> +	}

I would prefer having a common psci_init() in psci.c, which in turn calls
either the dt or the acpi version, and after that calls the set_functions
if the init function passed -- it'll keep more code common as new versions
of PSCI is added.

It also keeps setup_arch() somewhat cleaner, and avoids bubbling up the
dt-vs-acpi differences to the top level.


-Olof

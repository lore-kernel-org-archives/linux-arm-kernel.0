From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 6 Mar 2015 17:47:15 +0000
Subject: [PATCH v9 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY
 if ACPI is enabled on ARM64
In-Reply-To: <1424853601-6675-19-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150306174715.GA26888@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 08:39:58AM +0000, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> ACPI reduced hardware mode is disabled by default, but ARM64
> can only run properly in ACPI hardware reduced mode, so select
> ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.

Agreed. This will remove unneeded acpica code. I think though,
you should also check the FADT flag HW_REDUCED_ACPI at boot to
make sure that the tables are HW reduced compliant. I am flagging
this up because I noticed code in core code (not guarded by
ifdef) that checks:

acpi_gbl_reduced_hardware

and if it is not set it goes on instantiating fixed HW devices.

drivers/acpi/scan.c:2567

It is just a heads up, I think it is harmless, but one thing is
removing acpica code on ACPI HW reduced only, the other is to make
sure the kernel does not try to use ACPI HW features that acpica
can't support.

Lorenzo

> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1b8e973..d00ab9a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1,5 +1,6 @@
>  config ARM64
>  	def_bool y
> +	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -- 
> 1.9.1
> 
> 

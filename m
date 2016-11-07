From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 7 Nov 2016 16:30:05 +0000
Subject: [PATCH 2/3] arm64/setup: Use ID_AA64ISAR0_EL1_.* macros
In-Reply-To: <1441303972-9480-1-git-send-email-kuleshovmail@gmail.com>
References: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
 <1441303972-9480-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <f1ea41d9-6e34-11a4-9bd0-caaecc606ae6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/15 19:12, Alexander Kuleshov wrote:
> The 26d75e67c commit (arm64/cpufeature.h: Add macros for a cpu features
> testing) provides set of macros for the testing processor's crypto features.
> Let's use these macros instead of direct calculation.
>



> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  arch/arm64/kernel/setup.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 926ae8d..a3faf4f 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c

This patch doesn't apply on the current mainline tree. Where does this patch apply ?
The elf_hwcap calculation has been moved to a separate function setup_elf_hwcaps()
in arch/arm64/kernel/cpufeature.c,  which makes uses of a table of arm64_cpu_capabilities.

Suzuki

> @@ -250,33 +250,22 @@ static void __init setup_processor(void)
>
>  	/*
>  	 * ID_AA64ISAR0_EL1 contains 4-bit wide signed feature blocks.
> -	 * The blocks we test below represent incremental functionality
> -	 * for non-negative values. Negative values are reserved.
>  	 */
>  	features = read_cpuid(ID_AA64ISAR0_EL1);
> -	block = (features >> 4) & 0xf;
> -	if (!(block & 0x8)) {
> -		switch (block) {
> -		default:
> -		case 2:
> -			elf_hwcap |= HWCAP_PMULL;
> -		case 1:
> -			elf_hwcap |= HWCAP_AES;
> -		case 0:
> -			break;
> -		}
> -	}
>
> -	block = (features >> 8) & 0xf;
> -	if (block && !(block & 0x8))
> +	if (ID_AA64ISAR0_EL1_AES(features))
> +		elf_hwcap |= HWCAP_AES;
> +
> +	if (ID_AA64ISAR0_EL1_PMULL(features))
> +		elf_hwcap |= HWCAP_PMULL;
> +
> +	if (ID_AA64ISAR0_EL1_SHA1(features))
>  		elf_hwcap |= HWCAP_SHA1;
>
> -	block = (features >> 12) & 0xf;
> -	if (block && !(block & 0x8))
> +	if (ID_AA64ISAR0_EL1_SHA2(features))
>  		elf_hwcap |= HWCAP_SHA2;
>
> -	block = (features >> 16) & 0xf;
> -	if (block && !(block & 0x8))
> +	if (ID_AA64ISAR0_EL1_CRC32(features))
>  		elf_hwcap |= HWCAP_CRC32;

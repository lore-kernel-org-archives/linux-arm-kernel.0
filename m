From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 18:16:57 +0000
Subject: [PATCH] ARM: mm: fix PMD_SECT_RDONLY undeclared compile error
In-Reply-To: <1420653969-4048-1-git-send-email-victor.kamensky@linaro.org>
References: <1420653969-4048-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20150107181657.GS7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 06:06:09PM +0000, Victor Kamensky wrote:
> From: Victor Kamensky <kamensky@coreos-lnx2.cisco.com>
> 
> In v3.19-rc3 tree when CONFIG_ARM_LPAE and CONFIG_DEBUG_RODATA are enabled
> image failed to compile with the following error:
> 
> arch/arm/mm/init.c:661:14: error: ?PMD_SECT_RDONLY? undeclared here (not in a function)
> 
> It seems that '80d6b0c ARM: mm: allow text and rodata sections to be read-only'
> and 'ded9477 ARM: 8109/1: mm: Modify pte_write and pmd_write logic for LPAE'
> commits crossed. 80d6b0c uses PMD_SECT_RDONLY macro but ded9477 renames it
> and uses software bits L_PMD_SECT_RDONLY instead.
> 
> Fix is to use L_PMD_SECT_RDONLY instead PMD_SECT_RDONLY as ded9477 does in
> another places.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 98ad9c7..2495c8c 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -658,8 +658,8 @@ static struct section_perm ro_perms[] = {
>  		.start  = (unsigned long)_stext,
>  		.end    = (unsigned long)__init_begin,
>  #ifdef CONFIG_ARM_LPAE
> -		.mask   = ~PMD_SECT_RDONLY,
> -		.prot   = PMD_SECT_RDONLY,
> +		.mask   = ~L_PMD_SECT_RDONLY,
> +		.prot   = L_PMD_SECT_RDONLY,
>  #else
>  		.mask   = ~(PMD_SECT_APX | PMD_SECT_AP_WRITE),
>  		.prot   = PMD_SECT_APX | PMD_SECT_AP_WRITE,
> -- 
> 1.9.3
> 
> 

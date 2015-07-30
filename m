From: stefan@agner.ch (Stefan Agner)
Date: Thu, 30 Jul 2015 23:02:38 +0200
Subject: [PATCH v4] ARM: early fixmap support for earlycon
In-Reply-To: <1434491507-6208-1-git-send-email-stefan@agner.ch>
References: <1434491507-6208-1-git-send-email-stefan@agner.ch>
Message-ID: <00498073e34373292dd053cdb700ff25@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-16 23:51, Stefan Agner wrote:
>  static void __init devicemaps_init(const struct machine_desc *mdesc)
>  {
> @@ -1231,7 +1272,10 @@ static void __init devicemaps_init(const struct
> machine_desc *mdesc)
>  
>  	early_trap_init(vectors);
>  
> -	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
> +	/*
> +	 * Clear page table except top pmd used by early fixmaps
> +	 */
> +	for (addr = VMALLOC_START; addr < (FIXADDR_TOP & PMD_MASK); addr += PMD_SIZE)
>  		pmd_clear(pmd_off_k(addr));
>  

Hi Russel,

Checked this again, v4 does the right thing:
FIXADDR_TOP (0xffeff000) & PMD_MASK (0xffe00000) gives us the address of
the top PMD (0xFFE00000). We don't clear that since that is taken care
of by early fixmap support (early_fixmap_shutdown). v3 used
FIXADDR_START, which also left out the second to top PMD. The 3MiB of
fixmap spawns two PMD's however only the top PMD is handled by early
fixmap. Hence this was wrong in v3, but is fixed in v4.

Can you reconsider this patch?

--
Stefan

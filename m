From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jan 2015 16:40:15 +0000
Subject: [PATCH] arm/mm: fix compiler warning in pmdp_invalidate() (in
 -next)
In-Reply-To: <1422635852-21569-1-git-send-email-andre.przywara@arm.com>
References: <20150130100620.GL2395@suse.de>
 <1422635852-21569-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150130164015.GQ26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 04:37:32PM +0000, Andre Przywara wrote:
> Commit ff61d185f4e7 ("mm: convert p[te|md]_mknonnuma and remaining
> page table manipulations") removed a check in
> mm/pgtable-generic.c:pmdp_invalidate(), which leaves the
> pmd_mknotpresent macro the only user of the entry variable.
> For ARM/LPAE we use a constant 0 without referencing the argument to
> mark this condition, so the entry variable is no longer used here:
> 
> mm/pgtable-generic.c: In function 'pmdp_invalidate':
> mm/pgtable-generic.c:195:8: warning: unused variable 'entry' [-Wunused-variable]
>   pmd_t entry = *pmdp;
>         ^
> 
> Replace the ARM macro implementation with a static inline function to
> get rid of this warning.
>  
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi Andrew,
> 
> Mel mentioned that I should send that simple fix below to you to
> merge it with his original mmotm patch:
> mm-convert-p_mknonnuma-and-remaining-page-table-manipulations.patch
> The commit message above contains the mmotm-reference to this patch,
> which will break when it hits mainline.
> 
> Can you consider this? Given that's only a warning fix I am also
> happy with resending it after -rc1, if you reckon that this arch/arm
> change should not go via mmotm.

This isn't correct though.

>  /* represent a notpresent pmd by zero, this is used by pmdp_invalidate */
> -#define pmd_mknotpresent(pmd)	(__pmd(0))
> +static inline pmd_t pmd_mknotpresent(pmd_t pmd)
> +{
> +	return 0;
> +}

typedef struct { pmdval_t pmd; } pmd_t;

typedef u32 pmdval_t;

"0" is not compatible with pmd_t when STRICT_MM_TYPECHECKS is enabled.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

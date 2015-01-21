From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 21 Jan 2015 11:23:19 +0200
Subject: [next-20150119]regression (mm)?
In-Reply-To: <20150120140546.DDCB8D4@black.fi.intel.com>
References: <54BD33DC.40200@ti.com> <20150119174317.GK20386@saruman>
 <20150120001643.7D15AA8@black.fi.intel.com>
 <20150120114555.GA11502@n2100.arm.linux.org.uk>
 <20150120140546.DDCB8D4@black.fi.intel.com>
Message-ID: <54BF7007.7050800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2015 04:05 PM, Kirill A. Shutemov wrote:
> Russell King - ARM Linux wrote:
>> On Tue, Jan 20, 2015 at 02:16:43AM +0200, Kirill A. Shutemov wrote:
>>> Better option would be converting 2-lvl ARM configuration to
>>> <asm-generic/pgtable-nopmd.h>, but I'm not sure if it's possible.
>>
>> Well, IMHO the folded approach in asm-generic was done the wrong way
>> which barred ARM from ever using it.
> 
> Okay, I see.
> 
> Regarding the topic bug. Completely untested patch is below. Could anybody
> check if it helps?
> 
> From 34b9182d08ef2b541829e305fcc91ef1d26b27ea Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Tue, 20 Jan 2015 15:47:22 +0200
> Subject: [PATCH] arm: define __PAGETABLE_PMD_FOLDED for !LPAE
> 
> ARM uses custom implementation of PMD folding in 2-level page table case.
> Generic code expects to see __PAGETABLE_PMD_FOLDED to be defined if PMD is
> folded, but ARM doesn't do this. Let's fix it.
> 
> Defining __PAGETABLE_PMD_FOLDED will drop out unused __pmd_alloc().
> It also fixes problems with recently-introduced pmd accounting on ARM
> without LPAE.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/include/asm/pgtable-2level.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index bcc5e300413f..bfd662e49a25 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -10,6 +10,8 @@
>  #ifndef _ASM_PGTABLE_2LEVEL_H
>  #define _ASM_PGTABLE_2LEVEL_H
>  
> +#define __PAGETABLE_PMD_FOLDED
> +
>  /*
>   * Hardware-wise, we have a two level page table structure, where the first
>   * level has 4096 entries, and the second level has 256 entries.  Each entry
> 

Among other boards I have my daVinci board (OMAP-L138-EVM) boots fine with
this patch.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

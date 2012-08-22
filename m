From: tsoni@codeaurora.org (Trilok Soni)
Date: Wed, 22 Aug 2012 12:16:08 +0530
Subject: ioremap() fail on physical address 0x0 in 3.4 kernel
In-Reply-To: <5033C428.2050607@codeaurora.org>
References: <50339AF6.1060601@codeaurora.org> <5033C428.2050607@codeaurora.org>
Message-ID: <50348030.9080200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On 8/21/2012 10:53 PM, Laura Abbott wrote:
>
> Looks like you are hitting the empty section gap:
>
> 0xfa200000-0xfa300000 1048576 pmd_empty_section_gap+0x0/0x3c ioremap
>
> pmd_empty_section_gap ends up with vm->phys_addr = 0x0 because it was
> never set. This section isn't actually mapped so when searching for the
> range in the static io map it finds this address and returns it but it
> isn't actually a valid address to return. Perhaps ioremap should not
> bother trying to re-use the static iomap if the address is zero and let
> pmd_empty_section_gap use 0x0 as a dummy value?
>
>
>
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -228,7 +228,8 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned
> long pfn,
> */
> read_lock(&vmlist_lock);
> for (area = vmlist; area; area = area->next) {
> - if (!size || (sizeof(phys_addr_t) == 4 && pfn >= 0x100000))
> + if (!size || !pfn || (sizeof(phys_addr_t) == 4 &&
> + pfn >= 0x100000))

Thanks for the patch, but how about just checking pmd_none on such 
addresses and since there won't be any mapping created for such gaps? We 
need to check if this is fine for all, since I remember that Nico
added these functions for the OMAP boot issue I guess.

---Trilok Soni

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 26 Oct 2015 15:37:29 +0800
Subject: [PATCH v11 3/6] PCI: designware: Add ARM64 support
In-Reply-To: <20151022182853.GC21237@localhost>
References: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
 <1444991021-109306-4-git-send-email-wangzhou1@hisilicon.com>
 <20151022182853.GC21237@localhost>
Message-ID: <562DD839.8050504@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/23 2:28, Bjorn Helgaas wrote:
> Hi Zhou,
> 
> On Fri, Oct 16, 2015 at 06:23:38PM +0800, Zhou Wang wrote:
>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>> move related operations to dw_pcie_host_init.
>>
>> This patch also try to use of_pci_get_host_bridge_resources for ARM32 and ARM64
>> according to the suggestion for Gabriele[1]
>>
>> This patch reverts commit f4c55c5a3f7f ("PCI: designware: Program ATU with
>> untranslated address") based on 1/6 in this series. we delete *_mod_base in
>> pcie-designware. This was discussed in [2]
>>
>> I have compiled the driver with multi_v7_defconfig. However, I don't have
>> ARM32 PCIe related board to do test. It will be appreciated if someone could
>> help to test it.
> 
> There's a lot going on this patch.  Can you split it up at all?  For
> example, maybe:
>

Hi Bjorn,

No problem, I will split this patch to three patches.

>   - Revert f4c55c5a3f7f (and move to right after the related [1/6]
>     patch
> 
>   - Switch to using of_pci_get_host_bridge_resources()
> 
>   - Replacing the call of pci_common_init_dev() with equivalent code in
>     pcie-designware.c.  This one in particular needs to be easy to review.
>     It's not clear to me that this new code is equivalent.  For example,
>     pci_common_init_dev() calls pcie_bus_configure_settings(), but I don't
>     see that in your new code.

I will add pcie_bus_configure_settings in v12.

Thanks,
Zhou

>
> You already have acks and tested-by, so I assume you probably did all the
> right things, but it will help me out a lot if you can break it into
> bite-sized pieces.  It's always better to make patches too small rather
> than too large, because it's trivial to squash them back together if
> needed.  I think we're going to have some conflicts between this and other
> pcie-designware.c changes, and small patches will also make those easier to
> resolve.
> 
> Bjorn
> 
> .
> 

From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Nov 2014 14:29:36 +0100
Subject: [PATCH v4 12/19] arm/arm64: KVM: add vgic.h header file
In-Reply-To: <1415959683-26027-13-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-13-git-send-email-andre.przywara@arm.com>
Message-ID: <20141123132936.GY3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:07:56AM +0000, Andre Przywara wrote:
> vgic.c is currently a mixture of generic vGIC emulation code and
> functions specific to emulating a GICv2. To ease the addition of
> GICv3 later, we create new header file vgic.h, which holds constants
> and prototypes of commonly used functions.
> Rename some identifiers to avoid name space clutter.
> I removed the long-standing comment about using the kvm_io_bus API
> to tackle the GIC register ranges, as it wouldn't be a win for us
> anymore.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> -------
> As the diff isn't always obvious here (and to aid eventual rebases),
> here is a list of high-level changes done to the code:
> * moved definitions and prototypes from vgic.c to vgic.h:
>   - VGIC_ADDR_UNDEF
>   - ACCESS_{READ,WRITE}_*
>   - vgic_update_state()
>   - vgic_kick_vcpus()
>   - vgic_get_vmcr()
>   - vgic_set_vmcr()
>   - struct mmio_range {} (renamed to struct kvm_mmio_range)
> * removed static keyword and exported prototype in vgic.h:
>   - vgic_bitmap_get_reg()
>   - vgic_bitmap_set_irq_val()
>   - vgic_bitmap_get_shared_map()
>   - vgic_bytemap_get_reg()
>   - vgic_dist_irq_set()
>   - vgic_dist_irq_clear()
>   - vgic_cpu_irq_clear()
>   - vgic_reg_access()
>   - handle_mmio_raz_wi()
>   - vgic_handle_enable_reg()
>   - vgic_handle_pending_reg()
>   - vgic_handle_cfg_reg()
>   - vgic_unqueue_irqs()
>   - find_matching_range() (renamed to vgic_find_range)
>   - vgic_handle_mmio_range()
>   - vgic_update_state()
>   - vgic_get_vmcr()
>   - vgic_set_vmcr()
>   - vgic_queue_irq()
>   - vgic_kick_vcpus()
>   - vgic_init_maps()
>   - vgic_has_attr_regs()
>   - vgic_set_common_attr()
>   - vgic_get_common_attr()
> * moved functions to vgic.h (static inline):
>   - mmio_data_read()
>   - mmio_data_write()
>   - is_in_range()
> ---
> Changelog v3...v4:
> - rename struct mmio_range to struct kvm_mmio_range
> - rename find_matching_range() to vgic_find_range()
> - remove vgic_create() and vgic_destroy() from header

Why are we removing these from the header but still changing them from
static to non-static?  What did I misunderstand?

Otherwise:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

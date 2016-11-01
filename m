From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 01 Nov 2016 00:02:38 +0000
Subject: [PATCH v2] KVM: arm/arm64: vgic: Prevent access to invalid SPIs
In-Reply-To: <20161031172137.30807-1-andre.przywara@arm.com> (Andre Przywara's
 message of "Mon, 31 Oct 2016 17:21:37 +0000")
References: <20161031172137.30807-1-andre.przywara@arm.com>
Message-ID: <864m3sm5i9.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Oct 31 2016 at 05:21:37 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> In our VGIC implementation we limit the number of SPIs to a number
> that the userland application told us. Accordingly we limit the
> allocation of memory for virtual IRQs to that number.
> However in our MMIO dispatcher we didn't check if we ever access an
> IRQ beyond that limit, leading to out-of-bound accesses.
> Add a test against the number of allocated SPIs in check_region().
> Adjust the VGIC_ADDR_TO_INTID macro to avoid an actual division, which
> is not implemented on ARM(32).
>
> [maz: cleaned-up original patch]
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Hi Marc,
>
> does the last hunk fix the GCC issue that your recent fix addresses
> as well? ilog2 seems to be pretty cheap on ARM and ARM64, so I wonder
> if this version of the fix is better, since smaller?

Thanks for looking into this. That seems to solve it for me (with GCC
6.1.1).

[...]

> diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
> index 4c34d39..dacd1155 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio.h
> +++ b/virt/kvm/arm/vgic/vgic-mmio.h
> @@ -58,7 +58,7 @@ extern struct kvm_io_device_ops kvm_io_gic_ops;
>   * numerator and denominator with 8 to support at most 64 bits per IRQ:
>   */
>  #define VGIC_ADDR_TO_INTID(addr, bits)  (((addr) & VGIC_ADDR_IRQ_MASK(bits)) * \
> -					64 / (bits) / 8)
> +					64 >> (ilog2(bits) + 3))

Given that it's taken me the best of 10 minutes to convince myself that
this was correct, can you please save everybody some time by updating
the comment above the #define?

Please respin this as soon as you can.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.

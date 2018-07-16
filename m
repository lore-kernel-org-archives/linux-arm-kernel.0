From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jul 2018 09:28:00 +0100
Subject: [PATCH v3 7/9] KVM: arm/arm64: vgic: Permit uaccess writes to
 return errors
In-Reply-To: <1531587940-2490-8-git-send-email-christoffer.dall@arm.com>
References: <1531587940-2490-1-git-send-email-christoffer.dall@arm.com>
 <1531587940-2490-8-git-send-email-christoffer.dall@arm.com>
Message-ID: <08e71965-e39e-430f-3db5-765283ba3a0f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/18 18:05, Christoffer Dall wrote:
> Currently we do not allow any vgic mmio write operations to fail, which
> makes sense from mmio traps from the guest.  However, we should be able
> to report failures to userspace, if userspace writes incompatible values
> to read-only registers.  Rework the internal interface to allow errors
> to be returned on the write side for userspace writes.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v2.c | 26 +++++++++++++++++++++-----
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 31 ++++++++++++++++++++++++-------
>  virt/kvm/arm/vgic/vgic-mmio.c    | 18 +++++++++++++-----
>  virt/kvm/arm/vgic/vgic-mmio.h    | 19 +++++++++++--------
>  4 files changed, 69 insertions(+), 25 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> index 34e36fc..b79de42 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
> @@ -77,11 +77,26 @@ static void vgic_mmio_write_v2_misc(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> -static void vgic_mmio_uaccess_write_v2_group(struct kvm_vcpu *vcpu,
> -					     gpa_t addr, unsigned int len,
> -					     unsigned long val)
> +static int vgic_mmio_uaccess_write_v2_misc(struct kvm_vcpu *vcpu,
> +					   gpa_t addr, unsigned int len,
> +					   unsigned long val)
> +{
> +	switch (addr & 0x0c) {
> +	case GIC_DIST_IIDR:
> +		if (val != vgic_mmio_read_v2_misc(vcpu, addr, len))
> +			return -EINVAL;
> +	}
> +
> +	vgic_mmio_write_v2_misc(vcpu, addr, len, val);
> +	return 0;
> +}
> +
> +static int vgic_mmio_uaccess_write_v2_group(struct kvm_vcpu *vcpu,
> +					    gpa_t addr, unsigned int len,
> +					    unsigned long val)
>  {
>  	/* Ignore writes from userspace */
> +	return 0;
>  }

I think it'd make more sense if this patch came before the previous one
(change the prototype of the userspace accessor, and only then add a new
accessor that can return an error). It would avoid churn in the above
function, and you could move vgic_mmio_uaccess_write_v2_misc into patch 6.

Not a big deal though, as the code is otherwise perfectly fine.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

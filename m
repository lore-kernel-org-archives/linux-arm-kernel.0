From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 5 Apr 2016 17:17:18 +0200
Subject: [PATCH v4 04/12] KVM: arm64: handle ITS related GICv3
 redistributor registers
In-Reply-To: <1458958450-19662-5-git-send-email-andre.przywara@arm.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <1458958450-19662-5-git-send-email-andre.przywara@arm.com>
Message-ID: <5703D6FE.7080204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,
On 03/26/2016 03:14 AM, Andre Przywara wrote:
> In the GICv3 redistributor there are the PENDBASER and PROPBASER
> registers which we did not emulate so far, as they only make sense
> when having an ITS. In preparation for that emulate those MMIO
> accesses by storing the 64-bit data written into it into a variable
> which we later read in the ITS emulation.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  include/kvm/vgic/vgic.h       |  8 ++++++++
>  virt/kvm/arm/vgic/vgic_mmio.c | 26 ++++++++++++++++++++++----
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/kvm/vgic/vgic.h b/include/kvm/vgic/vgic.h
> index 11344e6..8ea5dd7 100644
> --- a/include/kvm/vgic/vgic.h
> +++ b/include/kvm/vgic/vgic.h
> @@ -145,6 +145,14 @@ struct vgic_dist {
>  
>  	struct vgic_io_device	*dist_iodevs;
>  	struct vgic_io_device	*redist_iodevs;
> +
> +	/* Address of LPI configuration table shared by all redistributors */
Doesn't this variable exactly match the PROPBASER register content. If
this statement is correct it does not exactly match the gpa of the
config table but also contains other info (cacheability, shareability,
IDbits). Hence the choice of u64 and not gpa_t. So if correct the
comment is misleading.
> +	u64			propbaser;
> +
> +	/* Addresses of LPI pending tables per redistributor */
> +	u64			*pendbaser;
same comment

Besides Reviewed-by: Eric Auger <eric.auger@linaro.org>

Best Regards

Eric
> +
> +	bool			lpis_enabled;
>  };
>  
>  struct vgic_v2_cpu_if {
> diff --git a/virt/kvm/arm/vgic/vgic_mmio.c b/virt/kvm/arm/vgic/vgic_mmio.c
> index 7d5d630..252b9aff 100644
> --- a/virt/kvm/arm/vgic/vgic_mmio.c
> +++ b/virt/kvm/arm/vgic/vgic_mmio.c
> @@ -771,7 +771,9 @@ static int vgic_mmio_read_v3r_propbase(struct kvm_vcpu *vcpu,
>  				       struct kvm_io_device *this,
>  				       gpa_t addr, int len, void *val)
>  {
> -	/* TODO: implement */
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	write_mask64(dist->propbaser, addr & 7, len, val);
>  	return 0;
>  }
>  
> @@ -779,7 +781,11 @@ static int vgic_mmio_write_v3r_propbase(struct kvm_vcpu *vcpu,
>  				        struct kvm_io_device *this,
>  				        gpa_t addr, int len, const void *val)
>  {
> -	/* TODO: implement */
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +
> +	/* Storing a value with LPIs already enabled is undefined */
> +	if (!dist->lpis_enabled)
> +		dist->propbaser = mask64(dist->propbaser, addr & 7, len, val);
>  	return 0;
>  }
>  
> @@ -787,7 +793,12 @@ static int vgic_mmio_read_v3r_pendbase(struct kvm_vcpu *vcpu,
>  				       struct kvm_io_device *this,
>  				       gpa_t addr, int len, void *val)
>  {
> -	/* TODO: implement */
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +	struct vgic_io_device *iodev = container_of(this,
> +						    struct vgic_io_device, dev);
> +	u64 pendbaser = dist->pendbaser[iodev->redist_vcpu->vcpu_id];
> +
> +	write_mask64(pendbaser, addr & 7, len, val);
>  	return 0;
>  }
>  
> @@ -795,7 +806,14 @@ static int vgic_mmio_write_v3r_pendbase(struct kvm_vcpu *vcpu,
>  				        struct kvm_io_device *this,
>  				        gpa_t addr, int len, const void *val)
>  {
> -	/* TODO: implement */
> +	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> +	struct vgic_io_device *iodev = container_of(this,
> +						    struct vgic_io_device, dev);
> +	u64 *pendbaser = &dist->pendbaser[iodev->redist_vcpu->vcpu_id];
> +
> +	/* Storing a value with LPIs already enabled is undefined */
> +	if (!dist->lpis_enabled)
> +		*pendbaser = mask64(*pendbaser, addr & 7, len, val);
>  	return 0;
>  }
>  
> 

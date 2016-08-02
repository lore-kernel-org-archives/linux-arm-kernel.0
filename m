From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Aug 2016 14:23:09 +0200
Subject: [PATCH] KVM: arm64: ITS: return 1 on successful MSI injection
In-Reply-To: <20160802111058.31496-1-andre.przywara@arm.com>
References: <20160802111058.31496-1-andre.przywara@arm.com>
Message-ID: <20160802122309.GH32244@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 12:10:58PM +0100, Andre Przywara wrote:
> According to the KVM API documentation a successful MSI injection
> should return a value > 0 on success.
> Since we pass the return value of vgic_its_inject_msi() directly on
> to upper layers and userland, we need to use the same semantics here.
> Briefly tested with QEMU and kvmtool on GICv3 hardware and the model.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Applies on top of next-20160728. Let me know if I should use a
> different base.
> 
> Cheers,
> Andre.
> 
>  virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 07411cf..3268250 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -468,6 +468,7 @@ static void vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
>   * Queries the KVM IO bus framework to get the ITS pointer from the given
>   * doorbell address.
>   * We then call vgic_its_trigger_msi() with the decoded data.
> + * According to the KVM_SIGNAL_MSI API description returns > 0 on success.
>   */
>  int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>  {
> @@ -493,7 +494,7 @@ int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>  	vgic_its_trigger_msi(kvm, iodev->its, msi->devid, msi->data);
>  	mutex_unlock(&iodev->its->its_lock);
>  
> -	return 0;
> +	return 1;
>  }
>  
>  /* Requires the its_lock to be held. */

Do we have a clear understanding of what 'guest blocked the MSI'
constitutes in the ARM world?

Thanks,
-Christoffer

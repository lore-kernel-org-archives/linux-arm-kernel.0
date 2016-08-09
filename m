From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Aug 2016 16:48:02 +0200
Subject: [PATCH] KVM: arm64: check for ITS device on MSI injection
In-Reply-To: <20160809095429.13393-1-andre.przywara@arm.com>
References: <20160809095429.13393-1-andre.przywara@arm.com>
Message-ID: <20160809144802.GI9175@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 10:54:29AM +0100, Andre Przywara wrote:
> When userspace provides the doorbell address for an MSI to be
> injected into the guest, we find a KVM device which feels responsible.
> Lets check that this device is really an emulated ITS before we make
> real use of the container_of-ed pointer.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 18a6871..9aeb3a4 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -471,6 +471,24 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
>  	return 0;
>  }
>  
> +static struct vgic_io_device *vgic_get_its_iodev(struct kvm_io_device *dev)
> +{
> +	struct vgic_io_device *iodev;
> +
> +	if (!dev)
> +		return NULL;

this feels defensive.  Wouldn't it make more sense to check the return
of kvm_io_bus_get_dev where its' called, and then conditionally call
this function?

Otherwise:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>


> +
> +	if (dev->ops != &kvm_io_gic_ops)
> +		return NULL;
> +
> +	iodev = container_of(dev, struct vgic_io_device, dev);
> +
> +	if (iodev->iodev_type != IODEV_ITS)
> +		return NULL;
> +
> +	return iodev;
> +}
> +
>  /*
>   * Queries the KVM IO bus framework to get the ITS pointer from the given
>   * doorbell address.
> @@ -493,10 +511,9 @@ int vgic_its_inject_msi(struct kvm *kvm, struct kvm_msi *msi)
>  	address = (u64)msi->address_hi << 32 | msi->address_lo;
>  
>  	kvm_io_dev = kvm_io_bus_get_dev(kvm, KVM_MMIO_BUS, address);
> -	if (!kvm_io_dev)
> -		return -ENODEV;
> -
> -	iodev = container_of(kvm_io_dev, struct vgic_io_device, dev);
> +	iodev = vgic_get_its_iodev(kvm_io_dev);
> +	if (!iodev)
> +		return -EINVAL;
>  
>  	mutex_lock(&iodev->its->its_lock);
>  	ret = vgic_its_trigger_msi(kvm, iodev->its, msi->devid, msi->data);
> -- 
> 2.9.0
> 

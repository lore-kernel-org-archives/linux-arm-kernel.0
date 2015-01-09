From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 Jan 2015 13:33:45 +0100
Subject: [PATCH v6 18/20] KVM: introduce kvm_check_device_type()
In-Reply-To: <1420804478-17354-19-git-send-email-andre.przywara@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
 <1420804478-17354-19-git-send-email-andre.przywara@arm.com>
Message-ID: <20150109123345.GR21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 11:54:36AM +0000, Andre Przywara wrote:
> While we can easily register and unregister KVM devices, there is
> currently no easy way of checking whether a device has been
> registered.
> Introduce kvm_check_device_type() for that purpose and use it in two
> existing functions. Also change the return code for an invalid
> type number from ENOSPC to EINVAL.
> This function will be later used by another patch set to check
> whether a KVM_CREATE_IRQCHIP ioctl is valid.

I feel like this is misguided and the vgic should be able to figure this
stuff out internally.  Did you have code for this approach somewhere
that I can take a look at?

I forget: Are we still requiring KVM_CREATE_IRQCHIP for VGICv3 or are we
just relying on users to use KVM_CREATE_DEVICE for anything in the
future?

> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog:
>  (new in v6)
> 
>  include/linux/kvm_host.h |    1 +
>  virt/kvm/kvm_main.c      |   33 +++++++++++++++++++++------------
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 83d770e..723d0d2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1038,6 +1038,7 @@ void kvm_device_get(struct kvm_device *dev);
>  void kvm_device_put(struct kvm_device *dev);
>  struct kvm_device *kvm_device_from_filp(struct file *filp);
>  int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type);
> +int kvm_check_device_type(u32 type);
>  void kvm_unregister_device_ops(u32 type);
>  
>  extern struct kvm_device_ops kvm_mpic_ops;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1cc6e2e..c7711b2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2341,13 +2341,24 @@ static struct kvm_device_ops *kvm_device_ops_table[KVM_DEV_TYPE_MAX] = {
>  #endif
>  };
>  
> -int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type)
> +int kvm_check_device_type(u32 type)
>  {
>  	if (type >= ARRAY_SIZE(kvm_device_ops_table))
> -		return -ENOSPC;
> +		return -EINVAL;
>  
> -	if (kvm_device_ops_table[type] != NULL)
> -		return -EEXIST;
> +	if (kvm_device_ops_table[type] == NULL)
> +		return -ENODEV;
> +
> +	return -EEXIST;

I think this looks a bit screwy, the function always return errors...?

> +}
> +
> +int kvm_register_device_ops(struct kvm_device_ops *ops, u32 type)
> +{
> +	int ret;
> +
> +	ret = kvm_check_device_type(type);
> +	if (ret != -ENODEV)
> +		return ret;
>  
>  	kvm_device_ops_table[type] = ops;
>  	return 0;
> @@ -2364,19 +2375,17 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
>  {
>  	struct kvm_device_ops *ops = NULL;
>  	struct kvm_device *dev;
> -	bool test = cd->flags & KVM_CREATE_DEVICE_TEST;
>  	int ret;
>  
> -	if (cd->type >= ARRAY_SIZE(kvm_device_ops_table))
> -		return -ENODEV;

now you're basically changing a userspace-facing ABI because the ENODEV
becomes an EINVAL, right?

> -
> -	ops = kvm_device_ops_table[cd->type];
> -	if (ops == NULL)
> -		return -ENODEV;
> +	ret = kvm_check_device_type(cd->type);
> +	if (ret != -EEXIST)
> +		return ret;
>  
> -	if (test)
> +	if (cd->flags & KVM_CREATE_DEVICE_TEST)
>  		return 0;
>  
> +	ops = kvm_device_ops_table[cd->type];
> +
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
> -- 
> 1.7.9.5
> 

Thanks,
-Christoffer

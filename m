From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 02 Oct 2015 10:51:38 +0300
Subject: [PATCH v2 09/15] KVM: arm64: implement basic ITS register handlers
In-Reply-To: <1436538111-4294-10-git-send-email-andre.przywara@arm.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-10-git-send-email-andre.przywara@arm.com>
Message-ID: <00a101d0fce7$2d60fc00$8822f400$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

 Long time has passed, but i started working on live migration of this thing, and found some more
problems.

> @@ -117,9 +305,26 @@ int vits_init(struct kvm *kvm)
>  	struct vgic_dist *dist = &kvm->arch.vgic;
>  	struct vgic_its *its = &dist->its;
> 
> +	dist->pendbaser = kmalloc(sizeof(u64) * dist->nr_cpus, GFP_KERNEL);
> +	if (!dist->pendbaser)
> +		return -ENOMEM;
> +
>  	spin_lock_init(&its->lock);
> 
>  	its->enabled = false;
> 
>  	return -ENXIO;
>  }
> +

 vits_init() allocates table for per-CPU pendbaser values. However, it is called from within
vgicv3_map_resources(), which is in turn called upon first vCPU run. This is too late, because in
case of live migration we would first want to set up all registers from within the userspace. But,
when i start doing this, i crash in handle_mmio_pendbaser_redist(), because of dist->pendbaser being
NULL.
 The solution is to split the function up. I moved vgic_register_kvm_io_dev() (introduced by later
patch) to vits_map_resources(), which is now called where vits_init() originally was. My new
vits_init() (which is made reentrant by checking for dist->pendbaser != NULL) is now called from
within two places:
 a) vits_map_resources()
 b) handle_mmio_pendbaser_redist()

 Therefore, all allocations happen either on first vCPU run, or on first PENDBASER access, whatever
comes first. An alternative is to do allocations during KVM_DEV_ARM_VGIC_CTRL_INIT.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

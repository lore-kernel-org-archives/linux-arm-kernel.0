From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Aug 2016 16:04:21 +0200
Subject: [RFC PATCH v1] arm/arm64: vgic-new: Create dist and redist
 iodevs earlier
In-Reply-To: <1467731491-6458-1-git-send-email-vijay.kilari@gmail.com>
References: <1467731491-6458-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20160802140421.GK32244@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On Tue, Jul 05, 2016 at 08:41:31PM +0530, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <vijayak@caviumnetworks.com>
> 
> The dist and redist regions are created and registered in
> vgic_register_dist_iodevs() and vgic_v3_init_redist_iodev()
> calls for distributor and redistributor respectively when
> vgic_v3_map_resources() is called. This mapping of resources
> is done when vcpu run ioctl is called.
> 
> Below is the call stack of the same.
> 
> [<ffff0000080b2e8c>] vgic_register_redist_iodevs+0x94/0x27c
> [<ffff0000080b0fd8>] vgic_v3_map_resources+0x138/0x188
> [<ffff0000080affa4>] kvm_vgic_map_resources+0xb0/0xb8
> [<ffff0000080a3888>] kvm_arch_vcpu_ioctl_run+0x4a8/0x550
> [<ffff00000809c218>] kvm_vcpu_ioctl+0x304/0x74c
> [<ffff000008232cac>] do_vfs_ioctl+0xc0/0x754
> [<ffff0000082333d0>] SyS_ioctl+0x90/0xa4
> [<ffff000008084af0>] el0_svc_naked+0x24/0x28
> 
> During live migration, the destination VM first restores the all the
> GIC registers(dist, rdist and cpuif registers) using ioctl's before
> resuming the VM.So no vcpu run ioctl is called untill complete
> GIC context is restored.
> 
> Hence, In case of live migration, when ioctls are called to write
> dist/rdist registers the ioctls fails as
> vcpu->kvm->arch.vgic.dist_iodev andkvm->arch.vgic.redist_iodevs
> are NULL.
> 

Is this for GICv3 only?  Can you give me a more specific pointer to the
place where this fails or a traceback?

Definitely the approach of registering things early doesn't work,
because it breaks all sorts of other things.

So the trick is to make sure userspace accesses can work without a
registers kvm iodev.  I will have a look at this, but some more conceret
info as requested above will be helpful.

Thanks,
-Christoffer

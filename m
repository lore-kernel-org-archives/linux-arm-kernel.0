From: drjones@redhat.com (Andrew Jones)
Date: Fri, 8 Jan 2016 16:59:11 +0100
Subject: [PATCH v8 20/20] KVM: ARM64: Add a new kvm ARM PMU device
In-Reply-To: <20160108152028.GD3458@hawk.localdomain>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-21-git-send-email-zhaoshenglong@huawei.com>
 <20160107201859.GI6199@hawk.localdomain>
 <568F248F.7020602@huawei.com>
 <20160108112213.GA3458@hawk.localdomain>
 <20160108152028.GD3458@hawk.localdomain>
Message-ID: <20160108155911.GF3458@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 04:20:28PM +0100, Andrew Jones wrote:
> On Fri, Jan 08, 2016 at 12:22:13PM +0100, Andrew Jones wrote:
> > When we want more than 256 vcpus we'll need a new kvm-irq-line ioctl,
> > but, as for the arm devices, we could avoid the problem completely by
> > extending the SET/GET_DEVICE_ATTR ioctl to also be a vcpu ioctl.
> 
> Replying to myself on this comment. The arm-gic device is fine as is, as
> it really is a vm device. However I'm convincing myself more and more
> (and with the help of Radim Krcmar being my sounding board) that using
> the device api for the pmu is wrong (at least as a per-vm device). The
> pmu is a per-vcpu device.
> 
> I think we should consider adding KVM_CREATE_DEVICE, KVM_SET/GET_DEVICE_ATTR
> to the vcpu ioctl to allow per-vcpu devices. Then, instead of looping vcpus
> in the kernel to init the pmu per vcpu on the call to KVM_CREATE_DEVICE,
> we'd have the more natural looping in userspace. Also, the set-attr for the
> irq would be part of that loop, and no longer need a vcpu-index parameter.
>

Another note, for this pmu device we don't actually need KVM_CREATE_DEVICE
to be a vcpu ioctl. We can just add another vcpu-init feature flag that we
set with KVM_ARM_VCPU_INIT in order to "create" the pmu. We still need to
add KVM_SET/GET_DEVICE_ATTR to the vcpu ioctl though, allowing the irq to
be set. KVM_ARM_PMU_GRP_IRQ will just become a vcpu attribute.

Thanks,
drew

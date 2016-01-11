From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 11 Jan 2016 16:29:03 +0000
Subject: [PATCH v8 20/20] KVM: ARM64: Add a new kvm ARM PMU device
In-Reply-To: <20160111162159.GG3924@hawk.localdomain>
References: <1450771695-11948-21-git-send-email-zhaoshenglong@huawei.com>
 <CAFEAcA_MDiOphseZ7RGNE3G=4ZDF5SFV5krOjanPbVuhgg9gnQ@mail.gmail.com>
 <568E7AF1.9040103@huawei.com>
 <CAFEAcA-Qcda7TSFLSeykLHqZYdP6tYdEjPe2uHN6f_+omqWFZg@mail.gmail.com>
 <20160107203647.GJ6199@hawk.localdomain> <20160109122956.GA30867@cbox>
 <20160109150339.10576e81@arm.com> <20160111140717.GD3924@hawk.localdomain>
 <20160111150929.GB15554@cbox> <20160111160927.GF3924@hawk.localdomain>
 <20160111162159.GG3924@hawk.localdomain>
Message-ID: <CAFEAcA_=7nJz3Wh8py9OaSM_t0eFUcCUcb23-W2cDi-M65ZPYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 January 2016 at 16:21, Andrew Jones <drjones@redhat.com> wrote:
> On Mon, Jan 11, 2016 at 05:09:27PM +0100, Andrew Jones wrote:
>> On Mon, Jan 11, 2016 at 04:09:29PM +0100, Christoffer Dall wrote:
>> > Are vcpu ids already exposed to userspace (beyond the stupid
>> > KVM_IRQ_LINE) ioctl and as such we're bound to whatever upper limit and
>> > format they have?
>>
>> The only other place I found is KVM_CREATE_VCPU. I suppose we could move
>> to MPIDR for that, and it would be a nice way to handle the "userspace
>> determines MPIDR" work that I plan to do. Both KVM and its userspaces
>> would still use some counter-based vcpu identifiers internally, to avoid
>> large, sparse structures, but I guess the advantage is that they don't
>> have to agree on how they do that. The 'vcpu id' used by KVM_CREATE_VCPU
>> is already 32-bits, and is supposed to be an arbitrary identifier. That
>> all looks good for converting to MPIDR.
>>
>
> Correction. I understand that vcpu-id is "supposed" to be an arbitrary
> identifier now, but it doesn't appear that all the assumptions that it's
> a counter are gone yet... virt/kvm/kvm_main.c has
>
> static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
> ...
>         if (id >= KVM_MAX_VCPUS)
>                 return -EINVAL;

I think the last time we talked about supporting "userspace
determines MPIDR" the idea was to do it by allowing userspace to
write to the MPIDR register with KVM_SET_ONE_REG. So you'd
create a bunch of CPUs with vcpu-ids as usual, and then the
MPIDRs would be set for them later as appropriate (or not
at all, if userspace was an older qemu).

thanks
-- PMM

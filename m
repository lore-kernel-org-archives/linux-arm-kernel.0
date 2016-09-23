From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Sep 2016 10:50:38 +0100
Subject: [PATCH v6 1/7] arm/arm64: vgic-new: Implement support for
 userspace access
In-Reply-To: <CALicx6uuL9xX3VxLCy+EZi0AqXrNM_O+F3MN+W4gbiriUyb7Ug@mail.gmail.com>
References: <1474351965-11586-1-git-send-email-vijay.kilari@gmail.com>
 <1474351965-11586-2-git-send-email-vijay.kilari@gmail.com>
 <57E3C9D8.7070906@arm.com>
 <CALicx6uuL9xX3VxLCy+EZi0AqXrNM_O+F3MN+W4gbiriUyb7Ug@mail.gmail.com>
Message-ID: <57E4FAEE.3070003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/16 15:01, Vijay Kilari wrote:
> On Thu, Sep 22, 2016 at 5:38 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 20/09/16 07:12, vijay.kilari at gmail.com wrote:
>>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>> +static int vgic_uaccess_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
>>> +                          gpa_t addr, u32 *val)
>>> +{
>>> +     struct vgic_io_device *iodev = kvm_to_vgic_iodev(dev);
>>> +     const struct vgic_register_region *region;
>>> +     struct kvm_vcpu *r_vcpu;
>>> +
>>> +     region = vgic_get_mmio_region(iodev, addr, sizeof(u32));
>>> +     if (!region) {
>>> +             *val = 0;
>>> +             return 0;
>>
>> This is not the previous semantic of vgic_uaccess, and I cannot see why
>> blindly ignoring an access to an undefined region would be acceptable.
>> What am I missing?
> 
> AFAIK, the vgic_uaccess is not making any check on undefined region/register.
> However, dispatch_mmio_read/write are returning 0 if check of region is failed

Hmmm. Fair enough. I don't really like it, but that's something for
another day.

	M.
-- 
Jazz is not dead. It just smells funny...

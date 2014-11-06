From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 06 Nov 2014 15:13:57 +0000
Subject: [PATCH v3 00/19] KVM GICv3 emulation
In-Reply-To: <20141106112125.GA3748@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <20141106105751.GA29968@cbox> <20141106112125.GA3748@cbox>
Message-ID: <545B9035.8030108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/11/14 11:21, Christoffer Dall wrote:
> On Thu, Nov 06, 2014 at 11:57:51AM +0100, Christoffer Dall wrote:
>> On Fri, Oct 31, 2014 at 05:26:35PM +0000, Andre Przywara wrote:
>>
>> [...]
>>
>>>
>>> Please review and test.
>>> I would be grateful for people to test for GICv2 regressions also
>>> (so on a GICv2 host with current kvmtool/qemu), as there is quite
>>> some refactoring on that front.
>>>
>> So looking at the final result, we have a very strange flow with the
>> vgic_create() and kvm_vgic_create() functions.  I lost track in all the
>> rewrite patches how this happened exactly, but what I think you want to
>> end up with is:
>>
>> one exported function:
>> int kvm_vgic_create(struct kvm_device *dev, u32 type);
>>
>> which calls a static function:
>> static int vgic_create(struct kvm *kvm, u32 type);
>>
>> or simply inline the static one in the exported one, I can't seem to
>> find other callers.
>>
> Strike that, my cscope setup was messed up.
> 
> What I think you want is a static vgic_v3_create in vgic-v3-emul.c that
> digs out the struct kvm pointer from the struct kvm_device and calls
> kvm_vgic_create() and also just copy that single kfree(dev) line into
> vgic_v3_destroy in vgic-v3-emul.c and the same for v2.

So you want to remove vgic_destroy() and vgic_create() from vgic.c and
vgic.h and use a static version of it in vgic-v[23]-emul.c instead?
To avoid the two prototypes and make the declaration of the struct
kvm_device_ops look nicer? Did I got this right?

I did that now, it looks a bit neater, at the cost of small code
duplication of admittedly trivial code. So as long as there isn't
something added to those functions, that's probably fine.

So I will include it in the next version.

Cheers,
Andre.

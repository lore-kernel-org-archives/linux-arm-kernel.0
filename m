From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Dec 2014 18:25:50 +0000
Subject: [PATCH 1/5] arm/arm64: KVM: vgic: move reset initialization into
 vgic_init_maps()
In-Reply-To: <20141211114810.GC28388@cbox>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-2-git-send-email-christoffer.dall@linaro.org>
 <54881C5D.7060203@linaro.org> <20141211114810.GC28388@cbox>
Message-ID: <5489E1AE.4010209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/14 11:48, Christoffer Dall wrote:
> On Wed, Dec 10, 2014 at 11:11:41AM +0100, Eric Auger wrote:
>> Hi Christoffer,
>> Reviewed-by: Eric Auger <eric.auger@linaro.org>
>> see few comments below.
>> On 12/09/2014 04:44 PM, Christoffer Dall wrote:
>>> From: Peter Maydell <peter.maydell@linaro.org>
>>>
>>> VGIC initialization currently happens in three phases:
>>>  (1) kvm_vgic_create() (triggered by userspace GIC creation)
>>>  (2) vgic_init_maps() (triggered by userspace GIC register read/write
>>>      requests, or from kvm_vgic_init() if not already run)
>>>  (3) kvm_vgic_init() (triggered by first VM run)
>>>
>>> We were doing initialization of some state to correspond with the
>>> state of a freshly-reset GIC in kvm_vgic_init(); this is too late,
>>> since it will overwrite changes made by userspace using the
>>> register access APIs before the VM is run. Move this initialization
>>> earlier, into the vgic_init_maps() phase.
>>>
>>> This fixes a bug where QEMU could successfully restore a saved
>>> VM state snapshot into a VM that had already been run, but could
>>> not restore it "from cold" using the -loadvm command line option
>>> (the symptoms being that the restored VM would run but interrupts
>>> were ignored).
>>>
>>> Finally rename vgic_init_maps to vgic_init and renamed kvm_vgic_init to
>>> kvm_vgic_map_resources.
>>>
>>>   [ This patch is originally written by Peter Maydell, but I have
>>>     modified it somewhat heavily, renaming various bits and moving code
>>>     around.  If something is broken, I am to be blamed. - Christoffer ]
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>> This patch was originally named "vgic: move reset initialization into
>>> vgic_init_maps()" but I renamed it slightly to match the other vgic
>>> patches in the kernel.  I also did the additional changes since the
>>> original patch:
>>>  - Renamed kvm_vgic_init to kvm_vgic_map_resources
>>>  - Renamed vgic_init_maps to vgic_init
>>>  - Moved vgic_enable call into existing vcpu loop in vgic_init
>>>  - Moved ITARGETSRn initializtion above vcpu loop in vgic_init (the idea
>> typo
>>>    is to init global state first, then vcpu state).
>>
>> kvm_vgic_vcpu_init also has disappeared and PPI settings of
>> dist->irq_enabled and dist->irq_cfg now are in former vgic_init_maps.
>>
>> Maybe it would be simpler to review if there were 2 patches: one for
>> init redistribution from kvm_vgic_init to vgic_init_maps and one for the
>> renaming.
> 
> Maybe, but if you apply this patch and review it that way, it becomes
> much easier.  I'd really like to get this in soon, so given you already
> gave me your reviewed-by, I'm going to wait and see what Marc says and
> only respin if he finds it necessary.

No, I think this is fine as it is. This is a good cleanup, and it seems
to simplify the whole thing (and yes, we could do with simplicity in
this file...).

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

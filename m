From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 3 Sep 2018 11:03:25 +0100
Subject: [PATCH v4 05/20] kvm: arm64: Add helper for loading the stage2
 setting for a VM
In-Reply-To: <20180830093953.GA4029@e113682-lin.lund.arm.com>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
 <1531905547-25478-6-git-send-email-suzuki.poulose@arm.com>
 <20180830093953.GA4029@e113682-lin.lund.arm.com>
Message-ID: <d0349651-6c29-26d4-012e-01df601494e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/18 10:39, Christoffer Dall wrote:
> On Wed, Jul 18, 2018 at 10:18:48AM +0100, Suzuki K Poulose wrote:
>> We load the stage2 context of a guest for different operations,
>> including running the guest and tlb maintenance on behalf of the
>> guest. As of now only the vttbr is private to the guest, but this
>> is about to change with IPA per VM. Add a helper to load the stage2
>> configuration for a VM, which could do the right thing with the
>> future changes.
>>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since v2:
>>   - New patch
>> ---
>>   arch/arm64/include/asm/kvm_hyp.h | 6 ++++++
>>   arch/arm64/kvm/hyp/switch.c      | 2 +-
>>   arch/arm64/kvm/hyp/tlb.c         | 4 ++--
>>   3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
>> index 384c343..82f9994 100644
>> --- a/arch/arm64/include/asm/kvm_hyp.h
>> +++ b/arch/arm64/include/asm/kvm_hyp.h
>> @@ -155,5 +155,11 @@ void deactivate_traps_vhe_put(void);
>>   u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
>>   void __noreturn __hyp_do_panic(unsigned long, ...);
>>   
>> +/* Must be called from hyp code running at EL2 */
> 
> more importantly than having to run this at EL2, is that it must have
> gone through the proper sequence of update_vttbr() and disabling
> interrupts to avoid using a stale VMID.

Right, I will update the comment.

Cheers
Suzuki

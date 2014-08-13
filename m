From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 13 Aug 2014 23:06:56 +0900
Subject: [PATCH v4] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140813113300.GA25475@cbox>
References: <20140811203823.2828.36074.stgit@joelaarch64.amd.com>
 <20140812160521.GO10550@cbox> <20140813113300.GA25475@cbox>
Message-ID: <34E6983C-7575-43A3-809D-B775C575F177@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aug 13, 2014, at 8:33 PM, Christoffer Dall wrote:
> On Tue, Aug 12, 2014 at 06:05:21PM +0200, Christoffer Dall wrote:
>> On Mon, Aug 11, 2014 at 03:38:23PM -0500, Joel Schopp wrote:
>>> The current VTTBR_BADDR_MASK only masks 39 bits, which is broken on current
>>> systems.  Rather than just add a bit it seems like a good time to also set
>>> things at run-time instead of compile time to accomodate more hardware.
>>> 
>>> This patch sets TCR_EL2.PS, VTCR_EL2.T0SZ and vttbr_baddr_mask in runtime,
>>> not compile time.
>>> 
>>> In ARMv8, EL2 physical address size (TCR_EL2.PS) and stage2 input address
>>> size (VTCR_EL2.T0SZE) cannot be determined in compile time since they
>>> depend on hardware capability.
>>> 
>>> According to Table D4-23 and Table D4-25 in ARM DDI 0487A.b document,
>>> vttbr_x is calculated using different fixed values with consideration
>>> of T0SZ, granule size and the level of translation tables. Therefore,
>>> vttbr_baddr_mask should be determined dynamically.
>>> 
>>> Changes since v3:
>>> Another rebase
>>> Addressed minor comments from v2
>>> 
>>> Changes since v2:
>>> Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next branch
>>> 
>>> Changes since v1:
>>> Rebased fix on Jungseok Lee's patch https://lkml.org/lkml/2014/5/12/189 to
>>> provide better long term fix.  Updated that patch to log error instead of
>>> silently fail on unaligned vttbr.
>>> 
>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>> Cc: Sungjinn Chung <sungjinn.chung@samsung.com>
>>> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
>>> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
>>> ---
>>> arch/arm/kvm/arm.c               |  116 +++++++++++++++++++++++++++++++++++++-
>>> arch/arm64/include/asm/kvm_arm.h |   17 +-----
>>> arch/arm64/kvm/hyp-init.S        |   20 +++++--
>>> 3 files changed, 131 insertions(+), 22 deletions(-)
>>> 
>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>> index 3c82b37..b4859fa 100644
>>> --- a/arch/arm/kvm/arm.c
>>> +++ b/arch/arm/kvm/arm.c
>>> @@ -37,6 +37,7 @@
>>> #include <asm/mman.h>
>>> #include <asm/tlbflush.h>
>>> #include <asm/cacheflush.h>
>>> +#include <asm/cputype.h>
>>> #include <asm/virt.h>
>>> #include <asm/kvm_arm.h>
>>> #include <asm/kvm_asm.h>
>>> @@ -61,6 +62,8 @@ static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>>> static u8 kvm_next_vmid;
>>> static DEFINE_SPINLOCK(kvm_vmid_lock);
>>> 
>>> +static u64 vttbr_baddr_mask;
>>> +
>>> static bool vgic_present;
>>> 
>>> static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>>> @@ -412,6 +415,103 @@ static bool need_new_vmid_gen(struct kvm *kvm)
>>> 	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
>>> }
>>> 
>>> +
>>> +
>>> +	/*
>>> +	 * ARMv8 64K architecture limitations:
>>> +	 * 16 <= T0SZ <= 21 is valid under 3 level of translation tables
>>> +	 * 18 <= T0SZ <= 34 is valid under 2 level of translation tables
>>> +	 * 31 <= T0SZ <= 39 is valid under 1 level of transltaion tables
>>> +	 *
>>> +	 * ARMv8 4K architecture limitations:
>>> +	 * 16 <= T0SZ <= 24 is valid under 4 level of translation tables
>>> +	 * 21 <= T0SZ <= 30 is valid under 3 level of translation tables
>> 
>> this is still wrong, as I pointed out, it should be 21 <= T0SZ <= 30
>> 
> typo: I meant: 21 <= T0SZ <= 33

Christoffer is right. The original patch, [1], described the conditions incorrectly.

[1]: https://lkml.org/lkml/2014/5/12/189

- Jungseok Lee

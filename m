From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 2 Mar 2016 10:22:39 +0000
Subject: [PATCH v2 8/8] arm64: kvm: Check support for AArch32 for 32bit
 guests
In-Reply-To: <56D6AD72.8010108@arm.com>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
 <1456393968-17386-9-git-send-email-suzuki.poulose@arm.com>
 <56D6AD72.8010108@arm.com>
Message-ID: <56D6BEEF.3000208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/16 09:08, Marc Zyngier wrote:
> On 25/02/16 09:52, Suzuki K Poulose wrote:

>> I really wanted to pass kvm_vcpu down to the helpers. But then, I can't
>> define the arch specific helper in asm/kvm_host.h due to lack of kvm_vcpu's
>> definition yet:
>>
>>   In file included from include/linux/kvm_host.h:35:0,
>>                    from arch/arm64/kernel/asm-offsets.c:24:
>>   ./arch/arm64/include/asm/kvm_host.h: In function ?kvm_arch_vcpu_validate_features?:
>>   ./arch/arm64/include/asm/kvm_host.h:344:48: error: dereferencing pointer to incomplete type
>>     return  !test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features) ||
>
> Why don't you just have the prototype in kvm_host.h, and move the actual
> implementation to something like guest.c? But I think there is a better
> approach, see below.

I thought it would better be a static inline. But, the GCC can do that, silly me :)

>
> This is really convoluted (it took me 5 minutes staring at the
> expression and remembering that AArch32 EL1 implies AArch32 EL0 to get it).
>
> Now, we already have kvm_reset_vcpu() that validates AArch32 support. It
> would probably be better to move things there. Thoughts?

Definitely. I overlooked the function name to do something
specific to resetting the CPU than doing some checks :(.
I will respin it.

Cheers
Suzuki

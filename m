From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 14 Aug 2013 11:22:04 +0100
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <c8a1944576151990b3315183acee02be@www.loen.fr>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <c8a1944576151990b3315183acee02be@www.loen.fr>
Message-ID: <CAFEAcA8jgn9V1ANXXTsA_099BcsbC5NHPEMRh6=Rz1g8EDgBHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 10:32, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 2013-08-14 10:22, Andre Przywara wrote:

>> +static int kvm_ignore_l2x0_call(struct kvm_vcpu *vcpu)
>> +{
>> +     unsigned long fn_nr = *vcpu_reg(vcpu, 12) & ~((u32) 0);
>> +
>> +     if (fn_nr == 0x102) {
>> +             kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>> +             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>
> And what if I run mach-foo which uses r12 to request bar services from
> secure mode? Is it safe to ignore it? We need something much better than
> just testing random registers to guess what the guest wants.

Definitely. This needs to be addressed via the kernel providing
some mechanism so that userspace and/or a KVM-specific bit
of 'firmware' running in the guest VM can handle the SMC
calls the guest tries to make, because it's totally board
specific.

-- PMM

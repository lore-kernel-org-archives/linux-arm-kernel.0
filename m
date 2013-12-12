From: andre.przywara@linaro.org (Andre Przywara)
Date: Thu, 12 Dec 2013 10:32:43 +0100
Subject: [PATCH v4] ARM/KVM: save and restore generic timer registers
In-Reply-To: <CAFEAcA_F3T1+YsKKq3h8P139OX085N-PPPPZo5dvwgwcuGoXHg@mail.gmail.com>
References: <1386672625-8060-1-git-send-email-andre.przywara@linaro.org>
 <20131212022822.GI2871@cbox>
 <CAFEAcA_F3T1+YsKKq3h8P139OX085N-PPPPZo5dvwgwcuGoXHg@mail.gmail.com>
Message-ID: <52A982BB.4030901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 10:23 AM, Peter Maydell wrote:
> On 12 December 2013 02:28, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index a30035d..9565e6a 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -1889,9 +1889,12 @@ value in the kvm_regs structure seen as a 32bit array.
>>   arm64 CCSIDR registers are demultiplexed by CSSELR value:
>>     0x6020 0000 0011 00 <csselr:8>
>>
>> -arm64 system registers have the following id bit patterns:
>> +arm64 64-bit system registers have the following id bit patterns:
>>     0x6030 0000 0013 <op0:2> <op1:3> <crn:4> <crm:4> <op2:3>
>>
>> +arm64 32-bit system registers have the following id bit patterns:
>> +  0x6020 0000 0013 <op0:2> <op1:3> <crn:4> <crm:4> <op2:3>
>
> What does it mean to say that a system register for AArch64
> is "32 bits" given that MRS/MSR always operate on a 64 bit
> register? We have the distinction in AArch32 because the
> instructions (and whether the input/output is in one register
> or a register pair) are different, but I can't see the need for
> AArch64.

But ARMv8 ARM still defines these registers as 32-bit:
D8.5.14: CNTV_CTL_EL0
Attributes
            CNTV_CTL_EL0 is a 32-bit register.
But indeed the MSR/MRS instruction references a Xt register, and the 
documentation does not seem to tell how this is handled, so I assume 
this is zero-extended.
Would be great to have this clarified, though.

Regards,
Andre.


>
> (The code I've just written for QEMU to handle sysregs says
> "they're all 64 bit"...)
>
> thanks
> -- PMM
>

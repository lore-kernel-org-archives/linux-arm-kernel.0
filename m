From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 05 Jun 2013 23:11:46 +0200
Subject: [PATCH] ARM/KVM: save and restore generic timer registers
In-Reply-To: <20130605192316.GB9640@ubuntu>
References: <1370039952-20888-1-git-send-email-andre.przywara@linaro.org>
 <20130605192316.GB9640@ubuntu>
Message-ID: <51AFA992.4060803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 09:23 PM, Christoffer Dall wrote:
> On Sat, Jun 01, 2013 at 12:39:12AM +0200, Andre Przywara wrote:
>> For migration to work we need to save (and later restore) the state of
>> each cores virtual generic timer.
>> Since this is per VCPU, we can use the [gs]et_one_reg ioctl and just
>> need to add the three registers (control, counter, compare value) to
>> the list of saved registers. However we provide special accessor
>> functions to get the value of each register, since the content can
>> change anytime.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>> ---
>>   arch/arm/include/asm/kvm_asm.h  |  7 ++++++-
>>   arch/arm/include/asm/kvm_host.h |  3 +++
>>   arch/arm/include/uapi/asm/kvm.h | 16 ++++++++++++++++
>>   arch/arm/kvm/arch_timer.c       | 32 ++++++++++++++++++++++++++++++++
>>   arch/arm/kvm/coproc.c           | 30 ++++++++++++++++++++++++++++++
>>   5 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
>> index 18d5032..a732b17 100644
>> --- a/arch/arm/include/asm/kvm_asm.h
>> +++ b/arch/arm/include/asm/kvm_asm.h
>> @@ -46,7 +46,12 @@
>>   #define c13_TID_URO	24	/* Thread ID, User R/O */
>>   #define c13_TID_PRIV	25	/* Thread ID, Privileged */
>>   #define c14_CNTKCTL	26	/* Timer Control Register (PL1) */
>> -#define NR_CP15_REGS	27	/* Number of regs (incl. invalid) */
>> +#define c14_CNTV_CTL	27	/* Virtual Timer Control Register */
>> +#define c14_CNTVCT	28	/* Virtual Timer Counter Register */
>> +#define c14_CNTVCT_high	29	/* Virtual Timer Counter Register */
>> +#define c14_CNTV_CVAL	30	/* Virtual Timer Counter Register */
>> +#define c14_CNTV_CVAL_high	31	/* Virtual Timer Counter Register */
>> +#define NR_CP15_REGS	32	/* Number of regs (incl. invalid) */
>
> To avoid the extra storage overhead here I suggest you just export the
> registers using a separate number space for the ONE_REG ioctl instead of
> piggybacking on the cp15 exports.

Believe it or not, that was my first approach ;-)
I sent it out to Peter and Marc sometimes ago, they disliked it because 
the timer lives in cp15 space and they didn't see enough justification 
to create an extra coproc for this. So I went ahead and changed it...

I will forward you the thread for your reference.

However I have no issues in going back to that old version (or a 
slightly improved one).

Regards,
Andre.

> The main rationale being that the cp15 registers are optional to the
> architecture, which fits nicely with having the extra struct (which is a
> kconfig option) included in the vcpu struct.
>
> The implementation is basically going to be the same, you just need to
> add specific handling for that number space, I recommend you use
> "coprocessor number 17" for this, so your pattern would look something
> like (note added benefit of direct 64 bit support):
>
> 0x4020 0000 0013 <32 bit reg_id, indexed from 0:16>
> 0x4030 0000 0013 <64 bit reg_id, indexed from 0:16>
>
snip

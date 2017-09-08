From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 8 Sep 2017 17:21:52 +0100
Subject: [PATCH v11 5/6] target-arm: kvm64: handle SIGBUS signal for
 synchronous External Abort
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015F5F11@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015F5F11@DGGEMA503-MBX.china.huawei.com>
Message-ID: <CAFEAcA8HPhHeeXEDtxnewJ7mAJ-gYzR96pC06qA+Xx95LHu2DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2017 at 17:17, gengdongjiu <gengdongjiu@huawei.com> wrote:
>>
>> This code has all just been copied-and-pasted from target/i386/kvm.c.
>> Please instead abstract it out properly into a cpu-independent source file.
>
>
> Yes, it copied from x86.
> Do you mean abstracting this code to a common folder so that i386 and arm platform share it?

I mean it should go into a common source file (perhaps
accel/kvm/kvm-all.c).


>> What is this ??? You should never need to look up things in the cpreg arrays by fieldoffset.
>
>
> I used it to set the esr_el1's and far_el1's value, for example:
>
>   /* set ESR_EL1 */
>   ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.esr_el[1]));
>
>   /* set FAR_EL1 */
>   ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.far_el[1]));

Yes, I saw that, but I have no idea why you think that's
the right way to set register values. No other code in
QEMU does this.

> So use the added API kvm_arm_cpreg_value() to set their value.
> If not used it, do you better method to set their value?

I suggest:

>> The code for handling debug exits (software step, watchpoint,
>> etc) is probably a good place to look for how to deal with register state.

>> Any new globally-visible function prototype in a header should
>> have a doc-comment formatted documentation comment, please.
>
>
> Ok, thanks for this reminder. Do you mean I need to add comments
> for this globally-visible function, such as below:
>
> /*
>  * xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>  */
> void kvm_hwpoison_page_add(ram_addr_t ram_addr);

It should be in the doc-comment format, which begins
"/**" and has some stylization of how you list parameters
and so on. Lots of examples in the existing headers.

thanks
-- PMM

From: long.wanglong@huawei.com (long.wanglong)
Date: Thu, 4 Sep 2014 09:13:18 +0800
Subject: [SMP BUG?] the return value of is_smp() is bug?
In-Reply-To: <25226905.0IHWyHSRxb@wuerfel>
References: <1409550563-92081-1-git-send-email-long.wanglong@huawei.com>
 <540443DA.7030502@huawei.com> <25226905.0IHWyHSRxb@wuerfel>
Message-ID: <5407BCAE.7030606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/1 18:26, Arnd Bergmann wrote:
> On Monday 01 September 2014 18:00:58 long.wanglong wrote:
>> On 2014/9/1 13:49, Wang Long wrote:
>>>
>>> Hi,all
>>>
>>> In kernel 3.17-rc2, when i set CONFIG_HAVE_SMP = y and CONFIG_SMP_ON_UP = y 
>>> in .config file. the secondary core can not boot.
>>>
>>> when i set CONFIG_HAVE_SMP = y and CONFIG_SMP_ON_UP = n in .config file,
>>> the secondary core can boot.
>>>
>>> But this does not happen in kernel 3.10 lts kernel, Whether the 
>>> CONFIG_SMP_ON_UP is set yes or no ,the secondary core can boot.
>>>
>>> Does the meaning of CONFIG_SMP_ON_UP changed or this is a bug in kernel 3.17-rc2 ? 
>>>
>>>
>>
>> hi Arnd
>>
>> In above two cases, i also set  CONFIG_SMP = y. in addtion,
>> the CONFIG_SMP_ON_UP depends on CONFIG_SMP. when set
>> CONFIG_SMP_ON_UP = y, the value of CONFIG_SMP must be y.
> 
> I see.
> 
> I'm looking at the code more closely now:
> 
>>> config:     set CONFIG_HAVE_SMP = y and CONFIG_SMP_ON_UP = y
>>> command:    # qemu-system-arm -M vexpress-a9 -smp 2  -m 128M -kernel arch/arm/boot/zImage -nographic
>>> The output:
>>>
>>> ..........
>>> is_smp() return false;
> 
> This test basically checks whether the __fixup_smp_on_up code was
> run or not. This has changed in bc41b8724f24 "ARM: 7846/1: Update
> SMP_ON_UP code to detect A9MPCore with 1 CPU devices", in order
> to support a quirk in the Aegis platform. Can you try reverting
> that commit?
> 
> 	Arnd
> 
> .
> 


Hi Arnd

When i revert the commit bc41b8724f24, the secondary core can boot.
The problem is that qemu doesn't provide emulation of the SCU base
address register. When reading the SCU base, qemu just return 0.

In the real hardware, there is no this problem.

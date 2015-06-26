From: vitalya@ti.com (Vitaly Andrianov)
Date: Fri, 26 Jun 2015 08:20:15 -0400
Subject: [PATCH v2 0/3] ARM: keystone: add ecc error interrupt handling
In-Reply-To: <558C7437.2090306@codeaurora.org>
References: <1435242710-31346-1-git-send-email-vitalya@ti.com>
 <558C188B.5060107@oracle.com> <558C6C4F.1090102@codeaurora.org>
 <558C72EB.8010502@oracle.com> <558C7437.2090306@codeaurora.org>
Message-ID: <558D437F.30705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2015 05:35 PM, Stephen Boyd wrote:
> On 06/25/2015 02:30 PM, santosh shilimkar wrote:
>> On 6/25/2015 2:02 PM, Stephen Boyd wrote:
>>> On 06/25/2015 08:04 AM, santosh shilimkar wrote:
>>>> On 6/25/2015 7:31 AM, Vitaly Andrianov wrote:
>>>>> This patch series adds support for arm L1/L2 ecc and ddr3 ecc error
>>>>> handling
>>>>> for Keystone devices
>>>>>
>>>>> Change Log
>>>>>
>>>>> v2:
>>>>> - removing unused and sorting headers of keystone.c are moved to a
>>>>> separate
>>>>>      patch.
>>>>> - l1l2 ecc and ddr3 ecc error handling are split it to separate
>>>>> patches
>>>>> - removed unused headers from keystone_ecc.c
>>>>> - platsmp.c removed from the patch.
>>>>> - return IRQ_HANDLED for 1 bit error in l1l2 ecc handler
>>>>> - checked and handled existing echttps://lwn.net/Articles/593336/c
>>>>> error before enabling ddr3 interrupt
>>>>> - 1 bit ddr3 interrupt is disabled, because it is handled by hardware
>>>>> and
>>>>>      there is no reason to handle it by software
>>>>>
>>>> This version looks good to me. As already commented, I would have liked
>>>> the patch 2/3(L2 ECC) code in ARM generic code so will give some more
>>>> time for others to come back. Otherwise I will queue this up for next
>>>> window.
>>>
>>> Why not make this into an edac driver? I sent out an L1/L2 error
>>> detection edac driver for Krait processors a year ago, but it stalled
>>> due to some DT binding stuff[1]. This looks fairly similar.
>>>
>> Indeed the error detection part is very similar(expected as well
>> considering the same processor L2 regs). I am not sure we need
>> full driver only for that but at least the IRQ error handler
>> related code can reside together. Lets see what RMK thinks
>> on this.
>>
>
> There's an existing one for highbank (drivers/edac/highbank_l2_edac.c)
> and there was a patch set for the pl310 as well[1]. I don't think we
> want any architecture specific code for this, just use the EDAC framework.
>
> [1] https://lkml.org/lkml/2014/3/2/87
>

Before porting that patch I was looking to implementation of the EDAC 
for L2 cache and tried to use the framework. Sorry, but I couldn't 
understand why would the Keystone platform may need it. Most likely 
because I didn't understand the framework itself :(

In order the Keystone ECC works u-boot has to initialize the entire DDR3 
and enable ECC. When kernel boots up it has to install the ECC interrupt 
handlers for Cortex-A15 L1/L2 ECC and Keystone2 DDR3 ECC. As far as 
1-bit errors handled and corrected by hardware the software even doesn't 
need to handle those errors. We need to handle 2-bit errors and just 
reboot the board.

As the ECC detection has to be enable on kernel boot time and cannot be 
disabled there is not sense to make it in a module.

So, shall Keystone use the EDAC framework to install the onetime working 
interrupt handler? What are advantages to use the framework?

I appreciate your opinion.

Thanks,
Vitaly

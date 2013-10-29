From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 28 Oct 2013 22:09:52 -0700
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <526E2A7E.50108@ti.com>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
 <20131028004736.GG16735@n2100.arm.linux.org.uk>
 <20131028084455.GA20218@mudshark.cambridge.arm.com>
 <20131028085328.GI16735@n2100.arm.linux.org.uk>
 <526E2A7E.50108@ti.com>
Message-ID: <CAA3XUr1rW5q4=-eAXSaZ4xP75Cmt98-j=aAggreB4wgjt_YThg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

Another problem with f52bb72 commit is missing .align at
the end of __fixup_a_pv_table function. In case of thumb2
kernel address at label 3 could be 2 bytes aligned and
cause unaligned access exception.

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 2b3e981..8b03c2c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -662,6 +662,7 @@ ARM_BE8(rev ip, ip)
 #endif
 ENDPROC(__fixup_a_pv_table)

+       .align
 3:     .long __pv_offset

 ENTRY(fixup_pv_table)

It may work now because it is accidentally 4 bytes aligned
but it could change as code evolves. This happened to
me while I tried to work out how to deal with this code
in BE case (I am still working on that).

Thanks,
Victor


On 28 October 2013 02:12, Sricharan R <r.sricharan@ti.com> wrote:
> Hi,
> On Monday 28 October 2013 02:23 PM, Russell King - ARM Linux wrote:
>> On Mon, Oct 28, 2013 at 08:44:55AM +0000, Will Deacon wrote:
>>> Hi Russell,
>>>
>>> On Mon, Oct 28, 2013 at 12:47:36AM +0000, Russell King - ARM Linux wrote:
>>>> On Sat, Oct 19, 2013 at 08:51:35PM +0100, Ben Dooks wrote:
>>>>> On 19/10/13 18:09, Will Deacon wrote:
>>>>>> Do you think you could send another pull request please?
>>>>> Ok, sorted.
>>>> Pulled, but there was a conflict.  Please check this resolution (it's
>>>> copy'n'pasted).  I'll probably be in linux-next tomorrow in any case,
>>>> but any mistake here can be fixed.
>>> This doesn't look quite right to me, but unfortunately I'm going be spending
>>> most (all?) of today trying to catch a flight out of the UK. Hopefully Dave
>>> or Ben can investigate further, but comments below.
>>>
>>>> diff --cc arch/arm/kernel/head.S
>>>> index 54547947a4e9,a047acfa6b6d..000000000000
>>>> --- a/arch/arm/kernel/head.S
>>>> +++ b/arch/arm/kernel/head.S
>>>> @@@ -602,28 -586,26 +606,39 @@@ __fixup_a_pv_table
>>>>         b       2f
>>>>   1:    add     r7, r3
>>>>         ldrh    ip, [r7, #2]
>>>> + ARM_BE8(rev16 ip, ip)
>>>>  -      and     ip, 0x8f00
>>>>  -      orr     ip, r6  @ mask in offset bits 31-24
>>>>  +      tst     ip, #0x4000
>>>>  +      and     ip, #0x8f00
>>>>  +      orrne   ip, r6  @ mask in offset bits 31-24
>>>>  +      orreq   ip, r0  @ mask in offset bits 7-0
>>>> + ARM_BE8(rev16 ip, ip)
>>>>         strh    ip, [r7, #2]
>>>>  +      ldrheq  ip, [r7]
>>>>  +      biceq   ip, #0x20
>>>>  +      orreq   ip, ip, r0, lsr #16
>>>>  +      strheq  ip, [r7]
>>> There are new halfword accesses here without any conditional revs.
>> Yes, I missed this one.
>>
>>>> + #ifdef CONFIG_CPU_ENDIAN_BE8
>>>> +       @ in BE8, we load data in BE, but instructions still in LE
>>>> +       bic     ip, ip, #0xff000000
>>>>  -      orr     ip, ip, r6, lsl#24
>>>> ++      tst     ip, #0x000f0000 @ check the rotation field
>>> Since that orr with shift has been removed, I think the masks for the BE
>>> case are now incorrect...
>>>
>>>> ++      orrne   ip, ip, r6, lsl #24 @ mask in offset bits 31-24
>>>> ++      biceq   ip, ip, #0x00004000 @ clear bit 22
>>>> ++      orreq   ip, ip, r0, lsl #24 @ mask in offset bits 7-0
>> Actually, look closer.  It became the orrne here.
>>
>>>> + #else
>>>>         bic     ip, ip, #0x000000ff
>>>>  -      orr     ip, ip, r6      @ mask in offset bits 31-24
>>>>  +      tst     ip, #0xf00      @ check the rotation field
>>>>  +      orrne   ip, ip, r6      @ mask in offset bits 31-24
>>>>  +      biceq   ip, ip, #0x400000       @ clear bit 22
>>> ...which seems to be confirmed by the updated LE code (everything is off
>>> by a byte).
>> The LE code was left unaltered from Santosh's patch, so that should be
>> correct.  I just did an endian conversion to the BE case.
>>
>>> Somebody should probably sit down with the conflicting patch and port the BE
>>> changes over. I think the relevant patch is "ARM: mm: Correct virt_to_phys
>>> patching for 64 bit physical addresses". In fact, looking at *that* patch,
>>> it's *also* broken for BE! It adds the following to head.S:
>>>
>>> +#ifdef __ARMEB_
>>> +#define LOW_OFFSET     0x4
>>> +#define HIGH_OFFSET    0x0
>>> +#else
>>> +#define LOW_OFFSET     0x0
>>> +#define HIGH_OFFSET    0x4
>>> +#endif
>>>
>>> (spot the missing underscore).
>> Yep, well spotted.
>>
>> Well, we have some time to get this all fixed, so I'm going to drop
>> Ben's tree.  I think we need to first commit a patch to fix the error
>> in Santosh's patch.
> Sorry, I will send a patch fix this missing underscore bug.
>
> Regards,
>  Sricharan

From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 21 Nov 2018 12:43:05 +0000
Subject: [PATCH] ARM: V7M: align v7m_dma_inv_range() with v7 counterpart
In-Reply-To: <20181121120306.GE30658@n2100.armlinux.org.uk>
References: <1542630508-10325-1-git-send-email-vladimir.murzin@arm.com>
 <CABQ9BCV2tE7WVVPofxkUHxmPGM8NKwb5H6eS5mVcR92pAcwCLw@mail.gmail.com>
 <5b27b9b8-834e-4ced-92ac-627b04d7722a@arm.com>
 <20181121120306.GE30658@n2100.armlinux.org.uk>
Message-ID: <60156549-8084-6e21-8654-7d70fb428649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/18 12:03, Russell King - ARM Linux wrote:
> On Wed, Nov 21, 2018 at 11:30:05AM +0000, Vladimir Murzin wrote:
>> Hi Chris,
>>
>> On 20/11/18 18:45, Chris Cole wrote:
>>> Hi Vladimir,
>>>
>>> On Mon, Nov 19, 2018 at 4:28 AM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>>>
>>>> Chris has discovered and reported that v7_dma_inv_range() may corrupt
>>>> memory if address range is not aligned to cache line size.
>>>>
>>>> Since the whole cache-v7m.S was lifted form cache-v7.S the same
>>>> observation applies to v7m_dma_inv_range(). So the fix just mirrors
>>>> what has been done for v7 with a little specific of M-class.
>>>>
>>>> Cc: Chris Cole <chris@sageembedded.com>
>>>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>>> ---
>>>>  arch/arm/mm/cache-v7m.S | 13 ++++++++-----
>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
>>>> index 788486e8..1059d5e 100644
>>>> --- a/arch/arm/mm/cache-v7m.S
>>>> +++ b/arch/arm/mm/cache-v7m.S
>>>> @@ -73,9 +73,11 @@
>>>>  /*
>>>>   * dcimvac: Invalidate data cache line by MVA to PoC
>>>>   */
>>>> -.macro dcimvac, rt, tmp
>>>> -       v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC
>>>> +.irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
>>>> +.macro dcimvac\c, rt, tmp
>>>> +       v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC, \c
>>>>  .endm
>>>> +.endr
>>>>
>>>>  /*
>>>>   * dccmvau: Clean data cache line by MVA to PoU
>>>> @@ -369,14 +371,15 @@ v7m_dma_inv_range:
>>>>         tst     r0, r3
>>>>         bic     r0, r0, r3
>>>>         dccimvacne r0, r3
>>>> +       addne   r0, r0, r2
>>>>         subne   r3, r2, #1      @ restore r3, corrupted by v7m's dccimvac
>>>>         tst     r1, r3
>>>>         bic     r1, r1, r3
>>>>         dccimvacne r1, r3
>>>>  1:
>>>> -       dcimvac r0, r3
>>>> -       add     r0, r0, r2
>>>> -       cmp     r0, r1
>>>> +       dcimvaclo r0, r3
>>>> +       addlo   r0, r0, r2
>>>> +       cmplo   r0, r1
>>>>         blo     1b
>>>>         dsb     st
>>>>         ret     lr
>>>> --
>>>> 1.9.1
>>>>
>>>
>>> There needs to be "cmp r0, r1" added after "1:" label.
>>
>> Nice catch! I'll send update shortly.
> 
> No, actually, the cmp needs to be _before_ the label, as per the v7
> version.
> 

Yup, I also noticed that, so v2 already have cmp before the label.

Since you in thread, are you happy if both patches go into your
patch system?

Thanks
Vladimir

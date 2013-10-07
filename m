From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 7 Oct 2013 18:49:20 -0400
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for
 BE correct operation
In-Reply-To: <CAA3XUr2wYFL9WAQd9uAJSKK5KhWF3bPzYbh-3x=B3oLVXk79og@mail.gmail.com>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <5252DA06.8000303@codethink.co.uk>
 <CAA3XUr2wYFL9WAQd9uAJSKK5KhWF3bPzYbh-3x=B3oLVXk79og@mail.gmail.com>
Message-ID: <52533A70.5040705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Victor,

On Monday 07 October 2013 12:37 PM, Victor Kamensky wrote:
> On 7 October 2013 08:57, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> On 07/10/13 17:48, Victor Kamensky wrote:
>>>
>>> Hi Will, Ben, Russell, Thomas,
>>>
>>> Please review second version of patch that fixes TLB asid issue in big
>>> endian
>>> V7 image.
>>>
>>> Changes from v1:
>>>     Note previous patch subject line was 'ARM: tlb:
>>>     __flush_tlb_mm need to use int asid var for BE correct operation'
>>>
>>>     Added 'unsigned int' cast into ASID macro itself rather
>>>     then use intermediate 'int' variable in __flush_tlb_mm function.
>>>     This is done per v1 patch discussion at
>>>
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202583.html
>>>
>>> Tested with Linaro BE topic branch on Arndale board. Both LE and BE
>>> images were tested.
>>
>>
>> If you are booting on the Arndale board, is there a patch to mark
>> the relevant Exynos devices as BE capable?
> 
> Arndale need massive fixes in their BSP layer to be endian agnostic
> ARM V7 platform. Unfortunate it is not as simple as with few others
> that already marked as BE capable.
> 
> Please see
> https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=shortlog;h=refs/heads/llct-be-topic
> Mostly it is __raw_xxx conversion to xxx_relaxed, but there are
> more subtle changes (some of them similar to changs that you've
> done for other platforms). Also there are known unfixed issues like
> disabling CONFIG_MMC_DW_IDMAC config because idmac
> DMA related code is not endian agnostic yet (btw interesting class
> of BE related problem that was not seen before).
> 
> In Linaro we use Arndale and Pandaboard as reference platforms
> therefore we have BE BSP fixes in our tree. But I am not sure
> what is fate of those in long term. Also we consider these as
> example of BSP changes that other BSP need to do.
> 
> If Exynos and OMAP owners will have any interest for BE images,
> and would like to see these changes in main line, we gladly
> will work on this. Otherwise changes like this can mess up with
> BSP ongoing drivers development.
> 
BE support in mainline is definitely we are interested for OMAP
and rest of the TI SoCs.

> I think above position is consistent with similar discussion on
> some of BE related threads - changing BSP to support BE mode
> is BSP owners call.
> 
Am just wondering a better method than the patch [1] which touches
many drivers for readl/writel() replacement. Drivers are using
that as standard based on device driver guide and was thinking
we should not change that rule to support BE. We definitely need
to get the byte swap achieved but probably through some other
means. 

Regards,
Santosh
[1] https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=commit;h=9074a67ab082c62545683e5ec909368a23c33655

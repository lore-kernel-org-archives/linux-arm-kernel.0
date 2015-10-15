From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 14:14:22 +0100
Subject: [PATCHv3 03/11] arm64: Introduce helpers for page table levels
In-Reply-To: <20151015124451.GI8825@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
 <20151015113735.GB21930@cbox> <20151015124451.GI8825@leverpostej>
Message-ID: <561FA6AE.6090707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 13:44, Mark Rutland wrote:
> On Thu, Oct 15, 2015 at 01:37:35PM +0200, Christoffer Dall wrote:
>> On Wed, Oct 14, 2015 at 12:20:26PM +0100, Suzuki K. Poulose wrote:
>>> Introduce helpers for finding the number of page table
>>> levels required for a given VA width, shift for a particular
>>> page table level.

>>> +/*
>>> + * Size mapped by an entry at level n
>>> + * We map PAGE_SHIFT - 3 at all levels, except the PAGE_SHIFT bits at the last level
>>> + */
>>> +#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
>>
>> I feel like I'm partially failing the interview question again, in that
>> I don't fully understand the '+ 3' in the end?
>
> The last level handles PAGE_SHIFT bits (the bits from the VA that are
> the same in the PA). We only accounted for (PAGE_SHIFT - 3) bits at each
> level when multiplying, so we add those 3 missing bits back at the end.
>

Something like :

/*
  * Size mapped by an entry at level n
  * We map PAGE_SHIFT - 3 at all levels, except the last, where we map PAGE_SHIFT bits.
  * The maximum number of levels supported by the architecture is 4. Hence at starting
  * at level n, we hanve (4 - n) levels of translation. So, the total number of bits
  * mapped by an entry at level n is :
  *
  *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
  *
  * Rearranging it a bit we get :
  *   (4 - n) * (PAGE_SHIFT - 3) + 3
  */

Or we could use the formula without rearranging.

Thanks
Suzuki

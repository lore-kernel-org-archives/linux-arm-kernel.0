From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 27 Mar 2017 16:18:14 +0100
Subject: [PATCH] kvm: arm/arm64: Rework gpa callback handlers
In-Reply-To: <20170324180002.GJ25903@cbox>
References: <1490034402-28850-1-git-send-email-suzuki.poulose@arm.com>
 <20170324180002.GJ25903@cbox>
Message-ID: <d4f1c780-a8ee-fd87-304e-92f67049f92f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/17 18:00, Christoffer Dall wrote:
> On Mon, Mar 20, 2017 at 06:26:42PM +0000, Suzuki K Poulose wrote:
>> In order to perform an operation on a gpa range, the hyp iterates
>
> the hyp ?

To be precise "the host" ?

>
>> over each page in a user memory slot for the given range. This is
>> inefficient while dealing with a big range (e.g, a VMA), especially
>> while unmaping a range. At present, with stage2 unmap on a range with
>> a hugepage backed region, we clear the PMD when we unmap the first
>> page in the loop. The remaining iterations simply traverse the page table
>> down to the PMD level only to see that nothing is in there.
>>
>> This patch reworks the code to invoke the callback handlers on the
>> biggest range possible within the memory slot to avoid reduce the
>> number of iterations.
>
> avoid reduce?
>
> did you mean "to reduce the number of times the handler is called" ?

Yep, thanks for spotting.

>
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  arch/arm/kvm/mmu.c | 31 +++++++++++++------------------
>>  1 file changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 37e67f5..8357fed 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
...

>>
>
> Otherwise looks good:
>
> I can fix up the commit message when applying this.
>
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Thanks

Suzuki

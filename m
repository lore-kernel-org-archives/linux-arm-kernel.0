From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 01 Feb 2013 11:43:23 +0000
Subject: [PATCHv5 15/16] ARM: hyp: initialize CNTVOFF to zero
In-Reply-To: <20130201111350.GA1970@linaro.org>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-16-git-send-email-mark.rutland@arm.com>
 <20130201111350.GA1970@linaro.org>
Message-ID: <510BAA5B.2060704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 01/02/13 11:13, Dave Martin wrote:
> On Thu, Jan 31, 2013 at 12:15:38PM +0000, Mark Rutland wrote:
>> From: Marc Zyngier <Marc.Zyngier@arm.com>
>>
>> In order to be able to use the virtual counter in a safe way,
>> make sure it is initialized to zero before dropping to SVC.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Dave Martin <dave.martin@arm.com>
>> ---
>>  arch/arm/kernel/hyp-stub.S | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>> index 65b2417..455603a 100644
>> --- a/arch/arm/kernel/hyp-stub.S
>> +++ b/arch/arm/kernel/hyp-stub.S
>> @@ -152,6 +152,9 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
>>  	mrc	p15, 4, r7, c14, c1, 0	@ CNTHCTL
>>  	orr	r7, r7, #3		@ PL1PCEN | PL1PCTEN
>>  	mcr	p15, 4, r7, c14, c1, 0	@ CNTHCTL
>> +	mov	r6, #0
>> +	mov	r7, #0
>> +	mcrr	p15, 4, r6, r7, c14	@ CNTVOFF
> 
> Is this required for safety, or is it more a sanity feature?
> 
> The architected timer counters are supposed to be monotonic time sources
> only, so applying a random offset shouldn't really change anything.
> 
> The main thing I can think of is that it is easier for the host to
> manage guests' virtual counter offsets if the host's offset is 0 (and
> we don't really want to be changing the host offset after the host kernel
> boots).

As you noticed, the offset itself doesn't matter as long as it is
constant. However, setting it to zero makes it nicer to the hypervisor:
no need to remember the host offset, just reset it to zero when exiting
a guest.

	M.
-- 
Jazz is not dead. It just smells funny...

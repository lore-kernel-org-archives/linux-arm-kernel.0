From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 14:00:34 +0000
Subject: [PATCH 1/8] arm64: KVM: Switch the sys_reg search to be a binary
 search
In-Reply-To: <87ziv8vfol.fsf@linaro.org>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-2-git-send-email-marc.zyngier@arm.com>
 <87ziv8vfol.fsf@linaro.org>
Message-ID: <56BB4282.6040005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/16 13:49, Alex Benn?e wrote:
> 
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
>> Our 64bit sys_reg table is about 90 entries long (so far, and the
>> PMU support is likely to increase this). This means that on average,
>> it takes 45 comparaisons to find the right entry (and actually the
>> full 90 if we have to search the invariant table).
>>
>> Not the most efficient thing. Specially when you think that this
>> table is already sorted. Switching to a binary search effectively
>> reduces the search to about 7 comparaisons. Slightly better!
> 
> Is there an argument for making this a hash table instead or is this not
> possible as you would have to use dynamically allocated instead?

I believe it would be possible, assuming we have the right hash. Another
alternative would be a radix tree, which would always give us the right
sysreg in four memory accesses. It has some impacts on the memory side,
but that's shouldn't a blocker.

As I said, the binary search was a very low hanging fruit, so it made
some sense to implement it and see how we fared. Finding the perfect
data structure is left as an exercise for the reader! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

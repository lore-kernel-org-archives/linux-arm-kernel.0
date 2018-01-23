From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Jan 2018 14:38:22 +0000
Subject: [PATCH v2 3/6] arm: KVM: Invalidate BTB on guest exit
In-Reply-To: <20180123142217.GK21802@cbox>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-4-marc.zyngier@arm.com> <20180123142217.GK21802@cbox>
Message-ID: <98145da8-d172-7d80-5125-a150860d517a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/18 14:22, Christoffer Dall wrote:
> On Mon, Jan 08, 2018 at 06:55:30PM +0000, Marc Zyngier wrote:
>> In order to avoid aliasing attacks against the branch predictor,
>> let's invalidate the BTB on guest exit. This is made complicated
>> by the fact that we cannot take a branch before invalidating the
>> BTB.
> 
> ...because that would defeat the overall purpose of what we're trying to
> do?

Indeed. Even direct branches could potentially be unsafe, so branching
at that stage is not a good idea.

> 
>>
>> Another thing is that we perform the invalidation on all
>> implementations, no matter if they are affected or not.
> 
> I don't understand this comment, it seems like the logic below is
> limited to A12 and A17 for now?

Ah, that's a leftover from the first version (before I discovered that
A15 needed a different method). I'll amend that when I repost the patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

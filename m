From: zhongjiang@huawei.com (zhong jiang)
Date: Sat, 16 Jan 2016 22:26:43 +0800
Subject: [patch 112/178] arm64: fix add kasan bug
In-Reply-To: <20160115103527.GC21998@e104818-lin.cambridge.arm.com>
References: <56982daf.v++3ELUdiwhIHn5Z%akpm@linux-foundation.org>
 <CAPAsAGxqdm_ftXMebmg_R89ZScaaFzRuqRGV=eeKMrDLtn3DvA@mail.gmail.com>
 <20160115103527.GC21998@e104818-lin.cambridge.arm.com>
Message-ID: <569A5323.6090007@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/15 18:35, Catalin Marinas wrote:
> On Fri, Jan 15, 2016 at 10:39:04AM +0300, Andrey Ryabinin wrote:
>> 2016-01-15 2:22 GMT+03:00  <akpm@linux-foundation.org>:
>>> From: zhong jiang <zhongjiang@huawei.com>
>>> Subject: arm64: fix add kasan bug
>>>
>>> In general, each process have 16kb stack space to use, but stack need
>>> extra space to store red_zone when kasan enable.  the patch fix above
>>> question.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Xishi Qiu <qiuxishi@huawei.com>
>>> Cc: Wang Long <long.wanglong@huawei.com>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>
>>>  arch/arm64/include/asm/thread_info.h |   15 +++++++++++++--
>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> This has been nacked by Catalin:
>> http://lkml.kernel.org/g/<20160108182744.GQ16432@e104818-lin.cambridge.arm.com>
> 
> As above, the patch doesn't make much sense for 4.5 where we have
> separate IRQ stacks. Arguably, it could be included in 4.4 *if* there
> was a regression but the patch author failed to reply.
> 
> Thanks.
> 

I'm so sorry that I don't respond to this email in time, Because I thought
it has been recognized without any discussion. and I am busy with other
things during the time. at present, I have looked at all of the discussion,
and I have some words want to say.

when kasan enables, compiler need to insert an additional 32-byte redzon to
a local variable in the front and behind. as a result, The actual usable stack
space is less than half of the total. The main purpose of this patch is whether
kasan enable or not, the actual usable stack space always satisfied the demand
to avoid the risk of the stack overflow.

Thanks
zhongjiang

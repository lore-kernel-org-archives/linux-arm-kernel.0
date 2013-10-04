From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 05 Oct 2013 07:55:18 +0800
Subject: [PATCH 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for normal register variables within atomic.h
In-Reply-To: <20131004154208.GS24303@mudshark.cambridge.arm.com>
References: <20130930161149.GI26036@mudshark.cambridge.arm.com>
 <524A2DE7.8040208@asianux.com>
 <20131001090119.GA17629@mudshark.cambridge.arm.com>
 <524ABA20.6060106@asianux.com>
 <20131002104158.GD28311@mudshark.cambridge.arm.com>
 <524C3981.20307@asianux.com> <524D416B.5090709@asianux.com>
 <20131003163200.GE7408@mudshark.cambridge.arm.com>
 <524E8FBC.2080200@asianux.com>
 <20131004153742.GR24303@mudshark.cambridge.arm.com>
 <20131004154208.GS24303@mudshark.cambridge.arm.com>
Message-ID: <524F5566.4010204@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 11:42 PM, Will Deacon wrote:
> On Fri, Oct 04, 2013 at 04:37:42PM +0100, Will Deacon wrote:
>> On Fri, Oct 04, 2013 at 10:51:56AM +0100, Chen Gang wrote:
>>> On 10/04/2013 12:32 AM, Will Deacon wrote:
>>>> The problem with arm64 is that we're using *unsigned long* for 32-bit
>>>> clear_mask, which is definitely wrong because it's 64-bit (another patch to
>>>> fix this!).
>>>>
>>>
>>> At least, that is not a bug.
>>
>> Sure it is. What if the adjacent 32-bit value was being accessed by another
>> CPU under a spinlock?
> 
> (Oh, ok, that would still work on arm because of the way the exclusive
> monitor is implemented, but we shouldn't rely on that).
>

Hmm... in my opinion, we need divide atomic_*_mask() into 32-bit and
64-bit versions. We already have demands to only use 32-bit value to
express mask (can save size), and may have demands to use 64-bit too.

If so, can easily standard all atomic_*_mask() which are in asm-generic
and various architectures: use atomic_*_mask() for 32-bit mask, and use
atomic64_*_mask() for 64-bit mask (can delayed before get real demands).

Since it is about API, so it is related with asm-generic and all other
architectures interfaces, it is better to consider about them firstly
before the fix under arm64.


And also, excuse me, I am not quite familiar with "exclusive monitor",
could you please provide more details about it?


> Will
> 
> 


Thanks.
-- 
Chen Gang

From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 27 Feb 2015 15:17:26 -0500
Subject: [RFC PATCH] arm64: cmpxchg.h: Bring ldxr and stxr closer
In-Reply-To: <20150227201526.GH24818@arm.com>
References: <1425067776-2794-1-git-send-email-bobby.prani@gmail.com>
 <20150227201526.GH24818@arm.com>
Message-ID: <CAJhHMCA0La6rQBndxJDnynAZ6AogEbKcCRQULZjjRTXBMzGuiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 3:15 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Feb 27, 2015 at 08:09:17PM +0000, Pranith Kumar wrote:
>> ARM64 documentation recommends keeping exclusive loads and stores as close as
>> possible. Any instructions which do not depend on the value loaded should be
>> moved outside.
>>
>> In the current implementation of cmpxchg(), there is a mov instruction which can
>> be pulled before the load exclusive instruction without any change in
>> functionality. This patch does that change.
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>  arch/arm64/include/asm/cmpxchg.h | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> [...]
>
>> @@ -166,11 +166,11 @@ static inline int __cmpxchg_double(volatile void *ptr1, volatile void *ptr2,
>>               VM_BUG_ON((unsigned long *)ptr2 - (unsigned long *)ptr1 != 1);
>>               do {
>>                       asm volatile("// __cmpxchg_double8\n"
>> +                     "       mov     %w0, #0\n"
>>                       "       ldxp    %0, %1, %2\n"
>
> Seriously, you might want to test this before you mindlessly make changes to
> low-level synchronisation code. Not only is the change completely unnecessary
> but it is actively harmful.
>

Oops, I apologize for this. I should have looked more closely. It is
wrong to do this in cmpxchg_double(). What about the other cases?


-- 
Pranith

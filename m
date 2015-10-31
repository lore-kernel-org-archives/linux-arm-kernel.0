From: icoolidge@google.com (Ian Coolidge)
Date: Sat, 31 Oct 2015 12:46:38 -0700
Subject: [PATCH] arm: spinlock: const qualify read-only functions.
In-Reply-To: <CAKv+Gu8ksbi=j=jhv2P=4dNHWY_6B+i5=LCbwrLv1TsJGNY9gA@mail.gmail.com>
References: <1446061495-38554-1-git-send-email-icoolidge@google.com>
 <1446164820-16144-1-git-send-email-icoolidge@google.com>
 <CAB3A_j9VhARfgybw-oQWVdZciSdc93i1fEL7tTdRHvdzUtQkog@mail.gmail.com>
 <CAKv+Gu8ksbi=j=jhv2P=4dNHWY_6B+i5=LCbwrLv1TsJGNY9gA@mail.gmail.com>
Message-ID: <CAB3A_j_AHrvp213D5sqSnXWvo12NWWCEpv3AEYxT0dNsWh_mog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

:) D'oh, yes, I had assumed you were the same person.

It is for a driver that I would eventually like to upstream.

I see that there are many cases where assert_spin_lock is used, but
perhaps driver developers are underutilizing const,
or compiling the kernel with warnings tolerated.



On Sat, Oct 31, 2015 at 11:34 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 31 October 2015 at 18:26, Ian Coolidge <icoolidge@google.com> wrote:
>> On Thu, Oct 29, 2015 at 5:27 PM, Ian Coolidge <icoolidge@google.com> wrote:
>>> This allows assert_spin_locked() to be used against
>>> spinlocks that are const qualified.
>>>
>>> For example:
>>>
>>> struct instance_t {
>>>         int data;
>>>         spinlock_t lock;
>>> };
>>>
>>> /*
>>>  * foo does not mutate instance.
>>>  * foo must be called while the lock is held.
>>>  */
>>> int foo(const instance_t *instance) {
>>>         assert_spin_locked(&instance->lock);
>>>
>>>         /* Code that assumes the lock is held */
>>>
>>>         return 0;
>>> }
>>>
>>> Signed-off-by: Ian Coolidge <icoolidge@google.com>
>>> ---
>>>  arch/arm/include/asm/spinlock.h | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
>>> index 0fa4184..274ceb1 100644
>>> --- a/arch/arm/include/asm/spinlock.h
>>> +++ b/arch/arm/include/asm/spinlock.h
>>> @@ -118,12 +118,12 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>>>         return lock.tickets.owner == lock.tickets.next;
>>>  }
>>>
>>> -static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>>> +static inline int arch_spin_is_locked(const arch_spinlock_t *lock)
>>>  {
>>>         return !arch_spin_value_unlocked(READ_ONCE(*lock));
>>>  }
>>>
>>> -static inline int arch_spin_is_contended(arch_spinlock_t *lock)
>>> +static inline int arch_spin_is_contended(const arch_spinlock_t *lock)
>>>  {
>>>         struct __raw_tickets tickets = READ_ONCE(lock->tickets);
>>>         return (tickets.next - tickets.owner) > 1;
>>> --
>>> 2.6.0.rc2.230.g3dd15c0
>>>
>>
>> Arnd,
>>
>> Please see this patch for an updated version. I should have noted it
>> is PATCH v2 and replied to the old thread, sorry about that.
>> Anyways, I provided an example of a const spinlock. Here, in that
>> example, the spinlock is not const itself, but it is part of a
>> structure that may be const.
>> I believe the example is a good one.
>>
>> Also, with regards to your feedback, I don't think the length of the
>> function body is a good argument against promising not to mutate it.
>>
>
> Hi,
>
> Note that Ard (me) and Arnd are two different persons.
>
> I think your patch makes sense in itself, I just wonder if there are
> any real examples in the current codebase that would require it. Which
> struct is it that you are looking to constify, and in which context?
>
> Regards,
> Ard.

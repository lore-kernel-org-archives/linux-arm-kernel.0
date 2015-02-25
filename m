From: bobby.prani@gmail.com (Pranith Kumar)
Date: Wed, 25 Feb 2015 12:29:11 -0500
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <16818946.F4B9s6bbtr@wuerfel>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel>
 <CAJhHMCCoFhi2a=qtO3EkX_Y-iy0C=STUt0ULtXMAyGEZJR_Vtw@mail.gmail.com>
 <16818946.F4B9s6bbtr@wuerfel>
Message-ID: <CAJhHMCBw8gOXu=RDOE0WFUU-pcW4PGeiudq0BcE8=YKy6JAd5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 11:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> More information:
>> [   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
>> [   45.833324] ------------[ cut here ]------------
>> [   45.837939] kernel BUG at
>> /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
>> [   45.846450] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>> [   45.852275] Modules linked in: test(O+) nvhost_vi
>> [   45.857012] CPU: 0 PID: 1848 Comm: insmod Tainted: G           O
>> 3.10.24-g6a2d13a #1
>> [   45.864744] task: ee406580 ti: eb18c000 task.ti: eb18c000
>> [   45.870141] PC is at __bad_xchg+0x24/0x28
>> [   45.874146] LR is at __bad_xchg+0x24/0x28
>
> I'm more interested in the backtrace here, it's possible we should fix the
> driver instead.

I should have been more clearer. I apologize. This is in a test module
I wrote trying out the various synchronization primitives. This is not
a problem in any current driver I am using.

>
>> >>  arch/arm/include/asm/cmpxchg.h | 18 +++++++++++++++++-
>> >>  1 file changed, 17 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
>> >> index abb2c37..9505cca 100644
>> >> --- a/arch/arm/include/asm/cmpxchg.h
>> >> +++ b/arch/arm/include/asm/cmpxchg.h
>> >> @@ -50,6 +50,16 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>> >>                       : "r" (x), "r" (ptr)
>> >>                       : "memory", "cc");
>> >>               break;
>> >> +     case 2:
>> >> +             asm volatile("@ __xchg2\n"
>> >> +             "1:     ldrexh  %0, [%3]\n"
>> >> +             "       strexh  %1, %2, [%3]\n"
>> >> +             "       teq     %1, #0\n"
>> >> +             "       bne     1b"
>> >> +                     : "=&r" (ret), "=&r" (tmp)
>> >> +                     : "r" (x), "r" (ptr)
>> >> +                     : "memory", "cc");
>> >> +             break;
>> >>       case 4:
>> >>               asm volatile("@ __xchg4\n"
>> >>               "1:     ldrex   %0, [%3]\n"
>> >
>> > Does this work on all ARMv6 or just ARMv6k?
>> >
>>
>> ldrexh/strexh is being used in cmpxchg() in the same file in a similar
>> manner, and the comment there says that it works for all ARCH >=
>> ARMv6k, so not ARMv6 I guess.
>
> Ok, then you need to put the same check in __xchg too. I'm not sure
> about the 1-byte case here, because that is already used in ARMv6
> __xchg.
>

OK, I will update the patch with the check.

Looking closely I see what you are saying. In __xchg(), for the 1 byte
case we are using ldrexb/strexb while the test checks for version >=
6. Documentation online says that ldrex{h/b} are supported only for
ARMv6k or greater.

So I think the check in __xchg() should be changed to one similar in
cmpxchg(). Is that what you meant?

If so, i will send in an updated patch.

Thanks!
-- 
Pranith

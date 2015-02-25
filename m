From: bobby.prani@gmail.com (Pranith Kumar)
Date: Wed, 25 Feb 2015 11:11:28 -0500
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <3465519.0ga9zC7F7b@wuerfel>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel>
Message-ID: <CAJhHMCCoFhi2a=qtO3EkX_Y-iy0C=STUt0ULtXMAyGEZJR_Vtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 25 February 2015 10:36:20 Pranith Kumar wrote:
>> This patch adds support for a half-word xchg() for ARM using ldrexh/strexh
>> instructions. It also fixes an asm comment  for __cmpxchg2.
>>
>> Currently using a half-word xchg() results in the following splat on an ARMv7
>> machine.
>>
>> [   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
>> [   45.833324] ------------[ cut here ]------------
>> [   45.837939] kernel BUG at /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>
> Unfortunately, the BUG message seems incomplete, can you reproduce this
> with CONFIG_DEBUG_BUGVERBOSE enabled?

The bug here is in a module caused when xchg() was used on uint16_t
variable. It is caused by the __bad_xchg() for 2 byte swap.

More information:
[   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
[   45.833324] ------------[ cut here ]------------
[   45.837939] kernel BUG at
/dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
[   45.846450] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   45.852275] Modules linked in: test(O+) nvhost_vi
[   45.857012] CPU: 0 PID: 1848 Comm: insmod Tainted: G           O
3.10.24-g6a2d13a #1
[   45.864744] task: ee406580 ti: eb18c000 task.ti: eb18c000
[   45.870141] PC is at __bad_xchg+0x24/0x28
[   45.874146] LR is at __bad_xchg+0x24/0x28


>
>>  arch/arm/include/asm/cmpxchg.h | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
>> index abb2c37..9505cca 100644
>> --- a/arch/arm/include/asm/cmpxchg.h
>> +++ b/arch/arm/include/asm/cmpxchg.h
>> @@ -50,6 +50,16 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>>                       : "r" (x), "r" (ptr)
>>                       : "memory", "cc");
>>               break;
>> +     case 2:
>> +             asm volatile("@ __xchg2\n"
>> +             "1:     ldrexh  %0, [%3]\n"
>> +             "       strexh  %1, %2, [%3]\n"
>> +             "       teq     %1, #0\n"
>> +             "       bne     1b"
>> +                     : "=&r" (ret), "=&r" (tmp)
>> +                     : "r" (x), "r" (ptr)
>> +                     : "memory", "cc");
>> +             break;
>>       case 4:
>>               asm volatile("@ __xchg4\n"
>>               "1:     ldrex   %0, [%3]\n"
>
> Does this work on all ARMv6 or just ARMv6k?
>

ldrexh/strexh is being used in cmpxchg() in the same file in a similar
manner, and the comment there says that it works for all ARCH >=
ARMv6k, so not ARMv6 I guess.

-- 
Pranith

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Sep 2012 15:13:42 +0100
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
In-Reply-To: <201209281336.30728.arnd@arndb.de>
References: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
 <201209281336.30728.arnd@arndb.de>
Message-ID: <CAHkRjk684Qbbac4oxY2NpmExG8WKJT_XSXYfv5Tr9vn0+OkFwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 September 2012 14:36, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 27 September 2012, Russell King wrote:
>> +#ifndef __ARMBE__
>> +static inline void memset_io(volatile void __iomem *dst, unsigned c,
>> +       size_t count)
>> +{
>> +       memset((void __force *)dst, c, count);
>> +}
>> +#define memset_io(dst,c,count) memset_io(dst,c,count)
>> +
>> +static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
>> +       size_t count)
>> +{
>> +       memcpy(to, (const void __force *)from, count);
>> +}
>> +#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
>> +
>
> I wonder whether we need any barriers here. PowerPC has the strongest
> barriers befor eand after the access, at least since f007cacffc8870
> "[POWERPC] Fix MMIO ops to provide expected barrier behaviour".

In theory, we need barriers but only at the beginning and the end of
the operation, not for every iteration (and in practice we might even
be OK without any). The device accesses are ordered with each-other by
hardware, it's only when you need them to be ordered with other types
or memory accesses (or even other devices).

> arm64 actually copies the arm variant, and I suspect we can use the
> simpler version there as well.

For arm64 I have a set of optimised library functions which I left out
from the upstream branch just to make the review easier. I'll post the
patches and push them once the core code is upstream. But the memcpy()
implementation does not perform pointer alignment (it may at some
point, based on benchmarks), so not usable with I/O.

The simplest optimisation for arm64 (already suggested by Olof and on
my to-do list) is  something like the powerpc implementation but using
write*_relaxed() to avoid barriers in a loop. The performance of the
compiled code shouldn't be far from hand-written assembly, especially
on ARMv8 with more out of order execution.

-- 
Catalin

From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 17 Jun 2010 09:25:41 +0900
Subject: [PATCH 2/5] [ARM] add address randomization to mmap()
In-Reply-To: <alpine.LFD.2.00.1006161959580.13427@xanadu.home>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
	<1276720403-27918-3-git-send-email-nico@fluxnic.net>
	<AANLkTimXn525QZosUxSsd1SM2JUDxWTfBqHoM1kxz86_@mail.gmail.com>
	<alpine.LFD.2.00.1006161959580.13427@xanadu.home>
Message-ID: <AANLkTinVxE_fiq3_ZLInRTbNKeI-k-07v9x3l73UhWji@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 9:05 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 17 Jun 2010, Kyungmin Park wrote:
>
>> Hi,
>>
>> On Thu, Jun 17, 2010 at 5:33 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>> > ---
>> > ?arch/arm/mm/mmap.c | ? ?4 ++++
>> > ?1 files changed, 4 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
>> > index f5abc51..4f5b396 100644
>> > --- a/arch/arm/mm/mmap.c
>> > +++ b/arch/arm/mm/mmap.c
>> > @@ -7,6 +7,7 @@
>> > ?#include <linux/shm.h>
>> > ?#include <linux/sched.h>
>> > ?#include <linux/io.h>
>> > +#include <linux/random.h>
>> > ?#include <asm/cputype.h>
>> > ?#include <asm/system.h>
>> >
>> > @@ -80,6 +81,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
>> > ? ? ? ? ? ? ? ?start_addr = addr = TASK_UNMAPPED_BASE;
>> > ? ? ? ? ? ? ? ?mm->cached_hole_size = 0;
>> > ? ? ? ?}
>> > + ? ? ? /* 8 bits of randomness in 20 address space bits */
>> > + ? ? ? if (current->flags & PF_RANDOMIZE)
>> > + ? ? ? ? ? ? ? addr += (get_random_int() % (1 << 8)) << PAGE_SHIFT;
>>
>> Doesn't better to use mask operation?
>> ? ? ? ? ? ? ? ? ? ?addr += (get_random_int() & ((1 << 8) - 1)) << PAGE_SHIFT;
>
> GCC is smart enough to optimize the modulus into a mask, effectively
> generating the exact same assembly code in both cases.
>

Right, Good to know

  1c:   e0822003        add     r2, r2, r3
  20:   e20220ff        and     r2, r2, #255    ; 0xff

Thank you,
Kyungmin Park

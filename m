From: mkl0301@gmail.com (Lin Mac)
Date: Sat, 6 Mar 2010 05:14:38 +0800
Subject: Different definition in div_sc and clocksource_cyc2ns
Message-ID: <10d816431003051314i3e87a2d2yab344826d14a310a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

While working with the clocksource, I found that the relation of cycle
and nanosecond of div_sc and clocksource_cyc2ns is different.

linux-2.6.33
div_sc in include/linux/clockchips.h suggests that clock_ticks =
(nanoseconds * factor) >> shift.
  98/*
  99 * Calculate a multiplication factor for scaled math, which is
used to convert
 100 * nanoseconds based values to clock ticks:
 101 *
 102 * clock_ticks = (nanoseconds * factor) >> shift.
 103 *
 104 * div_sc is the rearranged equation to calculate a factor from a
given clock
 105 * ticks / nanoseconds ratio:
 106 *
 107 * factor = (clock_ticks << shift) / nanoseconds
 108 */
 109static inline unsigned long div_sc(unsigned long ticks, unsigned long nsec,
 110                                   int shift)
 111{
 112        uint64_t tmp = ((uint64_t)ticks) << shift;
 113
 114        do_div(tmp, nsec);
 115        return (unsigned long) tmp;
 116}


However, clocksource_cyc2ns in include/linux/clocksource.h suggest
nanoseconds=(cycles*mult)>>shift.
 268static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
 269{
 270        return ((u64) cycles * mult) >> shift;
 271}

But there are many others using div_sc, I don't think they got issues
with it. So what am I missing?

Best Regards,
Mac Lin

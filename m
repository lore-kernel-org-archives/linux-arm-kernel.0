From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Apr 2015 13:25:37 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
Message-ID: <5527B331.5000205@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This is take 2 of my tiny delay.c patch

Problem statement

When converting microseconds to timer cycles in __timer_udelay() and
__timer_const_udelay(), the result is rounded down(*), which means the
system will not spin as long as requested (specifically, between
epsilon and 1 cycle shorter).

If I understand correctly, most drivers expect udelay(N) to spin for
at least N ?s. Is that correct? In that use case, spinning less might
introduce subtle heisenbugs.


Typical example

timer->freq = 90 kHz && HZ = 100
(thus UDELAY_MULT = 107374 && ticks_per_jiffy = 900)

udelay(10) => __timer_const_udelay(10*107374)
            => __timer_delay((1073740*900) >> 30)
            => __timer_delay(0)

So udelay(10) resolves to no delay at all.


(*) 2^41 / 10^6 = 2199023,255552
2199023 < 2^41 / 10^6
UDELAY_MULT = 2199023*HZ / 2^11 < 2^30*HZ / 10^6

cycles = N * UDELAY_MULT * freq/HZ / 2^30
        < N * 2^30*HZ / 10^6 * freq/HZ / 2^30
        < N / 10^6 * freq


Proposed fix

Since results are always rounded down, all we need is to increment
the result by 1 to round it up.

Would someone ACK the patch below?

Regards.


Patch against 4.0-rc4

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 312d43e..3cfbd07 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -66,7 +66,7 @@ static void __timer_const_udelay(unsigned long xloops)
  {
         unsigned long long loops = xloops;
         loops *= arm_delay_ops.ticks_per_jiffy;
-       __timer_delay(loops >> UDELAY_SHIFT);
+       __timer_delay((loops >> UDELAY_SHIFT) + 1);
  }
  
  static void __timer_udelay(unsigned long usecs)

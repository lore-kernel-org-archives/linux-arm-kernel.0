From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 15 Nov 2017 13:51:54 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
 <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
Message-ID: <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 20:38, Marc Gonzalez wrote:

> OK, I'll just send my patch, and then crawl back under my rock.

Linus,

As promised, the patch is provided below. And as promised, I will
no longer bring this up on LKML.

FWIW, I have checked that the computed value matches the expected
value for all HZ and delay_us, and for a few clock frequencies,
using the following program:

$ cat delays.c
#include <stdio.h>
#define MEGA 1000000u
typedef unsigned int uint;
typedef unsigned long long u64;
#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))

static const uint HZ_tab[] = { 100, 250, 300, 1000 };

static void check_cycle_count(uint freq, uint HZ, uint delay_us)
{
	uint UDELAY_MULT = (2147 * HZ) + (483648 * HZ / MEGA);
	uint lpj = DIV_ROUND_UP(freq, HZ);
	uint computed = ((u64)lpj * delay_us * UDELAY_MULT >> 31) + 1;
	uint expected = DIV_ROUND_UP((u64)delay_us * freq, MEGA);

	if (computed != expected)
		printf("freq=%u HZ=%u delay_us=%u comp=%u exp=%u\n", freq, HZ, delay_us, computed, expected);
}

int main(void)
{
	uint idx, delay_us, freq;

	for (freq = 3*MEGA; freq <= 100*MEGA; freq += 3*MEGA)
		for (idx = 0; idx < sizeof HZ_tab / sizeof *HZ_tab; ++idx)
			for (delay_us = 1; delay_us <= 2000; ++delay_us)
				check_cycle_count(freq, HZ_tab[idx], delay_us);

	return 0;
}



-- >8 --
Subject: [PATCH] ARM: Tweak clock-based udelay implementation

In 9f8197980d87a ("delay: Add explanation of udelay() inaccuracy")
Russell pointed out that loop-based delays may return early.

On the arm platform, delays may be either loop-based or clock-based.

This patch tweaks the clock-based implementation so that udelay(N)
is guaranteed to spin at least N microseconds.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/lib/delay.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 2cef11884857..0a25712077ec 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -58,15 +58,15 @@ static void __timer_delay(unsigned long cycles)
 {
 	cycles_t start = get_cycles();
 
-	while ((get_cycles() - start) < cycles)
+	while ((get_cycles() - start) <= cycles)
 		cpu_relax();
 }
 
 static void __timer_const_udelay(unsigned long xloops)
 {
-	unsigned long long loops = xloops;
-	loops *= arm_delay_ops.ticks_per_jiffy;
-	__timer_delay(loops >> UDELAY_SHIFT);
+	u64 tmp = (u64)xloops * arm_delay_ops.ticks_per_jiffy;
+	unsigned long cycles = tmp >> UDELAY_SHIFT;
+	__timer_delay(cycles + 1); /* Round up in 1 instruction */
 }
 
 static void __timer_udelay(unsigned long usecs)
@@ -92,7 +92,7 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
 	if (!delay_calibrated && (!delay_res || (res < delay_res))) {
 		pr_info("Switching to timer-based delay loop, resolution %lluns\n", res);
 		delay_timer			= timer;
-		lpj_fine			= timer->freq / HZ;
+		lpj_fine			= DIV_ROUND_UP(timer->freq, HZ);
 		delay_res			= res;
 
 		/* cpufreq may scale loops_per_jiffy, so keep a private copy */
-- 
2.15.0

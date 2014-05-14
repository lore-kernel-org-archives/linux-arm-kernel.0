From: horms@verge.net.au (Simon Horman)
Date: Wed, 14 May 2014 12:28:38 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <CAMuHMdWBAkh_Jkfsok-Nws56z0ZsU0LmxV2nob_LKrMY_tFF6A@mail.gmail.com>
References: <20140511232508.20177.11556.sendpatchset@w520>
 <1509906.x9u0HJ6AbJ@avalon> <20140513005936.GB30252@verge.net.au>
 <20140513071224.GC27611@verge.net.au>
 <CAMuHMdWBAkh_Jkfsok-Nws56z0ZsU0LmxV2nob_LKrMY_tFF6A@mail.gmail.com>
Message-ID: <20140514032837.GB22813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:33:45AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, May 13, 2014 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> > From: Simon Horman <horms+renesas@verge.net.au>
> >
> > [PATCH] ARM: shmobile: Set clock frequency in HZ from OF nodes
> >
> > shmobile_init_delay() looks for OF "clock-frequency" to determine
> > the delay which is set by calling shmobile_setup_delay().
> >
> > Unfortunately this seems to be incorrect in detail as
> > "clock-frequency" node values are in HZ whereas the frequency
> > argument to shmobile_setup_delay() is in MHz.
> 
> Indeed. Nice catch.
> 
> > Provide a variant of shmobile_setup_delay() that accepts HZ to
> > correct this problem.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
> > index ccecde9..8d80a33 100644
> > --- a/arch/arm/mach-shmobile/timer.c
> > +++ b/arch/arm/mach-shmobile/timer.c
> > @@ -23,21 +23,24 @@
> >  #include <linux/delay.h>
> >  #include <linux/of_address.h>
> >
> > -void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
> > -                                unsigned int mult, unsigned int div)
> > +void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
> > +                                   unsigned int mult, unsigned int div)
> >  {
> >         /* calculate a worst-case loops-per-jiffy value
> > -        * based on maximum cpu core mhz setting and the
> > +        * based on maximum cpu core hz setting and the
> >          * __delay() implementation in arch/arm/lib/delay.S
> >          *
> >          * this will result in a longer delay than expected
> >          * when the cpu core runs on lower frequencies.
> >          */
> > -
> > -       unsigned int value = (1000000 * mult) / (HZ * div);
> > -
> >         if (!preset_lpj)
> > -               preset_lpj = max_cpu_core_mhz * value;
> > +               preset_lpj = max_cpu_core_hz * mult / (HZ * div);
> 
> I believe it was written this way to avoid integer overflow.
> As soon as we get a 2.2 GHz A15 (mult = 2), "max_cpu_core_hz * mult"
> will overflow.

Yes, I expect so.

The purpose of my patch was mainly to illustrate the problem
rather than to provide a diffinitive fix..

> When using Hz instead of MHz, we probably want to switch from
> multiplying a small number (in MHz) to dividing a large number (in Hz):
> 
>         preset_lpj = max_cpu_core_hz / value;
> 
> So value should be:
> 
>         value = HZ * div / mult;
> 
> which is OK as mult is really small (1 or 2).
> Does this look right? Haven't had my coffee yet ;-)

It appears to work :)

> All of this will still overflow when clock-frequency no longer fits in u32,
> and we have to revise the bindings ;-)

Awesome!

> 
> > +}
> > +
> > +void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
> > +                                unsigned int mult, unsigned int div)
> > +{
> > +       shmobile_setup_delay_hz(max_cpu_core_mhz, mult * 100000, div);
> 
> While this works (for now --- no longer with my proposed modifications
> above), didn't you intend this?
> 
>     shmobile_setup_delay_hz(max_cpu_core_mhz * 1000000, mult, div);

Yes :)


I wonder if the following is any good.


From: Simon Horman <horms+renesas@verge.net.au>

[PATCH] ARM: shmobile: Set clock frequency in HZ from OF nodes

shmobile_init_delay() looks for OF "clock-frequency" to determine
the delay which is set by calling shmobile_setup_delay().

Unfortunately this seems to be incorrect in detail as
"clock-frequency" node values are in HZ whereas the frequency
argument to shmobile_setup_delay() is in MHz.

Provide a variant of shmobile_setup_delay() that accepts HZ to
correct this problem.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* As suggested by Geert Uytterhoeven
  - Don't ignore the potential for integer overflow.
    To this end I have taken Geert's suggestion of dividing by
    a large "value" in the HZ case.
    And I have let the original function unchanged for the MHz case:
    it should eventually be removed anyway.
---
 arch/arm/mach-shmobile/timer.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index ccecde9..68bc0b8 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -23,6 +23,23 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 
+void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
+				    unsigned int mult, unsigned int div)
+{
+	/* calculate a worst-case loops-per-jiffy value
+	 * based on maximum cpu core hz setting and the
+	 * __delay() implementation in arch/arm/lib/delay.S
+	 *
+	 * this will result in a longer delay than expected
+	 * when the cpu core runs on lower frequencies.
+	 */
+
+	unsigned int value = HZ * div / mult;
+
+	if (!preset_lpj)
+		preset_lpj = max_cpu_core_hz / value;
+}
+
 void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 				 unsigned int mult, unsigned int div)
 {
@@ -58,12 +75,12 @@ void __init shmobile_init_delay(void)
 
 	if (max_freq) {
 		if (of_find_compatible_node(NULL, NULL, "arm,cortex-a8"))
-			shmobile_setup_delay(max_freq, 1, 3);
+			shmobile_setup_delay_hz(max_freq, 1, 3);
 		else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
-			shmobile_setup_delay(max_freq, 1, 3);
+			shmobile_setup_delay_hz(max_freq, 1, 3);
 		else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a15"))
 			if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
-				shmobile_setup_delay(max_freq, 2, 4);
+				shmobile_setup_delay_hz(max_freq, 2, 4);
 	}
 }
 
-- 
1.8.5.2

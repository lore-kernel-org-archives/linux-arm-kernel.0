From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 16:12:25 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <20140513005936.GB30252@verge.net.au>
References: <20140511232508.20177.11556.sendpatchset@w520>
 <1509906.x9u0HJ6AbJ@avalon> <20140513005936.GB30252@verge.net.au>
Message-ID: <20140513071224.GC27611@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:59:36AM +0900, Simon Horman wrote:
> On Mon, May 12, 2014 at 10:00:08PM +0200, Laurent Pinchart wrote:
> > Hi Magnus,
> > 
> > On Monday 12 May 2014 08:25:08 Magnus Damm wrote:
> > > ARM: shmobile: Use shmobile_init_delay() on r8a7791
> > > 
> > > [PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case
> > > [PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
> > > [PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()
> > > 
> > > Convert r8a7791 to rely on shmobile_init_delay() instead of using a per-SoC
> > > delay setup function.
> > 
> > I'm afraid this patch set causes a boot time and CPU load regression on 
> > Koelsch. With Simon's latest devel branch which has the patches applied, the 
> > kernel boot time (using koelsch_defconfig) up to the point where the kernel 
> > tries to connect to the DHCP server is 17.898437s. The CPU load (as reported 
> > by top) on an idle system is then around 33%, spent in [kworker/0:1]. If I 
> > revert the patches the same time goes down to 1.921875s and the CPU load on an 
> > idle system is close to 0.
> 
> Thanks for checking this Laurent.
> I have this and the (related to my eyes) r8a7740 changes in their own
> branch. For now I will leave it in next but refrain from sending a
> pull-request. I will drop it from next if the problem hasn't been resolved
> in time for rc6 (which seems likely).

Hi Laurent, Hi Magnus,

I have done some further investigation and I believe that the problem
is that "clock-frequency" node values are in Hz while shmobile_setup_delay
expects an argument in MHz.

I propose the following:

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

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index ccecde9..8d80a33 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -23,21 +23,24 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 
-void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-				 unsigned int mult, unsigned int div)
+void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
+				    unsigned int mult, unsigned int div)
 {
 	/* calculate a worst-case loops-per-jiffy value
-	 * based on maximum cpu core mhz setting and the
+	 * based on maximum cpu core hz setting and the
 	 * __delay() implementation in arch/arm/lib/delay.S
 	 *
 	 * this will result in a longer delay than expected
 	 * when the cpu core runs on lower frequencies.
 	 */
-
-	unsigned int value = (1000000 * mult) / (HZ * div);
-
 	if (!preset_lpj)
-		preset_lpj = max_cpu_core_mhz * value;
+		preset_lpj = max_cpu_core_hz * mult / (HZ * div);
+}
+
+void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
+				 unsigned int mult, unsigned int div)
+{
+	shmobile_setup_delay_hz(max_cpu_core_mhz, mult * 100000, div);
 }
 
 void __init shmobile_init_delay(void)
@@ -58,12 +61,12 @@ void __init shmobile_init_delay(void)
 
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
 

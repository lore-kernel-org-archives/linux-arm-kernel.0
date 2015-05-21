From: slash.tmp@free.fr (Mason)
Date: Thu, 21 May 2015 14:35:42 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <2681862.SyQNaSxams@wuerfel>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <76003699.Oyq777txnm@wuerfel> <555D030F.8030100@free.fr>
 <2681862.SyQNaSxams@wuerfel>
Message-ID: <555DD11E.7080302@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/2015 00:18, Arnd Bergmann wrote:

> On Wednesday 20 May 2015 23:56:31 Mason wrote:
>
>> Or perhaps the other way around?
>> i.e. feat_c3stop initialized to 0 (thus in the bss section)
>> and set to FEAT_C3STOP if "twd_never_stops" doesn't exist...
> 
> yes.

IIUC, something along these lines:

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05..e10a388 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -34,6 +34,7 @@ static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(bool, percpu_setup_called);
 
 static struct clock_event_device __percpu *twd_evt;
+static int feat_c3stop;
 static int twd_ppi;
 
 static void twd_set_mode(enum clock_event_mode mode,
@@ -294,7 +295,7 @@ static void twd_timer_setup(void)
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-			CLOCK_EVT_FEAT_C3STOP;
+			feat_c3stop;
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
@@ -346,6 +347,8 @@ static int __init twd_local_timer_common_register(struct device_node *np)
 		goto out_irq;
 
 	twd_get_clock(np);
+	if (!of_property_read_bool(np, "twd_never_stops"))
+		feat_c3stop = CLOCK_EVT_FEAT_C3STOP;
 
 	/*
 	 * Immediately configure the timer on the boot CPU, unless we need


>> Russell, when you added the FEAT_C3STOP flag unconditionally in
>> commit 5388a6b266, didn't that potentially break platforms that
>> didn't expect the flag to be set?
> 
> To take a step back, you should first figure out whether clearing
> this flag is actually the correct behavior for your hardware, or
> just happens to work by accident.

According to my (limited) understanding of the clockevents core,
a "broadcast device" is required if and only if the local timers
have CLOCK_EVT_FEAT_C3STOP. I could be wrong.

Additional reference:
https://lwn.net/Articles/574962/

Regards.

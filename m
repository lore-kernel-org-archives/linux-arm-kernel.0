From: slash.tmp@free.fr (Mason)
Date: Wed, 20 May 2015 23:56:31 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <76003699.Oyq777txnm@wuerfel>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150520201438.GW2067@n2100.arm.linux.org.uk> <555CF17D.4060500@free.fr>
 <76003699.Oyq777txnm@wuerfel>
Message-ID: <555D030F.8030100@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2015 22:52, Arnd Bergmann wrote:

> On Wednesday 20 May 2015 22:41:33 Mason wrote:
>
>> Oh... I didn't even think it made sense (and was supported)
>> to select more than one machine...
>>
>> Is this related to CONFIG_ARCH_MULTIPLATFORM?
> 
> Yes. In the old days, each platform had its own entry in the top-level
> choice statement, which meant they were mutually exclusive. Most of
> them are converted now and can be put into a single kernel with
> CONFIG_ARCH_MULTIPLATFORM, and we stopped accepting new ones that
> don't do this a few years ago.

Is the following patch (more) acceptable:

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 6591e26fc13f..3e867b2f067f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -32,6 +32,7 @@ static void __iomem *twd_base;
 static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(bool, percpu_setup_called);
+static int feat_c3stop = CLOCK_EVT_FEAT_C3STOP;
 
 static struct clock_event_device __percpu *twd_evt;
 static int twd_ppi;
@@ -294,7 +295,7 @@ static void twd_timer_setup(void)
 
        clk->name = "local_timer";
        clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-                       CLOCK_EVT_FEAT_C3STOP;
+                       feat_c3stop;
        clk->rating = 350;
        clk->set_mode = twd_set_mode;
        clk->set_next_event = twd_set_next_event;
@@ -346,6 +347,7 @@ static int __init twd_local_timer_common_register(struct device_node *np)
                goto out_irq;
 
        twd_get_clock(np);
+       if (of_get_property(np, "twd_never_stops", NULL)) feat_c3stop = 0;
 
        /*
         * Immediately configure the timer on the boot CPU, unless we need


Or perhaps the other way around?
i.e. feat_c3stop initialized to 0 (thus in the bss section)
and set to FEAT_C3STOP if "twd_never_stops" doesn't exist...

Russell, when you added the FEAT_C3STOP flag unconditionally in
commit 5388a6b266, didn't that potentially break platforms that
didn't expect the flag to be set?

Regards.

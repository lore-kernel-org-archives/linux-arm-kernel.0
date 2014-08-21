From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Aug 2014 15:38:25 +0200
Subject: [PATCH v7 3/8] cpufreq: kirkwood: Remove use of the clk provider
 API
In-Reply-To: <53F5A587.9030200@collabora.com>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-4-git-send-email-tomeu.vizoso@collabora.com>
 <20140820225513.5251.284@quantum> <53F5A587.9030200@collabora.com>
Message-ID: <20140821133825.GH8608@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 09:53:43AM +0200, Tomeu Vizoso wrote:
> On 08/21/2014 12:55 AM, Mike Turquette wrote:
> >Quoting Tomeu Vizoso (2014-08-18 08:30:29)
> >>Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >>---
> >>  drivers/cpufreq/kirkwood-cpufreq.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> >>index 37a4806..f3d087f 100644
> >>--- a/drivers/cpufreq/kirkwood-cpufreq.c
> >>+++ b/drivers/cpufreq/kirkwood-cpufreq.c
> >>@@ -12,7 +12,6 @@
> >>  #include <linux/kernel.h>
> >>  #include <linux/module.h>
> >>  #include <linux/clk.h>
> >>-#include <linux/clk-provider.h>
> >>  #include <linux/cpufreq.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >>@@ -50,7 +49,7 @@ static struct cpufreq_frequency_table kirkwood_freq_table[] = {
> >>
> >>  static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
> >>  {
> >>-       if (__clk_is_enabled(priv.powersave_clk))
> >>+       if (clk_is_enabled(priv.powersave_clk))
> >>                 return kirkwood_freq_table[1].frequency;
> >>         return kirkwood_freq_table[0].frequency;
> >>  }
> >>--
> >>1.9.3
> >>
> >
> >Tomeu,
> >
> >After taking a second look at clk_is_enabled and the Kirkwood driver, I
> >would prefer to not implement clk_is_enabled. The main reason is that it
> >is racey, since the clock's status could of course change as soon as as
> >that call completes. Furthermore I am worried that drivers might do
> >something like:
> >
> >if (!clk_is_enabled(clk))
> >	clk_enable(clk);
> >
> >Which is crap and the driver should just call clk_enable any time it
> >needs the clock. To that end I propose to drop "clk: provide public
> >clk_is_enabled function" and replace your update to kirkwood-cpufreq.c
> >with the following patch. Let me know what you think.

Hi Mike, Tomeu

> >+static unsigned long cpu_frequency = 0;


This has a problem. You are making an assumption about the initial
state. The way the hardware works, is you change the state of the
clock and then perform a Wait For Interrupt. Once the hardware has
finished adjusting its PLL, it raises an interrupt and things
continue.

However, if you don't cause an actual state change, the WFI never
returns. If this assumption is wrong, your box is dead the first time
it tries to change cpu frequency.

This is why the code reads the hardware register to find the real
current state, rather than assume it.

	Andrew

> >+
> >  /*
> >   * Kirkwood can swap the clock to the CPU between two clocks:
> >   *
> >@@ -50,9 +51,7 @@ static struct cpufreq_frequency_table kirkwood_freq_table[] = {
> >
> >  static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
> >  {
> >-	if (__clk_is_enabled(priv.powersave_clk))
> >-		return kirkwood_freq_table[1].frequency;
> >-	return kirkwood_freq_table[0].frequency;
> >+	return cpu_frequency;
> >  }
> >
> >  static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
> >@@ -71,9 +70,11 @@ static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
> >  	switch (state) {
> >  	case STATE_CPU_FREQ:
> >  		clk_disable(priv.powersave_clk);
> >+		cpu_frequency = kirkwood_freq_table[0].frequency;
> >  		break;
> >  	case STATE_DDR_FREQ:
> >  		clk_enable(priv.powersave_clk);
> >+		cpu_frequency = kirkwood_freq_table[1].frequency;
> >  		break;
> >  	}
> >
> >@@ -133,6 +134,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
> >
> >  	clk_prepare_enable(priv.cpu_clk);
> >  	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> >+	cpu_frequency = kirkwood_freq_table[0].frequency;
> >
> >  	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
> >  	if (IS_ERR(priv.ddr_clk)) {
> >
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

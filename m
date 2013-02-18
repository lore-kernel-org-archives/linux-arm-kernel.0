From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Feb 2013 10:50:23 +0800
Subject: i.MX6 Solo: maxcpus=1 vs. nosmp: Warning from smp_twd.c?
In-Reply-To: <20130214143752.GH17833@n2100.arm.linux.org.uk>
References: <511CF063.3010200@de.bosch.com>
 <20130214143752.GH17833@n2100.arm.linux.org.uk>
Message-ID: <20130218025021.GI6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 02:37:52PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 14, 2013 at 03:10:43PM +0100, Dirk Behme wrote:
> > working on a i.MX6 Solo SoC (one Cortex A9 core) we are usually booting  
> > with maxcpus=1 a kernel built with CONFIG_NR_CPUS=4. This is done to be  
> > able to boot the same kernel on the Solo and Quad version of that SoC.
> 
> And what happens if you compile a kernel without SMP support and boot
> it on this SoC?

Thanks Dirk for bringing this up on the list.  We have hit this fat
warning on FSL internal 3.5.7 kernel tree when booting SMP kernel with
nosmp on kernel cmdline.

As what Dirk confirmed, we do not see the warning with kernel built
with !SMP.

Russell,

The following is an immediate and less invasive change to lower the
warning level.  If you agree, I will post a patch and then put it
into patch system.

Shawn

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index c092115..f796b83 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -392,6 +392,6 @@ void __init twd_local_timer_of_register(void)
        err = twd_local_timer_common_register(np);

 out:
-       WARN(err, "twd_local_timer_of_register failed (%d)\n", err);
+       pr_warn("twd_local_timer_of_register failed (%d)\n", err);
 }
 #endif

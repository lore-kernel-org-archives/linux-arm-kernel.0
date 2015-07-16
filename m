From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jul 2015 10:39:02 +0100
Subject: [PATCH 3/3] ARM: add basic support for on-demand backtrace of
 other CPUs
In-Reply-To: <55A775B6.8080505@linaro.org>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
 <E1ZFTSw-0006vI-C2@rmk-PC.arm.linux.org.uk>
 <55A775B6.8080505@linaro.org>
Message-ID: <20150716093901.GJ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 10:13:26AM +0100, Daniel Thompson wrote:
> On 15/07/15 21:39, Russell King wrote:
> >As we now have generic infrastructure to support backtracing of other
> >CPUs in the system on lockups, we can start to implement this for ARM.
> >Initially, we add an IPI based implementation, as the GIC code needs
> >modification to support the generation of FIQ IPIs, and not all ARM
> >platforms have the ability to raise a FIQ in the non-secure world.
> >
> >This provides us with a "best efforts" implementation in the absence
> >of FIQs.
> >
> >Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >---
> >diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> >index 90dfbedfbfb8..3a20c386fd33 100644
> >--- a/arch/arm/kernel/smp.c
> >+++ b/arch/arm/kernel/smp.c
> >@@ -21,6 +21,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/irq.h>
> >+#include <linux/nmi.h>
> >  #include <linux/percpu.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/completion.h>
> >@@ -72,6 +73,7 @@ enum ipi_msg_type {
> >  	IPI_CPU_STOP,
> >  	IPI_IRQ_WORK,
> >  	IPI_COMPLETION,
> >+	IPI_CPU_BACKTRACE = 15,
> 
> Even with the potential for (eventually) being signalled by FIQ, is this IPI
> really so special it needs to be placed outside the scope of NR_IPI and the
> accounting and tracing support it brings with it?

That's exactly why it's placed outside that range.  We don't want the
accounting and tracing stuff at all in that path - that's more code which
needs to be run which could be the cause of the lockup.  More fragility.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

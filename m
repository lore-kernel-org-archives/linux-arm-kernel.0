From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Aug 2012 00:21:37 -0700
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <50352D82.2050509@codeaurora.org>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
 <5016D03D.8010607@codeaurora.org>
 <CANqRtoQ9BCPhQPi38vK__61G2yAY=g9s17NG3LhSnrxdOYnkDg@mail.gmail.com>
 <50297B34.5090504@codeaurora.org> <50352D82.2050509@codeaurora.org>
Message-ID: <503DC301.3010705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/22/2012 12:05 PM, Stephen Boyd wrote:
> Ok, I've put it in the patch tracker.
>

Russell, what's involved in getting rid of the printk now? Can we just
shift everything down by 1 and then formalize 0 as the wakeup ipi? Or do
you want to completely remove that ipi from the stats? It's not clear to
me what we should do. Something like the following untested patch would
be a possibility.

----8<------->8------

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 436e60b..2740c2a2 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>

-#define NR_IPI 5
+#define NR_IPI 6

 typedef struct {
        unsigned int __softirq_pending;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ebd8ad2..d98c37e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -51,7 +51,8 @@
 struct secondary_data secondary_data;

 enum ipi_msg_type {
-       IPI_TIMER = 2,
+       IPI_WAKEUP,
+       IPI_TIMER,
        IPI_RESCHEDULE,
        IPI_CALL_FUNC,
        IPI_CALL_FUNC_SINGLE,
@@ -347,7 +348,8 @@ void arch_send_call_function_single_ipi(int cpu)
 }

 static const char *ipi_types[NR_IPI] = {
-#define S(x,s) [x - IPI_TIMER] = s
+#define S(x,s) [x] = s
+       S(IPI_WAKEUP, "CPU wakeup interrupts"),
        S(IPI_TIMER, "Timer broadcast interrupts"),
        S(IPI_RESCHEDULE, "Rescheduling interrupts"),
        S(IPI_CALL_FUNC, "Function call interrupts"),
@@ -500,10 +502,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
        unsigned int cpu = smp_processor_id();
        struct pt_regs *old_regs = set_irq_regs(regs);

-       if (ipinr >= IPI_TIMER && ipinr < IPI_TIMER + NR_IPI)
-               __inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_TIMER]);
+       if (ipinr < NR_IPI)
+               __inc_irq_stat(cpu, ipi_irqs[ipinr]);

        switch (ipinr) {
+       case IPI_WAKEUP:
+               break;
+
        case IPI_TIMER:
                irq_enter();
                ipi_timer();

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

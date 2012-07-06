From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 12:49:47 +0800
Subject: MX28 poweroff issue
In-Reply-To: <20120705201002.GB31508@n2100.arm.linux.org.uk>
References: <201207040030.36713.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
 <20120704093823.8e74d48bc8d9918a9c80fbcf@kinali.ch>
 <201207041631.30107.marex@denx.de>
 <20120704151944.GB18739@n2100.arm.linux.org.uk>
 <20120705160855.GA20175@S2101-09.ap.freescale.net>
 <20120705201002.GB31508@n2100.arm.linux.org.uk>
Message-ID: <20120706044944.GA20503@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 09:10:02PM +0100, Russell King - ARM Linux wrote:
> Yes, the general idea is that if the timer is running, and the watchdog
> is running, and it detects that it's event thread doesn't occasionally
> run, it will report a lockup.
> 
> As other platforms seem to not exhibit the problem when we halt, and
> endlessly spin with IRQs enabled, the question needs to be asked: what
> is different with MX23/MX28 and why is it different.
> 
Ha, it turns out that the only reason is mxs_defconfig has
CONFIG_LOCKUP_DETECTOR enabled.

> Yes, we can mask the problem by disabling interrupts - just like x86
> does - but that doesn't tell us why we have this apparant difference
> in behaviours.  I think we need to understand that before we start
> heading down the path of disabling interrupts to get rid of this
> problem.
> 
> So, I think we need some analysis of what's going on here with platforms
> that do _not_ exhibit the problem.

I just reproduced the problem on imx53 with CONFIG_LOCKUP_DETECTOR
enabled in imx_v6_v7_defconfig.  I think if we enable the config for
imx_v4_v5_defconfig, we will see the problem on imx27.

Presumably, other platforms behave same on this.  So would you consider
the following change is a right fix?

Regards,
Shawn

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 19c95ea..693b744 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -247,6 +247,7 @@ void machine_shutdown(void)
 void machine_halt(void)
 {
        machine_shutdown();
+       local_irq_disable();
        while (1);
 }

@@ -268,6 +269,7 @@ void machine_restart(char *cmd)

        /* Whoops - the platform was unable to reboot. Tell the user! */
        printk("Reboot failed -- System halted\n");
+       local_irq_disable();
        while (1);
 }

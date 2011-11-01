From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 17:02:25 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
Message-ID: <20111101170225.GS19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Poodle doesn't have any MAINTAINERS entry, I think Richard Purdie last
touched Poodle in a 'maintainery' way back in 2006.)

poodle does this:

static void poodle_restart(char mode, const char *cmd)
{
        arm_machine_restart('h', cmd);
}

Given that the default value of 'mode' (in the absense of any reboot=
command line argument to the kernel) is 'h', this seems to be a no-op.
Below is the history; I suspect that the reason this first appeared was
because of the need to fiddle with RCSR - that's now gone so I suspect
the entire restart handler can be deleted.

What I don't understand in that case is why 'mode' wasn't simply passed
through in the first patch.

Please confirm.

commit 74617fb6b825ea370ae72565f7543306bc08ef6e
Author: Richard Purdie <rpurdie@rpsys.net>
Date:   Mon Jun 19 19:57:12 2006 +0100

    [ARM] 3593/1: Add reboot and shutdown handlers for Zaurus handhelds

    Patch from Richard Purdie

    Add functionality to allow machine specific reboot handlers on ARM.
    Add machine specific reboot and poweroff handlers for all PXA Zaurus
    models.

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c

@@ -247,10 +249,25 @@ static struct platform_device *devices[] __initdata = {
        &poodle_scoop_device,
 };

+static void poodle_poweroff(void)
+{
+       RCSR = RCSR_HWR | RCSR_WDR | RCSR_SMR | RCSR_GPR;
+       arm_machine_restart('h');
+}
+
+static void poodle_restart(char mode)
+{
+       RCSR = RCSR_HWR | RCSR_WDR | RCSR_SMR | RCSR_GPR;
+       arm_machine_restart('h');
+}
+
 static void __init poodle_init(void)
 {
        int ret = 0;

+       pm_power_off = poodle_poweroff;
+       arm_pm_restart = poodle_restart;

...
commit dc38e2ad53ca27968919dea6d7fa60575782d5a6
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Thu May 8 16:50:39 2008 +0100

    [ARM] pxa: Fix RCSR handling

    Related to d3930614e68bdf83a120d904c039a64e9f75dba1.

    RCSR is only present on PXA2xx CPUs, not on PXA3xx CPUs.  Therefore,
    we should not be unconditionally writing to RCSR from generic code.

    Since we now clear the RCSR status from the SoC specific PXA PM code
    and before reset in the arch_reset() function, the duplication in
    the corgi, poodle, spitz and tosa code can be removed.

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index ca5ac19..0b30f25 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -326,13 +326,11 @@ static struct platform_device *devices[] __initdata = {

 static void poodle_poweroff(void)
 {
-       RCSR = RCSR_HWR | RCSR_WDR | RCSR_SMR | RCSR_GPR;
        arm_machine_restart('h');
 }

 static void poodle_restart(char mode)
 {
-       RCSR = RCSR_HWR | RCSR_WDR | RCSR_SMR | RCSR_GPR;
        arm_machine_restart('h');
 }

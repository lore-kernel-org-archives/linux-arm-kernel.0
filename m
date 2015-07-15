From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 15:45:07 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150715134603.GA14862@red-moon>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
 <1436430685-2202-4-git-send-email-jszhang@marvell.com>
 <20150714103421.GU7557@n2100.arm.linux.org.uk>
 <20150714110302.GA334@red-moon>
 <20150714122904.GV7557@n2100.arm.linux.org.uk>
 <20150714145546.GA14556@red-moon>
 <20150714204138.GW7557@n2100.arm.linux.org.uk>
 <20150715134603.GA14862@red-moon>
Message-ID: <20150715144507.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 02:46:03PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 14, 2015 at 09:41:38PM +0100, Russell King - ARM Linux wrote:
> > Sorry, NAK, and end of discussion.  There is nothing more to be said
> > here.
> 
> I beg to differ. To solve the issue that you brought up with this series,
> we can create an arch function that allows to set CPUidle operations, which
> would remove the need for the OF construct you did not like, this mirrors
> what's done for PSCI smp operations (something similar to smp_set_ops),
> does that sound a reasonable approach to you ?

What's the point of that?

This is _all_ that arch/arm/kernel/psci_cpuidle.c will contain after this
series:

+#include <linux/cpuidle.h>
+#include <linux/psci.h>
+
+#include <asm/cpuidle.h>
+
+static struct cpuidle_ops psci_cpuidle_ops __initdata = {
+       .suspend = cpu_psci_cpu_suspend,
+       .init = cpu_psci_cpu_init_idle,
+};
+CPUIDLE_METHOD_OF_DECLARE(psci_cpuidle, "psci", &psci_cpuidle_ops);

There is _nothing_ ARM specific there.  All it's doing is providing an
entry in the DT linker-built table for that data structure, and that
data structure contains a pair of function pointers to code which _will_
be located in drivers/firmware/psci.c.

I'm saying _that_ is totally pointless, that data structure and
CPUIDLE_METHOD_OF_DECLARE() _should_ live with the code in
drivers/firmware/psci.c.

There's nothing in the above quoted code which points anything to any
32bit ARM specific stuff at all (so there's no need for a smp_set_ops()
type thing), it's all about giving DT a way to specify the CPU idle
operations which should be used, in this case, allowing DT to specify
that the _generic_ PSCI CPU idle operations are to be used.

> As for M.Rutland's series[1], and the patch that moves common PSCI code to
> drivers/firmware I reiterate my point, please review it[1] and provide us
> with feedback if any otherwise acknowledge the code move, which is the
> basis on top of which everything else can be developed, I do not understand
> why you are stopping [1] from getting into the kernel since it moves
> code from arch/arm to drivers/firmware to have it in a common and shared
> place between ARM and ARM64, what's the issue you have with that or put
> it differently why are you NAKing it ?

I'm NAKing everything related to moving the PSCI code around until
someone in the PSCI maintainer pool (that's not me - that's ARM Ltd)
clearly demonstrates that they know what they're talking about, and
has a plan behind this reorganisation.

Right now, I'm getting the impression that there is _no_ plan, or if
there is, it's an absurd plan which results in data structures which
should not be in arch/arm being left behind there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Dec 2017 17:37:59 +0000
Subject: [PATCH] ARM: CPU hotplug: Delegate complete() to surviving CPU
In-Reply-To: <20171212172059.GA11875@linux.vnet.ibm.com>
References: <20171212172059.GA11875@linux.vnet.ibm.com>
Message-ID: <20171212173759.GE10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 09:20:59AM -0800, Paul E. McKenney wrote:
> The ARM implementation of arch_cpu_idle_dead() invokes complete(), but
> does so after RCU has stopped watching the outgoing CPU, which results
> in lockdep complaints because complete() invokes functions containing RCU
> readers.  This patch therefore uses Thomas Gleixner's trick of delegating
> the complete() call to a surviving CPU via smp_call_function_single().
> 
> Reported-by: Peng Fan <van.freenix@gmail.com>
> Reported-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Tested-by: Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <linux-arm-kernel@lists.infradead.org>

As I just described in response to Fabio's testing, this doesn't solve
anything if CONFIG_BL_SWITCHER is enabled.  We could lose the unlock of
a spinlock in the GIC code for sending the IPI.  As I already said
previously in our discussion (but I guess you just don't believe me):

"2. there's some optional locking in the GIC driver that cause problems
   for the cpu dying path.

The concensus last time around was that the IPI solution is a non-
starter, so the seven year proven-reliable solution (disregarding the
RCU warning) persists because I don't think anyone came up with a
better solution."

Using smp_call_function_single() invokes the IPI paths.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

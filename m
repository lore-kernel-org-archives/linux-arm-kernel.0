From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Oct 2015 12:57:56 +0100
Subject: [PATCH v3] ARM: mvebu: Disable CPU Idle on Armada 38x
In-Reply-To: <1427820378-13415-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427820378-13415-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151003115756.GA9901@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 06:46:18PM +0200, Gregory CLEMENT wrote:
> On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
> Idle is enabled. Waiting for a solution to this issue, this patch
> disables the CPU Idle support for this SoC.
> 
> As CPU Hot plug support also uses some of the CPU Idle functions it is
> also affected by the same issue. This patch disables it also for the
> Armada 38x SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.17 +
> ---
> Hi,
> 
> In this version I removed the unneeded initialization of the ret
> variable, I also fixed the warning message, and finally I added the
> Tested-by from Thomas.

In order not to lose the results of my testing on Armada 388, and to
trigger a discussion, I'll reply to this mail.

With the Armada 388 board I have, running mainline 4.3-rc3, I see the
following board current and power consumption:

CPU idle state					Current	Power
Patch unreverted				0.33A	3.9W
Patch reverted					0.42A	5W
Patch reverted, state 1 disabled on one CPU	0.37A	4.4W
Patch reverted, state 1 disabled on both CPUs	0.33A	3.9W
Patch reverted, state 1 disabled on both CPUs,	0.37A	4.4W
CPU 1 hot-unplugged
Marvell Vendor-based kernel with CPU idle off	0.37A	4.4W
(I don't have a vendor kernel with CPU idle enabled)

This is with a mainline 4.3-rc3 kernel with my own patch set on top,
which includes things like EEE support giving a 360mW saving compared
to kernels without.

The result is a 30% _increase_ in power consumption when CPU idle is
enabled.  For reference, when placing both CPUs into a loop via
while :; do :; done in bash, the consumption goes up to 0.5A / 6W.

Thomas suggested to increase the CPU idle thresholds in a similar manner
to that done for Armada XP in ce6031c89a35 ("cpuidle: mvebu: Update
cpuidle thresholds for Armada XP SOCs"), so I made the following change:

@@ -92,9 +92,9 @@ static struct cpuidle_driver armada38x_idle_driver = {
-               .exit_latency           = 10,
+               .exit_latency           = 100,
-               .target_residency       = 100,
+               .target_residency       = 1000,

This had no effect on the power usage.

This brings up the obvious question, is there a bug somewhere, resulting
in suspending the CPU not resulting in power savings?

I don't think so.  I've fixed the failure path in the mvebu CPU idle code
as per the RFC I sent out earlier this morning, which means if we fail to
suspend the CPU, time will not be accounted to CPU idle state 1 - this
means we can be sure that the statistics for state 1 won't be incorrectly
incremented.  The CPU idle statistics indicate that we are hitting the
lower power state 1, and spending some time there for each call:

/sys/devices/system/cpu/cpu0/cpuidle/state0/time:24726278
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:29991
/sys/devices/system/cpu/cpu0/cpuidle/state1/time:290135931
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:74951
/sys/devices/system/cpu/cpu1/cpuidle/state0/time:41096682
/sys/devices/system/cpu/cpu1/cpuidle/state0/usage:141538
/sys/devices/system/cpu/cpu1/cpuidle/state1/time:270641329
/sys/devices/system/cpu/cpu1/cpuidle/state1/usage:47845

So we're probably _not_ looping trying to enter state 1 and immediately
coming back out.  In other words, we are suspending the CPU, and the CPU
is staying suspended for a period of time.

I think we have to conclude that we are successfully suspending the CPU,
and that it is resuming through armada_38x_cpu_resume() and cpu_resume()
as we expect, and the result if placing the CPU into suspend actually
results in higher power consumption than placing the CPU into WFI mode.

It could be that some register isn't set correctly to allow the CPU
power domain to be properly shut down.  It could also be that the SoC
doesn't implement the isolation barrier between the CPU and surrounding
circuitry, resulting in higher leakage when the CPU is placed into
suspend mode.  (The SCU power register is always present, but the
implementation of the isolation barriers to allow individual CPUs to be
independently powered down are optional.)  Either way, without
documentation, there's no way to know.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

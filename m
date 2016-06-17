From: james.morse@arm.com (James Morse)
Date: Fri, 17 Jun 2016 10:34:55 +0100
Subject: [PATCH 0/2] Fix hibernate on SMP spin-table systems
Message-ID: <1466156097-20028-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These two patches prevent hibernate on systems that use spin-tables and
have multiple CPUs. It also wires up 'cpus_stuck_in_kernel' which was
added for v4.7.

Prior to 44dbcc93ab67 ("arm64: Fix behavior of maxcpus=N"), we would
bring all the CPUs we would ever have up during boot. On a system with
spin tables and multiple CPUS the core hibernate code would prevent
hibernation because it can't disable secondary CPUs.

After 44dbcc93ab67, when we boot with 'maxcpus=1', we no longer bring
all the CPUs up, but we do move them into the secondary_holding_pen.
Resuming from hibernate will overwrite the secondary_holding_pen,
potentially releasing the secondary CPUs. If the kernel has been
loaded at a different physical address over hibernate and resume
the secondary_holding_pen may be at a different location after resume.
The core code can't help us with this, because these CPUs don't show
up in 'num_online_cpus()'

These two patches fix the problem by detecting multiple 'possible cpus'
that we have no mechanism to take offline and preventing hibernate [2].
This only happens for spin-table systems with multiple CPUs.

Kexec needs the same checks, so the 'or spin-tables' logic[0] got added
to the helper function.

(This problem was spotted on another thread [1])


[0] http://www.spinics.net/lists/arm-kernel/msg510097.html
[1] http://www.spinics.net/lists/arm-kernel/msg511880.html
[2] Failing to hibernate an SMP spin-tables system booted with maxcpus=1
---------------------%<---------------------
root@localhost:~# echo disk > /sys/power/state
[12248.197718] PM: Syncing filesystems ... done.
[12248.197727] Freezing user space processes ... (elapsed 0.001 seconds) done.
[12248.203197] PM: Preallocating image memory... done (allocated 50769 pages)
[12261.838699] PM: Allocated 203076 kbytes in 13.63 seconds (14.89 MB/s)
[12261.838760] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[12261.840732] Suspending console(s) (use no_console_suspend to debug)
[12261.842540] PM: freeze of devices complete after 1.732 msecs
[12261.843897] PM: late freeze of devices complete after 1.333 msecs
[12261.845191] PM: noirq freeze of devices complete after 1.272 msecs
[12261.845201] Disabling non-boot CPUs ...
[12261.845206] hibernate: Can't hibernate: no mechanism to offline secondary CPUs.
[12261.845206] PM: Error -16 creating hibernation image
[12261.846140] PM: noirq recover of devices complete after 0.908 msecs
[12261.847160] PM: early recover of devices complete after 0.940 msecs
[12262.765886] PM: recover of devices complete after 1.452 msecs
[12262.769191] Restarting tasks ... done.
-bash: echo: write error: Device or resource busy
root at localhost:~#
---------------------%<---------------------

James Morse (2):
  arm64: smp: Add function to determine if cpus are stuck in the kernel
  arm64: hibernate: Don't hibernate on systems with stuck CPUs

 arch/arm64/include/asm/smp.h  | 20 ++++++++++++++++++++
 arch/arm64/kernel/hibernate.c |  6 ++++++
 arch/arm64/kernel/smp.c       | 13 +++++++++++++
 3 files changed, 39 insertions(+)

-- 
2.8.0.rc3

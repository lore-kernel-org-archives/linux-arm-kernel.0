From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 24 Mar 2016 16:44:19 +0000
Subject: [PATCH 0/2] arm64: cpuidle: make arm_cpuidle_suspend() more
 efficient
In-Reply-To: <20160324211853.1ffebd49@xhacker>
References: <1458796130-6109-1-git-send-email-jszhang@marvell.com>
 <20160324111507.GB9323@arm.com> <20160324211853.1ffebd49@xhacker>
Message-ID: <20160324164419.GB21749@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 09:18:53PM +0800, Jisheng Zhang wrote:
> Hi Will,
> 
> On Thu, 24 Mar 2016 11:15:07 +0000 Will Deacon wrote:
> 
> > On Thu, Mar 24, 2016 at 01:08:48PM +0800, Jisheng Zhang wrote:
> > > This series is to improve the arm_cpuidle_suspend() a bit by removing/moving
> > > out checks from this hot path.
> > > 
> > > Jisheng Zhang (2):
> > >   arm64: cpuidle: remove cpu_ops check from arm_cpuidle_suspend()
> > >   arm64: cpuidle: make arm_cpuidle_suspend() a bit more efficient
> > > 
> > >  arch/arm64/kernel/cpuidle.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)  
> > 
> > These look fine to me, but do you have any rough numbers showing what
> > sort of improvement we get from this change?
> 
> Good question. Here it is:
> 
> I measured the 4096 * time from arm_cpuidle_suspend entry point to the
> cpu_psci_cpu_suspend entry point. HW platform is Marvell BG4CT STB board.
> 
> 1. only one shell, no other process, hot-unplug secondary cpus, execute the
> following cmd
> 
> while true
> do
> 	sleep 0.2
> done
> 
> before the patch: 1581220ns
> 
> after the patch: 1579630ns
> 
> reduced by 0.1%
> 
> 2. only one shell, no other process, hot-unplug secondary cpus, execute the
> following cmd
> 
> while true
> do
> 	md5sum /tmp/testfile
> 	sleep 0.2
> done
> 
> NOTE the testfile size should be larger than L1+L2 cache size
> 
> before the patch: 1961960ns
> after the patch: 1912500ns
> 
> reduced by 2.5%
> 
> So the more complex the system load, the bigger the improvement.

So between arm_cpuidle_suspend() and psci_cpu_suspend_enter() the
checks that you are removing are almost the *only* code that is
currently executed and this patch saves us best case 12ns per idle state
entry (which is noise compared to CPU PM notifiers/FW execution time)
if I am not mistaken, I can't wait to use that energy for something more
useful :)

Anyway, as a clean-up your patches are fine it is sloppy to check those
pointers on every idle state entry (do you really need two patches ?), so:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 25 Feb 2016 09:44:18 +0000
Subject: [PATCH] drivers: perf: arm: implement CPU_PM notifier
In-Reply-To: <7hsi0hr3wj.fsf@baylibre.com>
References: <1456251759-24768-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7hsi0hr3wj.fsf@baylibre.com>
Message-ID: <20160225094417.GB31728@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 05:10:20PM -0800, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > When a CPU is suspended (either through suspend-to-RAM or CPUidle),
> > its PMU registers content can be lost, which means that counters
> > registers values that were initialized on power down entry have to be
> > reprogrammed on power-up to make sure the counters set-up is preserved
> 
> This assumes that the PMUs are always sharing a power rail with a
> specific CPU, not the cluster.  Is that a reliable assumption?

As reliable as assuming the GIC HW state needs save/restore on idle-state
entry, if we have no power domains information linked to CPU PM
notifiers saving/restoring everything every time an idle state deeper
than wfi is entered is the best we can do.

As far as this patch is concerned, if the PMU is on a different power
domain than the CPU, I agree that stopping/resetting/restoring the
PMU registers is a waste of cycles (I will test it also by triggering
the notifiers on wfi, to make sure the reset is not disruptive on
a cpu that is not powered off), I see no alternative other than disabling
idle to carry out profiling sanely (or implement CPU PM notifiers with
runtime PM).

Thanks,
Lorenzo

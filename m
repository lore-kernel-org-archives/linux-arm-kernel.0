From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 1 Feb 2012 14:59:35 +0000
Subject: [linux-pm] [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <CAKfTPtB3Kcy41H9g9u3u81kEHJeypi=GvOfOjcpdztzqN991nA@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4F1929E9.7070707@linaro.org>
 <CAMbhsRTbVqV6p0py9NGZrpFPf2yvp-B0dr+o-m7qbdja_-Lfzw@mail.gmail.com>
 <CAKfTPtAsO8z_8AnR8zSGZ9cm_7orDNxB3r09JAFk+2jdezUVmQ@mail.gmail.com>
 <CAMbhsRQYVXTZ2pX4mBrM6=SyGTqn_GY8xsW4rt_e21zerEzctA@mail.gmail.com>
 <CAKfTPtB3Kcy41H9g9u3u81kEHJeypi=GvOfOjcpdztzqN991nA@mail.gmail.com>
Message-ID: <20120201145934.GA20421@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 12:13:26PM +0000, Vincent Guittot wrote:

[...]

> >> In your patch, you put in safe state (WFI for most of platform) the
> >> cpus that become idle and these cpus are woken up each time a new cpu
> >> of the cluster becomes idle. Then, the cluster state is chosen and the
> >> cpus enter the selected C-state. On ux500, we are using another
> >> behavior for synchronizing  the cpus. The cpus are prepared to enter
> >> the c-state that has been chosen by the governor and the last cpu,
> >> that enters idle, chooses the final cluster state (according to cpus'
> >> C-state). The main advantage of this solution is that you don't need
> >> to wake other cpus to enter the C-state of a cluster. This can be
> >> quite worth full when tasks mainly run on one cpu. Have you also think
> >> about such behavior when developing the coupled cpuidle driver ? It
> >> could be interesting to add such behavior.
> >
> > Waking up the cpus that are in the safe state is not done just to
> > choose the target state, it's done to allow the cpus to take
> > themselves to the target low power state.  On ux500, are you saying
> > you take the cpus directly from the safe state to a lower power state
> > without ever going back to the active state?  I once implemented Tegra
> 
> yes it is

But if there is a single power rail for the entire cluster, when a CPU
is "prepared" for shutdown this means that you have to save the context and
clean L1, maybe for nothing since if other CPUs are up and running the
CPU going idle can just enter a simple standby wfi (clock-gated but power on).

With Colin's approach, context is saved and L1 cleaned only when it is
almost certain the cluster is powered off (so the CPUs).

It is a trade-off, I am not saying one approach is better than the
other; we just have to make sure that preparing the CPU for "possible" shutdown 
is better than sending IPIs to take CPUs out of wfi and synchronize
them (this happens if and only if CPUs enter coupled C-states).

As usual this will depend on use cases (and silicon implementations :) )

It is definitely worth benchmarking them.

Lorenzo

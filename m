From: will.deacon@arm.com (Will Deacon)
Date: Sun, 23 Dec 2012 12:12:31 +0000
Subject: [PATCH 2/2] ARM: tegra: moving the clock gating procedure to
 tegra_cpu_kill
In-Reply-To: <20121223112540.GF16237@mudshark.cambridge.arm.com>
References: <1355970519-28200-1-git-send-email-josephl@nvidia.com>
 <1355970519-28200-2-git-send-email-josephl@nvidia.com>
 <50D34467.9000006@wwwdotorg.org>
 <1356083897.26029.187.camel@jlo-ubuntu-64.nvidia.com>
 <50D4D345.6030804@wwwdotorg.org>
 <20121223112540.GF16237@mudshark.cambridge.arm.com>
Message-ID: <20121223121231.GA16580@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 11:25:40AM +0000, Will Deacon wrote:
> On Fri, Dec 21, 2012 at 09:23:17PM +0000, Stephen Warren wrote:
> > What exactly did you mean by "what we currently have"; did you mean that
> > cpu_kill() should work without cpu_die() having executed on the target
> > CPU itself first, so Tegra should simply implement cpu_kill()? As Joseph
> > says above, I'm not sure that will work. Any more detailed thoughts you
> > have here would be greatly appreciated. Thanks.
> 
> I guess this comes down to the different between cpu_die/cpu_kill and
> whether you actually need cpu_die if you're not planning on returning to
> the same kernel that you left. If you really need to call cpu_die, then we
> need to figure out a way to do that whilst ensuring that only one CPU is
> left standing at the time we start copying the new kernel into place.

I took a closer look at the code to try and figure out a way to solve
this...

First of all, disable_nonboot_cpus *does* actually wait for the secondaries
to get out of the way, because it calls __cpu_die and we end up waiting on a
completion. The problem is that we IPI the secondaries in smp_send_stop,
which puts then into a while(1) cpu_relax(); loop with interrupts disabled,
so that completion won't be able to finish (the cores won't pass through
idle and call cpu_die() themselves).

This means we must call disable_nonboot_cpus before sending the IPI. My
first attempt was to make a hotplug-aware smp_send_stop, using
disable_nonboot_cpus and smp_kill_cpus but this is also problematic because
it's called by panic, where the simpler IPI-based code is probably a lot
better.

The best bet is probably to call disable_nonboot_cpus in machine shutdown,
before sending the stop and subsequent kill. It's very similar to your
initial suggestion, but without the #elif.

Does that work for you?

Will

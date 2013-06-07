From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jun 2013 23:15:26 +0100
Subject: [PATCH] ARM: tegra: disable nonboot CPUs when reboot
In-Reply-To: <51B25086.6020209@wwwdotorg.org>
References: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
 <51B20DF1.3030207@wwwdotorg.org>
 <20130607181846.GL8111@mudshark.cambridge.arm.com>
 <51B22CDC.4080200@wwwdotorg.org> <51B25086.6020209@wwwdotorg.org>
Message-ID: <20130607221526.GC18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 03:28:38PM -0600, Stephen Warren wrote:
> On 06/07/2013 12:56 PM, Stephen Warren wrote:
> ...
> > [1] Perhaps the issue is why ipi_send_stop() calls down into 
> > tegra_cpu_kill() rather than tegra_cpu_die(), since die() is what
> > should be run on the killed CPU, and kill() on the killing CPU?
> 
> Scratch that; I don't think it's calling down to /either/; I was
> confused. It seems like it /should/ call cpu_die() though, at least if
> hotplug is enabled, right?

The problem is really complex.

CPU hotplug is done in paths where we're relatively confident that the
system is working correctly.  So all the features such as scheduling
are available, the timer ticks work and so forth.

However, reboot is a totally different environment.  This can happen
from almost any context with the system in any state what so ever.  A
CPU could be stuck.  A CPU could have oopsed.  The CPU which is in
the reboot code could be the CPU which has oopsed.  It could be called
from within an interrupt...

What that means is the usual CPU hotplug methods can't be used in the
reboot path.  Well, they can, but it will be fragile.

For reboot, the real solution there is not to use software-based
reboot, but bring the other cores to a halt (which is what
ipi_send_stop is doing) and then issue a hardware reset to the whole
system, including the other CPUs.

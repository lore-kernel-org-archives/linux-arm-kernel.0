From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 00:05:12 +0100
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
In-Reply-To: <4E012198.6010405@nvidia.com>
References: <4E012198.6010405@nvidia.com>
Message-ID: <20110621230512.GL23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 03:56:24PM -0700, Jon Mayo wrote:
> Because arm linux likes to dynamically hotplug cpus, the meaning of
> online has changed slightly. Previously online meant a cpus is
> schedulable, and conversely offline means they it is not schedulable.
> But with the current power management infrastructure there are cpus
> that can be scheduled (after they are woken up automatically), yet are
> not considered "online" because the masks and flags for them are not
> set.

There be sharks here.  glibc can read /proc/cpuinfo to find out how
many CPUs are online.  glibc can also read /proc/stat to determine
that number.

Both files should be using the same test to ensure consistency.  That
is using the online mask, not the present mask.

If a CPU is hot unplugged (and therefore the bit is clear in the online
map) then it is not available for scheduling, and the system will not
wake the CPU up without intervention, no matter how high the load will
become, without userspace assistance.

So I don't think your change is correct, and the code as it stands is
right.

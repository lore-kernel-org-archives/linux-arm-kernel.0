From: jmayo@nvidia.com (Jon Mayo)
Date: Tue, 21 Jun 2011 16:24:16 -0700
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
In-Reply-To: <20110621230512.GL23234@n2100.arm.linux.org.uk>
References: <4E012198.6010405@nvidia.com>
	<20110621230512.GL23234@n2100.arm.linux.org.uk>
Message-ID: <4E012820.2090208@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2011 04:05 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 21, 2011 at 03:56:24PM -0700, Jon Mayo wrote:
>> Because arm linux likes to dynamically hotplug cpus, the meaning of
>> online has changed slightly. Previously online meant a cpus is
>> schedulable, and conversely offline means they it is not schedulable.
>> But with the current power management infrastructure there are cpus
>> that can be scheduled (after they are woken up automatically), yet are
>> not considered "online" because the masks and flags for them are not
>> set.
>
> There be sharks here.  glibc can read /proc/cpuinfo to find out how
> many CPUs are online.  glibc can also read /proc/stat to determine
> that number.
>

Yea. that's the issue I had with this patch. I couldn't come up with a 
way to make /proc/stat behave the same without impact other arches.

also what you described is something we call a race. :) reading and 
parsing cpuinfo then stat, or vice versa, is not atomic. glibc is just 
going to have to suck it up and deal with cpu1-3 on my system popping in 
and out randomly in both cpuinfo and stat with the current implementation.

if you feel that glibc can't handle this inconsistency built-in to the 
current implementation, then we probably should get together and agree 
to fix something. (I'm not sure what the right answer is, hence my 
proposed patch without any sort of signed-off-by)

> Both files should be using the same test to ensure consistency.  That
> is using the online mask, not the present mask.
>
> If a CPU is hot unplugged (and therefore the bit is clear in the online
> map) then it is not available for scheduling, and the system will not
> wake the CPU up without intervention, no matter how high the load will
> become, without userspace assistance.
>
> So I don't think your change is correct, and the code as it stands is
> right.

I don't think the behavior of ARM linux makes sense. Neither change is 
truly correct in my mind. What I feel is the correct behavior is a list 
(in both stat and cpuinfo) of all cpus either running a task or ready to 
run a task. cpu_possible_mask, cpu_present_mask, and cpu_online_mask 
don't have semantics on ARM that I feel is right. (I don't understand 
what cpu_active_mask is, but it's probably not what I want either)

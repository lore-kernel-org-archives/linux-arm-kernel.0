From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 00:36:19 +0100
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
In-Reply-To: <4E012820.2090208@nvidia.com>
References: <4E012198.6010405@nvidia.com>
	<20110621230512.GL23234@n2100.arm.linux.org.uk>
	<4E012820.2090208@nvidia.com>
Message-ID: <20110621233619.GM23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 04:24:16PM -0700, Jon Mayo wrote:
> On 06/21/2011 04:05 PM, Russell King - ARM Linux wrote:
>> On Tue, Jun 21, 2011 at 03:56:24PM -0700, Jon Mayo wrote:
>>> Because arm linux likes to dynamically hotplug cpus, the meaning of
>>> online has changed slightly. Previously online meant a cpus is
>>> schedulable, and conversely offline means they it is not schedulable.
>>> But with the current power management infrastructure there are cpus
>>> that can be scheduled (after they are woken up automatically), yet are
>>> not considered "online" because the masks and flags for them are not
>>> set.
>>
>> There be sharks here.  glibc can read /proc/cpuinfo to find out how
>> many CPUs are online.  glibc can also read /proc/stat to determine
>> that number.
>>
>
> Yea. that's the issue I had with this patch. I couldn't come up with a  
> way to make /proc/stat behave the same without impact other arches.
>
> also what you described is something we call a race. :) reading and  
> parsing cpuinfo then stat, or vice versa, is not atomic. glibc is just  
> going to have to suck it up and deal with cpu1-3 on my system popping in  
> and out randomly in both cpuinfo and stat with the current 
> implementation.

Well, that's how it is - Linus tends to be opposed to adding syscalls
to allow glibc to get this kind of information, blaming glibc for being
dumb instead.  If you look at the glibc source, you'll see that it has
a hint about a 'syscall' for __get_nprocs - that's quite old and has
never happened.  I don't hope out much hope of anything changing anytime
soon.

> I don't think the behavior of ARM linux makes sense. Neither change is  
> truly correct in my mind. What I feel is the correct behavior is a list  
> (in both stat and cpuinfo) of all cpus either running a task or ready to  
> run a task.

That _is_ what you have listed in /proc/cpuinfo and /proc/stat.

> cpu_possible_mask, cpu_present_mask, and cpu_online_mask  
> don't have semantics on ARM that I feel is right. (I don't understand  
> what cpu_active_mask is, but it's probably not what I want either)

They have their defined meaning.

cpu_possible_mask - the CPU number may be available
cpu_present_mask - the CPU number is present and is available to be brought
	online upon request by the hotplug code
cpu_online_mask - the CPU is becoming available for scheduling
cpu_active_mask - the CPU is fully online and available for scheduling

CPUs only spend a _very_ short time in the online but !active state
(about the time it takes the CPU asking for it to be brought up to
notice that it has been brought up, and for the scheduler migration
code to receive the notification that the CPU is now online.)  So
you can regard the active mask as a mere copy of the online mask for
most purposes.

CPUs may be set in the possible mask but not the present mask - that
can happen if you limit the number of CPUs on the kernel command line.
However, we have no way to bring those CPUs to "present" status, and
so they are not available for bringing online - as far as the software
is concerned, they're as good as being physically unplugged.

CPUs in the possible mask indicate CPUs which can be present while
this kernel is running.

So, actually, our use of these is correct - it can't be any different
to any other architecture, because the code which interprets the state
from these masks is all architecture independent.

For instance, the generic hotplug code will refuse to bring a cpu
online by doing this test:

        if (cpu_online(cpu) || !cpu_present(cpu))
                return -EINVAL;

So, we (in arch/arm) can't change that decision.  Same for online &&
active must both be set in order for any process to be scheduled onto
that CPU - if any process is on a CPU which is going offline (and
therefore !active, !online) then it will be migrated off that CPU by
generic code before the CPU goes offline.

I think what you're getting confused over is that within nvidia, you're
probably dynamically hotplugging CPUs, and so offline CPUs are apparantly
available to the system if the load on the system rises.  That's not
something in the generic kernel, and is a custom addition.  Such an
addition _can_ be seen to change the definition of the above masks,
but that's not the fault of the kernel - that's the way you're driving
the hotplug system.

So, I don't believe there's anything what so ever wrong here, and I
don't believe that we're doing anything different from any other SMP
platform wrt these masks.

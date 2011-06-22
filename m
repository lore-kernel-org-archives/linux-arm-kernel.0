From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 10:36:23 +0100
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
In-Reply-To: <4E01326C.1060808@nvidia.com>
References: <4E012198.6010405@nvidia.com>
	<20110621230512.GL23234@n2100.arm.linux.org.uk>
	<4E012820.2090208@nvidia.com>
	<20110621233619.GM23234@n2100.arm.linux.org.uk>
	<4E01326C.1060808@nvidia.com>
Message-ID: <20110622093623.GP23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 05:08:12PM -0700, Jon Mayo wrote:
> This issue has had me concerned for a while. Because in userspace it can  
> be advantageous to allocate per-cpu structures on start-up for some  
> threading tricks. but if you use the wrong count, funny things can 
> happen.

Again, if you look at the glibc sources, you'll find that they (in
theory) provide two different calls - getconf(_SC_NPROCESSORS_CONF)
and getconf(_SC_NPROCESSORS_ONLN).  See sysdeps/posix/sysconf.c.

That suggests you you should be using getconf(_SC_NPROCESSORS_CONF).

However, these are provided by __get_nprocs_conf() and __get_nprocs()
respectively. See sysdeps/unix/sysv/linux/getsysstats.c.  Notice this
comment:

/* As far as I know Linux has no separate numbers for configured and
   available processors.  So make the `get_nprocs_conf' function an
   alias.  */
strong_alias (__get_nprocs, __get_nprocs_conf)

So, getconf(_SC_NPROCESSORS_CONF) and getconf(_SC_NPROCESSORS_ONLN)
will probably return the same thing - and it seems to me that you
require that to be fixed.  That's not for us in ARM to sort out -
that's a _generic_ kernel and glibc issue, and needs to be discussed
elsewhere.

>>> I don't think the behavior of ARM linux makes sense. Neither change is
>>> truly correct in my mind. What I feel is the correct behavior is a list
>>> (in both stat and cpuinfo) of all cpus either running a task or ready to
>>> run a task.
>>
>> That _is_ what you have listed in /proc/cpuinfo and /proc/stat.
>>
>
> What I see is my idle cpus are not there because we hot unplug them so  
> their power domains can be turned off. scheduling them can happen, but  
> only if an extra step occurs. From user space it's transparent, from  
> kernel space, there is a whole framework making decisions about when to  
> dynamically turn on what.

Exactly.  You're complaining that the kernels interpretation of the masks
is not correct because you're driving it with a user program which
effectively changes that behaviour.

So, if we change the interpretation of the masks, we'll then have people
who aren't using your user program complaining that the masks are wrong
for them.  It's a no-win situation - there is no overall benefit to
changing the kernel.

The fact that you're using a user program which dynamically hot-plugs
CPUs means that _you're_ changing the system behaviour by running that
program, and _you're_ changing the meaning of those masks.

>>> cpu_possible_mask, cpu_present_mask, and cpu_online_mask
>>> don't have semantics on ARM that I feel is right. (I don't understand
>>> what cpu_active_mask is, but it's probably not what I want either)
>>
>> They have their defined meaning.
>>
>> cpu_possible_mask - the CPU number may be available
>> cpu_present_mask - the CPU number is present and is available to be brought
>> 	online upon request by the hotplug code
>> cpu_online_mask - the CPU is becoming available for scheduling
>> cpu_active_mask - the CPU is fully online and available for scheduling
>>
>> CPUs only spend a _very_ short time in the online but !active state
>> (about the time it takes the CPU asking for it to be brought up to
>> notice that it has been brought up, and for the scheduler migration
>> code to receive the notification that the CPU is now online.)  So
>> you can regard the active mask as a mere copy of the online mask for
>> most purposes.
>>
>> CPUs may be set in the possible mask but not the present mask - that
>> can happen if you limit the number of CPUs on the kernel command line.
>> However, we have no way to bring those CPUs to "present" status, and
>> so they are not available for bringing online - as far as the software
>> is concerned, they're as good as being physically unplugged.
>>
>
> I don't see a use for that semantic. Why shouldn't we add a couple lines  
> of code to the kernel to scrub out unusable situations?

Think about it - if you have real hot-pluggable CPUs (servers do), do
you _really_ want to try to bring online a possible CPU (iow, there's
a socket on the board) but one which isn't present (iow, the socket is
empty.)

That's what the possible + !present case caters for.  Possible tells
the kernel how many CPUs to allocate per-cpu data structures for.
present tells it whether a CPU can be onlined or not.

>> So, we (in arch/arm) can't change that decision.  Same for online&&
>> active must both be set in order for any process to be scheduled onto
>> that CPU - if any process is on a CPU which is going offline (and
>> therefore !active, !online) then it will be migrated off that CPU by
>> generic code before the CPU goes offline.
>>
>
> I will accept that. But then does that mean we (either arch/arm or  
> mach-tegra) have used the cpu hotplug system incorrectly?

It means you're using it in ways that it was not originally designed
to be used - which is for the physical act of hot-plugging CPUs in
servers.  CPU hotplug was never designed from the outset for this
kind of dynamic CPU power management.

Yes, you _can_ use the CPU hotplug interfaces to do this, but as you're
finding, there are problems with doing this.

We can't go around making ARM use CPU hotplug differently from everyone
else because that'll make things extremely fragile.  As you've already
found out, glibc getconf() ultimately uses /proc/stat to return the
number of CPUs.  So in order to allow dynamic hotplugging _and_ return
the sensible 'online CPUs' where 'online' means both those which are
currently running and dormant, you need to change generic code.

Plus, there's the issue of CPU affinity for processes and IRQs.  With
current CPU hotplug, a process which has chosen to bind to a particular
CPU will have that binding destroyed when the CPU is hot unplugged, and
its affinity will be broken.  It will be run on a different CPU.  This
is probably not the semantics you desire.

I'd argue that trying to do dynamic hotplugging is the wrong approach,
especially as there is CPUidle (see below.)

>> I think what you're getting confused over is that within nvidia, you're
>> probably dynamically hotplugging CPUs, and so offline CPUs are apparantly
>> available to the system if the load on the system rises.  That's not
>> something in the generic kernel, and is a custom addition.  Such an
>> addition _can_ be seen to change the definition of the above masks,
>> but that's not the fault of the kernel - that's the way you're driving
>> the hotplug system.
>>
>
> sorry. I thought we weren't the only one in arm driving it this way. if  
> what we've done is strange, I'd like to correct it.

I'm aware of ARM having done something like this in their SMP group
in the early days of SMP support, but I wasn't aware that it was still
being actively persued.  I guess that it never really got out of the
prototyping stage (or maybe it did but they chose not to address these
issues.)

> Like if I were to think of a big mainframe or xeon server with hotplug  
> cpus, the way the masks work makes perfect sense. I push a button, all  
> the processes get cleared from the cpu, it is marked ass offline. I pull  
> the card from the cabinet, and then it is !present. and maybe instead a  
> new card at a later date. it's just like any other sort of hotplug thing.
>
> I think my issue with cpuinfo/stat's output is with the semantics for  
> "online" being different for this one architecture (mach-tegra) and  
> possibly others (??) than what I would expect.

No, it's no different.  As I've explained above, the difference is that
you're running a userspace program which automatically does the
hotplugging depending on the system load.

That _can_ be viewed as fundamentally changing the system behaviour
because CPUs which are offlined are still available for scheduling
should the system load become high enough to trigger it.

I think there's an easier way to solve this problem: there is the CPU
idle infrastructure, which allows idle CPUs to remain online while
allowing them to power down when they're not required.  Because they
remain online, the scheduler will migrate tasks to them if they're
not doing anything, and maybe that's something else to look at.

The other advantage of CPUidle is that you're not breaking the affinity
of anything when the CPU is powered down, unlike hotplug.

So, I think you really should be looking at CPUidle, rather than trying
to do dynamic hotplugging based on system load.

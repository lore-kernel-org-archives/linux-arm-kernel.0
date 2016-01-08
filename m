From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 8 Jan 2016 21:48:32 +0800
Subject: Armada XP (MV78460): BUG in netdevice.h with maxcpus=2
In-Reply-To: <20160108133104.GJ19062@n2100.arm.linux.org.uk>
References: <568F6A47.6010905@gmail.com>	<20160108182537.0a68630c@xhacker>
 <20160108105721.GG19062@n2100.arm.linux.org.uk>
 <20160108204523.43b4d473@xhacker>
 <20160108133104.GJ19062@n2100.arm.linux.org.uk>
Message-ID: <20160108214832.0c3f3a1e@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

On Fri, 8 Jan 2016 13:31:04 +0000 Russell King - ARM Linux wrote:

> On Fri, Jan 08, 2016 at 08:45:23PM +0800, Jisheng Zhang wrote:
> > let's assume a quad core system, boot with maxcpus=2, after booting.
> > 
> > on arm64, present cpus is cpu0, cpu1
> > 
> > on arm, present cpus is cpu0, cpu1, cpu2 and cpu3.
> > 
> > the arm core code requires every platform to update the present map in
> > platforms' smp_prepare_cpus(), but only two or three platforms do so.  
> 
> The behaviour of maxcpus= is architecture specific.  Some architectures
> take notice of this to limit the number of present and possible CPUs,
> others ignore it.  In any case, it limits the number of CPUs that come
> online at boot.
> 
> However, that is a complete red herring, because what we're talking
> about is bringing up the network interface at some point later, when
> CPU hotplug may have changed the online state already: the kernel may
> have booted with CPU0-3 online, but CPUs 2 and 3 may have been taken
> offline before the network interface is brought up.

Oh yeah! On arm64, the BUG_ON can be reproduced in this case. So the driver
need a fix. Thanks a lot

> 
> > What's the better solution? Could you please guide me?  
> 
> I would suggest that you need to track the state of each CPU within
> your percpu specific code with appropriate locks to prevent concurrency,
> and ensure that you register the CPU hotplug notifier just before
> walking the currently on-line CPUs.
> 
> Also, walk the list of currently on-line CPUs (using, eg,
> smp_call_function) just before unregistering the hotplug notifier.
> 
> Remember that your per-CPU bringup/takedown may be executed twice
> for the same CPU - once via the hotplug notifier and once via
> smp_call_function() - hence why you need locking and state tracking.

Got it. Thanks for the guidance, I'll try.

> 
> That fixes two of the sites.  For the other site, I wonder whether
> it's possible to restructure the code so there's no need to have
> three sites, since it's fairly obvious when thinking about the
> CPU hotplug case, you only have notification of the CPU coming
> online and the CPU going away.  It's been a while since I looked
> at the mvneta code to really comment on that though.
> 

Thank you very much,
Jisheng

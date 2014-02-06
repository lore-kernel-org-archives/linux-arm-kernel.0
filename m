From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Feb 2014 10:57:18 +0000
Subject: [PATCH 08/51] arm, hw-breakpoint: Fix CPU hotplug callback
 registration
In-Reply-To: <20140205220603.19080.80971.stgit@srivatsabhat.in.ibm.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
 <20140205220603.19080.80971.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20140206105718.GG26035@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srivatsa,

On Wed, Feb 05, 2014 at 10:06:04PM +0000, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
> 
> 	get_online_cpus();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	put_online_cpus();
> 
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).

Hmm, the code in question (for this patch) runs from an arch_initcall. How
can you generate CPU hotplug operations at that stage?

> Instead, the correct and race-free way of performing the callback
> registration is:
> 
> 	cpu_maps_update_begin();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	/* Note the use of the double underscored version of the API */
> 	__register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	cpu_maps_update_done();
> 
> 
> Fix the hw-breakpoint code in arm by using this latter form of callback
> registration.

I guess you introduce __register_cpu_notifier somewhere earlier in the
series, so it's best if you take this all via your tree.

Will

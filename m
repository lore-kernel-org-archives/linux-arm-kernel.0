From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Dec 2012 12:00:07 -0500 (EST)
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <50BE04C6.4070602@gmail.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <50BD1F81.9080304@gmail.com>
 <20121204123001.GL23368@mudshark.cambridge.arm.com>
 <50BE04C6.4070602@gmail.com>
Message-ID: <alpine.LFD.2.02.1212041142490.6589@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Dec 2012, Rob Herring wrote:

> That to me is highlighting where we need to do more work on DT driving
> the initialization. The platforms are still aware of what kind of timers
> and interrupt controllers are present. They should not be. There's work
> in progress for both of those.
> 
> Lorenzo's DT MPIDR patches should trim down smp code some. The DT spin
> table code could probably be common. I think I could use it on highbank
> as well. If we decide the pen code stays, then it should be common
> rather than creating yet another copy.

I don't want to rain on the "everything should be common" parade here.  
However, for the best part of last year I've been working on kernel 
support for big.LITTLE systems, and the handling of CPU hotplug 
(including SMP secondary boot) is far from being a trivial task.  
Managing the simple bringing up or down of a CPU in such an environment 
required hundreds of new lines of code.  That is far from a simple 
holding pen or spinning table to say the least.

[ For the curious, I'll post this code here soon for review. ]

So my point of view is: if you do not need a holding pen because you can 
hold individual CPUs in reset, then don't.  Many platforms with support 
in the kernel can do that, yet they copied the holding pen code just 
because it is there.  And that is total crap.

on the topic of a para-virtualised machine, I think that it should 
simply implement the PSCI calls to bring up CPUs _without_ any holding 
pen nor spinning tables.  You issue the appropriate PSCI call with the 
physical address for secondary_startup() as argument and you're done.  
The host intercepts that call and free a new CPU instance in response.  
That's all.


Nicolas

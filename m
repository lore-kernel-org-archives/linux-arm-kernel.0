From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 19 Aug 2016 13:10:32 -0500
Subject: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com> (Sudeep Holla's
 message of "Wed, 10 Aug 2016 19:09:21 +0100")
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
 <99e35b6c-6698-6d27-f4d7-fa032796869e@arm.com>
 <20160810164034.GA1401@linaro.org>
 <5e59874c-bbb7-270a-199c-da1ff5932554@arm.com>
Message-ID: <m2fuq0k4tj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla@arm.com> writes:

[...]

> In general whatever binding we come up must not just address OS
> coordinated mode. Also I was thinking to have better coverage in the
> description by having a bit more complex system like:
>
> cluster0
> 	CLUSTER_RET(Retention)
> 	CLUSTER_PG(Power Gate)
> 	core0
> 		CORE_RET
> 		CORE_PG
> 	core1
> 		CORE_RET
> 		CORE_PG

Also, remember that a power domain may contain more than just CPUs, so
this will also need to handle things like:

	device0..N
        	DEV_CLK_GATE
                DEV_RET
                DEV_PG

So, as (I think) Lina was trying to say, including CPU idle states
inside domain idles states doesn't really scale well because it would
also imply domain states would also include device idle states.

IMO, the device-specific states belong in the device nodes, and that
includes CPUs.

It's up to the domain (genpd) governor to look at *all* devices in the
domain, check their state and make a domain-wide decision.

The tricky part remains, IMO, the mapping between device/CPU states and
allowable domain states.

As was suggested earlier, a good potential starting point would be that
all devices/CPUs would need to be in their deepest state before the
domain would make any decisions.  While that leaves soem power savings
on the table, it maps well to how genpd works today with only on/off
states and could be extended with more complicated governors down the
road.

Kevin

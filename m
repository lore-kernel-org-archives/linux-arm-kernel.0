From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Dec 2009 11:04:09 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for	ARMv6
In-Reply-To: <20091216105403.GX4141@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<20091215150205.GO4141@wear.picochip.com>
	<20091215151903.GP4141@wear.picochip.com>
	<1260891013.4165.466.camel@twins>
	<20091215153627.GQ4141@wear.picochip.com>
	<20091216105403.GX4141@wear.picochip.com>
Message-ID: <000501ca7e3f$7e376740$7aa635c0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*Jamie Iles wrote:

> > That's exactly what I do for single core ARMv6. However, in the list of events
> > for mpcore I can't see any that wouldn't count. There's plenty of reserved
> > identifiers though so hopefully one of those will do the job. Also, ARM
> > counters can't be set to exclude any modes.
>
> Thinking about this a bit more, although we can't disable the counters, we can
> disable their interrupt reporting. So, when the generic perf events layer
> calls pmu->disable(event), we do the update of the event then turn off the
> IRQ. When we come to unthrottling, the counter will have carried on counting,
> but if we set the period again, the counter gets set with the correct restart
> value and then reenabled.

This was my first thought, but I was concerned about how it would play out
with the armpmu_read function. Now that I see we don't read disabled counters,
I can't see any reason not to simply disable the interrupt and stash the count
value.
 
> I think this should work for mpcore and is also required for the cycle counter
> on all v6 cores. I've given this a go using an artificially low period on a
> cycle counter and it does appear to do the job.

If we do this for mpcore, is it worth doing the same thing for the other v6 cores
too [and removing the ETM `hack']?

Cheers,

Will

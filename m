From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 24 Oct 2012 17:00:32 +0100
Subject: [RFC] Energy/power monitoring within the kernel
In-Reply-To: <1351014187.8467.24.camel@gandalf.local.home>
References: <1351013449.9070.5.camel@hornet>
 <1351014187.8467.24.camel@gandalf.local.home>
Message-ID: <1351094432.23327.42.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-23 at 18:43 +0100, Steven Rostedt wrote:
> > <...>212.673126: hwmon_attr_update: hwmon4 temp1_input 34361
> > 
> > One issue with this is that some external knowledge is required to
> > relate a number to a processor core. Or maybe it's not an issue at all
> > because it should be left for the user(space)?
> 
> If the external knowledge can be characterized in a userspace tool with
> the given data here, I see no issues with this.

Ok, fine.

> > 	TP_fast_assign(
> > 		memcpy(__entry->cpus, cpus, sizeof(struct cpumask));
> 
> Copying the entire cpumask seems like overkill. Especially when you have
> 4096 CPU machines.

Uh, right. I didn't consider such use case...

> Perhaps making a field that can be a subset of cpus may be better. That
> way we don't waste the ring buffer with lots of zeros. I'm guessing that
> it will only be a group of cpus, and not a scattered list? Of course,
> I've seen boxes where the cpu numbers went from core to core. That is,
> cpu 0 was on core 1, cpu 1 was on core 2, and then it would repeat. 
> cpu 8 was on core 1, cpu 9 was on core 2, etc.
> 
> But still, this could be compressed somehow.

Sure thing. Or I could simply use cpumask_scnprintf() on the assign
stage and keep an already-formatted string. Or, as the cpumask per
sensor would be de-facto constant, I could assume keep only a pointer to
it. Will keep it in mind if this event was supposed to happen.

Thanks!

Pawe?

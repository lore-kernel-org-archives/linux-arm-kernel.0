From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 11 Apr 2011 14:47:55 +0200
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302521393.24286.66.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<1302349235.9086.1270.camel@twins>
	<1302521393.24286.66.camel@e102144-lin.cambridge.arm.com>
Message-ID: <1302526075.2388.97.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-11 at 12:29 +0100, Will Deacon wrote:
> > If you've got system wide things like GPUs, where every cpu maps to the
> > same device, simply use the first online cpu and create a pmu instance
> > per device.
> 
> Would this result in userspace attributing all of the data to a
> particular CPU? We could consider allowing events where the cpu is -1
> and the task pid is -1 as well. Non system-wide PMUs could reject these
> and demand multiple events instead. 

Not at such, but you need a cpu to receive interrupts on and program the
hardware from etc. Currently most core code assumes things are either
restrained to a single cpu or serialized by virtue of a task never
running on more than 1 cpu at a time.

I'm not quite sure how hard these assumptions are, and we might be able
to get away with making it a little less strict, but that's something
you'd have to play with.

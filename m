From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Nov 2011 14:56:58 +0000
Subject: HW perf initialisation as early_initcall
Message-ID: <20111123145658.GM25848@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

In commit 004417a6 ("perf, arch: Cleanup perf-pmu init vs lockup-detector"),
you moved the arch hw perf initialisation into an early initcall to satisfy a
race with the NMI lock detector (I'm not clear on what the relationship is).

Anyway, with ARM big/little platforms on the horizon we have the fun of
heterogeneous PMUs in the sense that:

	- They may have different numbers of event counters
	- They may support different event types (possibly a distinct set)
	- The event encodings for the generalised events may be different

The latter two points I think can be solved in the back-end by making events
affine to a particular PMU type (that is, they are only scheduled when the
profiled task is running on a given PMU type), although I'm not sure how this
will be exposed to userspace yet. It might be nice to register a separate
PMU with perf altogether, but I don't think the userspace tools are there
yet in terms of specifying the destination PMU for an event.

The first point is part of a bigger problem, namely that we can only find
out the PMU topology of the system by probing the device tree. For older
platforms, we will still probe the PMU of the boot CPU by inspecting the ID
registers.

My question is: does the hw perf initialisation really need to be an
early_initcall and, if so, how much of the perf backend needs to be up and
running? It may be that the early initcall assumes all PMUs are the same and
then later on I go and rewrite things like the number of counters.

Of course, any ideas regarding the above are more than welcome!

Cheers,

Will

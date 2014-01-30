From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Thu, 30 Jan 2014 13:43:38 +0000
Subject: Extending OPP bindings
Message-ID: <52EA570A.8040501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am looking into a couple shortcomings in the current OPP bindings and
how to address them. Feel free to add to the list if you think of any more
issues that needs to be addressed or if and how any problem mentioned below
can be handled with the existing bindings.

1. indexing: currently there are no indices in the operating-points.
	It's assumed that the list is either in ascending or descending
	order of frequency but not explicit in the binding document.
	There are arch/arm/boot/dts/* files with opps in both styles.
	Few other bindings like thermal defines bindings like
	cooling-{min,max}-state assuming some order which is broken IMO.

	One such use-case that came up recently[0] is the c-state latencies
	which could be different for each OPP. It would be good if the
	latencies are specified with the indices to OPP table to avoid
	inconsistency between the bindings.

	It's mainly to avoid issues due to inconsistency and duplication
	on data(frequency) in multiple bindings requiring it.

	Once we have indices to each on the OPP entries, then other binding
	using it can refer to OPP with phandle and OPP index/specifier pairs
	very similar to clock provider and consumer.

2. sharing opps: I have tried to address this issue previously[1] but unable
	to conclude yet on this.

3. latencies(*): currently the latency that the CPU/memory access is unavailable
	during an OPP transition is generic i.e. same from any OPP to any
	other OPP. Does it make sense to have this per-OPP entry ?

4. power(*): A measure of maximum power dissipation in an OPP state.
	This might be useful measure for power aware scheduling ?

(*) these are already part of P-state in ACPI(refer struct acpi_processor_px
in include/acpi/processor.h)

Apart from these I have seen on-going discussion for Samsung Exynos CPUFreq[2]
which might have some feedback for OPP bindings.

It would be good to consolidate the shortcomings found so far, that could
help in extending the current OPP bindings.

Regards,
Sudeep

[0] http://www.spinics.net/lists/arm-kernel/msg301971.html
[1] http://www.spinics.net/lists/cpufreq/msg07911.html
[2] http://www.spinics.net/lists/cpufreq/msg09169.html

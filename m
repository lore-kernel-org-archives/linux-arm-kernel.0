From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2016 16:30:07 +0100
Subject: [PATCH 7/8] arm64: pmu: Enable multiple PMUs in an ACPI system
In-Reply-To: <57617268.60705@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-8-git-send-email-jeremy.linton@arm.com>
 <20160615132246.GL24029@arm.com> <57617268.60705@arm.com>
Message-ID: <20160615153007.GR24029@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:21:12AM -0500, Jeremy Linton wrote:
> On 06/15/2016 08:22 AM, Will Deacon wrote:
> >On Thu, Jun 09, 2016 at 05:23:32PM -0500, Jeremy Linton wrote:
> >>Its possible that an ACPI system has multiple CPU types in it
> >>with differing PMU counters. Use the newly provided acpi_pmu routines
> >>to detect that case, and instantiate more than one set of counters.
> >>
> >
> >[...]
> >
> >>+	pmus = kcalloc(num_possible_cpus(), sizeof(struct pmu_types),
> >>+		       GFP_KERNEL);
> >>+
> >>+	if (pmus) {
> >>+		arm_pmu_acpi_determine_cpu_types(pmus);
> >>+
> >>+		for (j = 0; pmus[j].cpu_count; j++) {
> >>+			pr_devel("CPU type %X, count %d\n", pmus[j].cpu_type,
> >>+				 pmus[j].cpu_count);
> >>+			res = kcalloc(pmus[j].cpu_count,
> >>+				      sizeof(struct resource), GFP_KERNEL);
> >
> >Given that you already have dynamic allocation in here, why not use a
> >linked-list for the pmus list, and avoid having a potentially huge temporary
> >data structure?
> 
> Sure... But, its really only going to be 2 entries on any existing system, I
> considered limiting this to something reasonable like "4" with a WARN()
> because who will ever build a machine with more than 4 different CPU types
> in it? <chuckle> Is that an acceptable solution, or do you prefer the list?

I do prefer the list, just because kcalloc(num_possible_cpus(), ...) could
be pretty large, and like you say, we're likely to need 2-3 entries in
practice.

Will

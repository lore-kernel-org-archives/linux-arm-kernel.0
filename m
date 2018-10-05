From: james.morse@arm.com (James Morse)
Date: Fri,  5 Oct 2018 16:02:33 +0100
Subject: [RFC PATCH 0/2] ACPI / PPTT: ids for caches
Message-ID: <20181005150235.13846-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

To get resctrl working on arm64, we need to generate 'id's for caches.
This is this value that shows up in, e.g.:
| /sys/devices/system/cpu/cpu0/cache/index3/id

This value needs to be unique for each level of cache, but doesn't
need to be contiguous. (there may be gaps, it may not start at 0).
Details in Documentation/x86/intel_rdt_ui.txt::Cache IDs

resctrl receives these values back via its schemata file. e.g.:
| echo "L3:0=fff;1=fff" > /sys/fs/resctrl/p1/schemata
Where 0 and 1 are the ids of two caches in the system.

These values become ABI, and are likely to be baked into shell scripts.
We want a value that is the same over reboots, and should be the same
on identical hardware, even if the PPTT is generated in a different
order. The hardware doesn't give us any indication of which caches are
shared, so this information must come from firmware tables.

This series generates an id from the PPTT topology, based on the lowest
MPIDR of the cpus that share a cache.

The remaining problems with this approach are:
 * the 32bit ID field is full of MPIDR.Aff{0-3}. We don't have space to
   hide 'i/d/unified', so can only generate ids for unified caches. If we
   ever get an Aff4 (plenty of RES0 space in there) we can no longer generate
   an id. Having all these bits accounted for in the initial version doesn't
   feel like a good ABI choice.

* Existing software is going to assume caches are numbered 0,1,2. This was
  documented as not guaranteed, and its likely never going to be the case
  if we generate ids like this.

* The table walk is recursive.


Fixes for the first two require extra-code to compact the ID range, which would
require us generating all the IDs up front, not from hotplug callbacks as has
to happen today.

Alternatively, we could try and change the abi to provide a u64 as the
cache id. The size isn't documented, and for resctrl userspace can treat
it as a string.

Better ideas welcome!

Thanks,

James Morse (2):
  ACPI / processor: Add helper to convert acpi_id to a phys_cpuid
  ACPI / PPTT: cacheinfo: Label caches based on fw_token

 arch/arm64/include/asm/acpi.h |  6 +++
 drivers/acpi/pptt.c           | 81 +++++++++++++++++++++++++++++++++++
 drivers/acpi/processor_core.c | 16 +++++++
 include/acpi/processor.h      |  1 +
 4 files changed, 104 insertions(+)

-- 
2.18.0

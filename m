From: seanvk.dev@oregontracks.org (Sean V Kelley)
Date: Tue, 31 Jul 2018 09:49:54 -0700
Subject: ARM PMU ACPI Driver and Mapping Hardware Cache Events for Perf
Message-ID: <1533055794.3985722.1458925912.4DA110B9@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was trying to better understand why in Perf, ARM defined cache events are not getting mapped for an ARMv8  system when my PMU driver is the ARM ACPI one.  In particular I was looking at the following defined cache events listed via perf:

  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-store-misses                             [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  iTLB-loads                                         [Hardware cache event]

Seeing those as implementation defined, and following the model from cavium under pmu-events, I then used the following JSON file to attempt to map those with matching addresses (only picking ones with EventCodes matching my own) :

[
    {
        "ArchStdEvent": "L1D_CACHE_RD",
    },
    {
        "ArchStdEvent": "L1D_CACHE_WR",
    },
    {
        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
    },
    {
        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
    },
    {
        "ArchStdEvent": "L1D_TLB_REFILL_RD",
    },
    {
        "ArchStdEvent": "L1D_TLB_REFILL_WR",
    },
    {
        "ArchStdEvent": "L1D_TLB_RD",
    },
    {
        "ArchStdEvent": "L1D_TLB_WR",
    },
    {
        "ArchStdEvent": "BUS_ACCESS_RD",
   },
   {
        "ArchStdEvent": "BUS_ACCESS_WR",
   }
]

I also added the MIDR to the mapfile csv file.

However, even though, for example, L1D_CACHE_RD has an address ?EventCode? of 0x40, using the string L1-dcache-loads for perf stats doesn?t use 0x40.   Instead it outputs the value of cache-references.  So it appears that L1-dcache-loads is actually getting mapped to something other than the address supplied in the ARM recommended json file ? which I was trying to manually map above.

I understand that for ACPI boot, the ARM PMU CPU framework only supports the standard events for ARM, there is no support for  the custom events of other chips.  However, in the above example, I?m not using custom events.  I?m simply trying to map the ARM standard events and only the standard events whose addresses match myown.  More importantly I?m following the same example used by hisilicon and cavium in the their patches to respective json files for their SoC.

Or am I limited to this JSON feature for only ARM based Device Tree PMU implementations rather an ARM ACPI PMU framework?

Any feedback much appreciated!

Thanks,

Sean
-- 
  Sean V Kelley
  seanvk.dev at oregontracks.org

From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 31 Aug 2017 13:38:03 +0200
Subject: [RFC PATCH v9 0/7] Cavium ARM64 uncore PMU support
In-Reply-To: <20170829131238.4988-1-jglauber@cavium.com>
References: <20170829131238.4988-1-jglauber@cavium.com>
Message-ID: <20170831113803.GF15906@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So what about the general idea with the wrapper, does this look sane?
Any objections to that?

thanks,
Jan

On Tue, Aug 29, 2017 at 03:12:31PM +0200, Jan Glauber wrote:
> I'm posting this as RFC following this discussion:
> https://marc.info/?l=linux-arm-kernel&m=150099526923838&w=2
> 
> I've implemented the wrapper for the PCI devices and put it under
> drivers/soc/cavium which I found more appropriate than drivers/misc.
> 
> I was not able to find a way to build the EDAC driver and the PMU driver
> with all combinations (builtin and module) so I limited the build options
> to module only. The problem is that the select from EDAC or PMU
> sets the wrappers build type to whatever EDAC or PMU choose.
> But all parts must be either built-in or modules, having the wrapper
> builtin and calling into module code will not work. If there is a better
> solution please let me know.
> 
> The PMU code is the same as in v8.
> 
> Add support for various PMU counters found on the Cavium ThunderX and
> OcteonTx SoC.
> 
> The PMU driver provides common "uncore" functions to avoid code duplication
> and support adding more device PMUs (like L2 cache) in the future.
> 
> Changes to v8:
> - Wrapper for PCI devices
> 
> Jan Glauber (7):
>   edac: thunderx: Remove suspend/resume support
>   edac,soc: thunderx: Add wrapper for EDAC LMC PCI device
>   edac,soc: thunderx: Add wrapper for EDAC OCX PCI device
>   perf: export perf_event_update_userpage()
>   perf: cavium: Support memory controller PMU counters
>   perf: cavium: Support transmit-link PMU counters
>   perf: cavium: Add Documentation
> 
>  Documentation/perf/cavium-pmu.txt |  75 +++++
>  drivers/edac/Kconfig              |   3 +
>  drivers/edac/thunderx_edac.c      |  92 +-----
>  drivers/perf/Kconfig              |  15 +
>  drivers/perf/Makefile             |   1 +
>  drivers/perf/cavium_pmu.c         | 680 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/cavium/Kconfig        |  14 +
>  drivers/soc/cavium/Makefile       |   2 +
>  drivers/soc/cavium/cavium_lmc.c   |  53 +++
>  drivers/soc/cavium/cavium_ocx.c   |  49 +++
>  include/linux/cpuhotplug.h        |   1 +
>  include/linux/soc/cavium/lmc.h    |  12 +
>  include/linux/soc/cavium/ocx.h    |  12 +
>  kernel/events/core.c              |   1 +
>  16 files changed, 933 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/perf/cavium-pmu.txt
>  create mode 100644 drivers/perf/cavium_pmu.c
>  create mode 100644 drivers/soc/cavium/Kconfig
>  create mode 100644 drivers/soc/cavium/Makefile
>  create mode 100644 drivers/soc/cavium/cavium_lmc.c
>  create mode 100644 drivers/soc/cavium/cavium_ocx.c
>  create mode 100644 include/linux/soc/cavium/lmc.h
>  create mode 100644 include/linux/soc/cavium/ocx.h
> 
> -- 
> 2.9.0.rc0.21.g7777322

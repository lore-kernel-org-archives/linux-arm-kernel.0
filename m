From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 1 Nov 2017 02:33:52 +0300
Subject: [PATCH 0/2] arm64 SMMUv3 PMU driver with IORT support
In-Reply-To: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20171031233352.5232hzebwek6avzi@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Fri, Aug 04, 2017 at 03:59:12PM -0400, Neil Leeder wrote:
> This adds a driver for the SMMUv3 PMU into the perf framework.
> It includes an IORT update to support PM Counter Groups.
> 
> IORT has no mechanism for determining device names so PMUs
> are named based on their physical address. 
> 
> Tested on Qualcomm QDF2400. perf_fuzzer ran for 4+ hours
> with no failures.
> 
> Neil Leeder (2):
>   acpi: arm64: add iort support for PMCG
>   perf: add arm64 smmuv3 pmu driver
> 
>  drivers/acpi/arm64/iort.c     |  54 +++
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 823 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/actbl2.h         |   9 +-
>  5 files changed, 895 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c

I try to run your driver on ThunderX2, but perf list doesn't show new
events, and example in description in patch 2 also doesn't work:
yury at VAL1-25:~/linux$ tools/perf/perf stat -e smmu_0_ff88840/transaction,filter_enable=1, filter_span=1,filter_stream_id=0x42/ -a pwd
event syntax error: '..ter_enable=1,'
                                  \___ parser error
Run 'perf list' for a list of valid events 

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

I run v4.14-rc7 kernel plus this series. The config is attached. I
found that platform_match() never return 1 for arm-smmu-pmu and so
the driver never probed.

Maybe it's my local configuration issue?

Thanks for any help,
Yury
-------------- next part --------------
A non-text attachment was scrubbed...
Name: t99.config.gz
Type: application/gzip
Size: 35068 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171101/d57e2666/attachment-0001.gz>

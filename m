From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Sat, 13 Jan 2018 15:42:34 -0300
Subject: [PATCH v5] perf tools: Add ARM Statistical Profiling Extensions
 (SPE) support
In-Reply-To: <20180112192737.872407152ac251adccee3f61@arm.com>
References: <20171121173302.bead17a1178ed4583e68014e@arm.com>
 <0a07a10c-fc0c-3f97-ac01-59429aab0937@intel.com>
 <20180112141423.GA9655@kernel.org>
 <20180112192737.872407152ac251adccee3f61@arm.com>
Message-ID: <20180113184234.GK9655@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jan 12, 2018 at 07:27:37PM -0600, Kim Phillips escreveu:
> 'perf record' and 'perf report --dump-raw-trace' supported in this
> release.
> 
> Example usage:
> 
>  # perf record -e arm_spe/ts_enable=1,pa_enable=1/ dd if=/dev/zero of=/dev/null count=10000
>  # perf report --dump-raw-trace
> 
> Note that the perf.data file is portable, so the report can be run on
> another architecture host if necessary.

Failed for these distros:

  10    36.39 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  37    35.28 oraclelinux:6                 : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  39    37.41 ubuntu:12.04.5                : FAIL gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

  CC       /tmp/build/perf/util/arm-spe-pkt-decoder.o
cc1: warnings being treated as errors
util/arm-spe-pkt-decoder.c: In function 'arm_spe_pkt_desc':
util/arm-spe-pkt-decoder.c:277: error: declaration of 'index' shadows a global declaration
/usr/include/string.h:489: error: shadowed declaration is here
mv: cannot stat `/tmp/build/perf/util/.arm-spe-pkt-decoder.o.tmp': No such file or directory
make[4]: *** [/tmp/build/perf/util/arm-spe-pkt-decoder.o] Error 1

Just rename 'index' to 'idx'

  14   110.68 debian:9                      : FAIL gcc (Debian 6.3.0-18) 6.3.0 20170516
  15   115.91 debian:experimental           : FAIL gcc (Debian 7.2.0-17) 7.2.1 20171205
  26   124.97 fedora:25                     : FAIL gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27   126.05 fedora:26                     : FAIL gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28   126.40 fedora:27                     : FAIL gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29   119.77 fedora:rawhide                : FAIL gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  36   127.59 opensuse:tumbleweed           : FAIL gcc (SUSE Linux) 7.2.1 20171020 [gcc-7-branch revision 253932]
  43   106.21 ubuntu:16.04                  : FAIL gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  50   114.48 ubuntu:16.10                  : FAIL gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  51   112.79 ubuntu:17.04                  : FAIL gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  52   115.37 ubuntu:17.10                  : FAIL gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  53   112.14 ubuntu:18.04                  : FAIL gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0
5

  LD       /tmp/build/perf/util/scripting-engines/libperf-in.o
  CC       /tmp/build/perf/util/intel-bts.o
  CC       /tmp/build/perf/util/arm-spe.o
util/arm-spe.c:165:19: error: unused function 'arm_spe_update_queues' [-Werror,-Wunused-function]
static inline int arm_spe_update_queues(struct arm_spe *spe)
                  ^
1 error generated.
mv: cannot stat '/tmp/build/perf/util/.arm-spe.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/arm-spe.o' failed

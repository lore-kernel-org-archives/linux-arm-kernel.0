From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 20 Apr 2017 11:45:36 -0600
Subject: [PATCH RFC 0/4] coresight: support dump ETB RAM
In-Reply-To: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
References: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CANLsYkwCUmJqG1u=S1Nk4A8uqeJdgFL11TbkKav-LBUW1NJHuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2017 at 03:10, Leo Yan <leo.yan@linaro.org> wrote:
>
> ### Introduction ###
>
> Embedded Trace Buffer (ETB) provides on-chip storage of trace data,
> usually has buffer size from 2KB to 8KB. These data has been used for
> profiling and this has been well implemented in coresight driver.
>
> This patch is to explore ETB RAM data for postmortem debugging. Due ETB
> RAM buffer has small size, so the real trace data caused error is
> easily to be overwritten by other PEs; but we could consider ETB RAM
> data is quite useful for postmortem debugging with below scenarios:
>
> Case 1: if system is bus lockup and CPU pipeline stalls for bus
> accessing, CPUs have no more chance to fill enough data into ETB RAM
> so after analyze ETB RAM we can quickly get to know the culprit if bus
> lock is caused by improper programs, one often example is wrongly to
> access the module without enable the module's clock. For this case,
> we can rely on watchdog to trigger SoC reset and if lucky the ETB RAM
> can survive after reset. So for this case, after system reboot we can
> save ETB RAM before any new data input into it.
>
> Case 2: There also has another hardware design with local ETB buffer
> (ARM DDI 0461B) chapter 1.2.7. Local ETF, with this kind design every
> CPU may has one dedicated ETB RAM. So it's quite handy that we can use
> alive CPU to help dump the hang CPU ETB RAM. Then we can quickly get
> to know what's the last point the CPU has executed before its hang.
>
>
> ### Implementation ###
>
> Based on current Coresight ETB driver, we only needs some minor
> enhancement so can support dump ETB RAM with two methods.
>
> Patches 0001/0002 are minor fixes so can support more scenarios for ETB
> RAM dumping.
>
> Patch 0003 is to dump ETB RAM after system reboot, this is for the
> platforms which use watchdog reset and ETB RAM can survive.
>
> Patch 0004 is to dump ETB RAM when panic happens, so we can save ETB RAM
> into memory. If we connect this with Kdump, then we can easily extract
> the ETB RAM from vmcore.
>
>
> ### Usage ###
>
> To dump ETB RAM after reboot, simply use below command:
> # dd if=/dev/f6402000.etf of=cstrace.bin
>
> To dump ETB RAM for kernel panic, we need add "crash_kexec_post_notifiers"
> into kernel command line so let kernel call panic notifiers before launch
> dump kernel. After dump kernel has booted up, we need use below methods
> to ETB RAM offline analysis:
>
> On the target:
> # cp /proc/vmcore ./vmcore
> # scp ./vmcore your at hostpc
>
> On the host PC:
> # ./crash vmcore vmlinux
>
> crash> log
> [...]
> [  112.600051] coresight-tmc f6402000.etf: Flush ETB buffer 0x2000 at 0xffff800038300080
> [  112.614743] Starting crashdump kernel...
> [  112.618681] Bye!
> crash> rd 0xffff800038300080 0x2000 -r /tmp/cstrace.bin
> 8192 bytes copied from 0xffff800038300080 to /tmp/cstrace.bin
>
> After we get cstrace.bin data, we can use OpenCSD snapshot method to parse
> ETB trace data. These two methods have been verified on Hikey, For Hikey
> snapshot config files you can refer [1]. For total kernel patches for
> integration Kdump and Coresight, you can refer [2].
>
> [1] http://people.linaro.org/~leo.yan/opencsd_hikey/hikey_snapshot.tgz
> [2] https://git.linaro.org/people/leo.yan/linux-debug-workshop.git/log/?h=coresight_etb_dump
>
>
> ### TODO ###
>
> Need work for ETB1.0 driver, this is based on review and comments
> for this patch set.

Hi Leo and thank you for this first stab.

The first thing to do is drop the case where trace data are salvaged
from ETB memory after a crash.  This method is not reliable and the
trace data is almost guaranteed to have some sort of corruption since
the debug power domain will be reset by the architecture.  On top of
things it only applies to the ETB.

Also function tmc_enable/disable_etf_sink() can be called hundreds of
times during a trace session.  Inserting and removing the panic
notifier is too much overhead.  The notifier should be added when a
session is started and removed when it ends.

Your patchset doesn't deal with trace configuration, and that is a
serious problem.  Trace data can't be decoded without them.  What we
have for perf [1] is already working well and I would like to avoid
having to parse two different header format.  The header could be
inserted at the beginning of the file that is retreived after a crash
dump.

Last but not least we need to come up with an API to deal with the
kernel crash dump functionality. From there sinks could chose to
simply call the API when they are ready.  All the crash dump specific
stuff happens in the coresight crash dump code while everything
related to the sinks (of any kind) happens in the driver.  Look at
coresight-etm-perf.c for an idea of what I mean.

Regards,
Mathieu

[1]. http://lxr.free-electrons.com/source/tools/perf/util/cs-etm.h
>
>
> Leo Yan (4):
>   coresight: tmc: check dump buffer is overflow
>   coresight: tmc: set read pointer before dump RAM
>   coresight: tmc: dump RAM when device is disabled
>   coresight: tmc: dump RAM for panic
>
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 86 ++++++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h     |  2 +
>  2 files changed, 85 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>

From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 8 Jun 2017 12:23:39 -0600
Subject: [PATCH v1 0/4] coresight: support panic dump functionality
In-Reply-To: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
References: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CANLsYkzx7aO8deFk2a0iZ4jEoLheM7rzbBQFOpL6aj6taPi_AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 June 2017 at 08:42, Leo Yan <leo.yan@linaro.org> wrote:
> ### Introduction ###

Good day Leo,

>
> Embedded Trace Buffer (ETB) provides on-chip storage of trace data,
> usually has buffer size from 2KB to 8KB. These data has been used for
> profiling and this has been well implemented in coresight driver.
>
> This patch set is to explore ETB RAM data for postmortem debugging.
> We could consider ETB RAM data is quite useful for postmortem debugging,
> especially if the hardware design with local ETB buffer (ARM DDI 0461B)
> chapter 1.2.7. 'Local ETF', with this kind design every CPU has one
> dedicated ETB RAM. So it's quite handy that we can use alive CPU to help
> dump the hang CPU ETB RAM. Then we can quickly get to know what's the
> exact execution flow before its hang.
>
> Due ETB RAM buffer has small size, if all CPUs shared one ETB buffer
> then the trace data for causing error is easily to be overwritten by
> other PEs; but even so sometimes we still have chance to go through the
> trace data to assist debugging panic issues.
>
> ### Implementation ###
>
> Firstly we need provide a unified APIs for panic dump functionality, so
> it can be easily extended to enable panic dump for multiple drivers. This
> is finished by patch 0001, it registers panic notifier, and provide the
> general APIs {coresight_add_panic_cb|coresight_del_panic_cb} as helper
> functions so any coresight device can add into dump list or delete itself
> as needed.
>
> Generally all the panic dump specific stuff are related to the sinks
> devices, so this initial version code it only supports sink devices; and
> Patch 0002 is to add and remove panic callback for sink devices.
>
> Patch 0003 and 0004 are to add panic callback functions for tmc and etb10
> drivers; so these two drivers can save specific trace data when panic
> happens.
>
> NOTE: patch 0003 for tmc driver panic callback which has been verified on
> Hikey board. patch 0004 for etb10 has not been tested due lack hardware
> in hand.
>
> ### Usage ###

On top of my comments in the patches I think this section is
interesting and worth its own text file under Documentation.  We
already have coresight.txt and coresight-cpu-debug.txt...  As such I
suggest you add a new "coresight" directory under Documentation/trace
and move coresight.txt and coresight-cpu-debug.txt there.  Once that
is done you can add coresight-panic-dump.txt there.

>
> Below are the example for how to use panic dump functionality on 96boards
> Hikey, the brief flow is: when the panic happens the ETB panic callback
> function saves trace data into memory, then relies on kdump to use
> recovery kernel to save DDR content as kernel core dump file; after we
> transfer kernel core dump file from board to host PC, use 'crash' tool to
> extract the coresight ETB trace data; finally we can use python script
> to generate perf format compatible file and use 'perf' to output the
> readable execution flow.
>
> - Save trace data into memory with kdump on Hikey:
>
>   ARM64's kdump supports to use the same kernel image both for main
>   kernel and dump-capture kernel; so we can simply to load dump-capture
>   kernel with below command:
>   ./kexec -p vmlinux --dtb=hi6220-hikey.dtb --append="root=/dev/mmcblk0p9
>   rw  maxcpus=1 reset_devices earlycon=pl011,0xf7113000 nohlt
>   initcall_debug console=tty0 console=ttyAMA3,115200 clk_ignore_unused"
>
>   Enable the coresight path for ETB device:
>   echo 1 > /sys/bus/coresight/devices/f6402000.etf/enable_sink
>   echo 1 > /sys/bus/coresight/devices/f659c000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f659d000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f659e000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f659f000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f65dc000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f65dd000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f65de000.etm/enable_source
>   echo 1 > /sys/bus/coresight/devices/f65df000.etm/enable_source
>
> - After kernel panic happens, the kdump launches dump-capture kernel;
>   so we need save kernel's dump file on target:
>   cp /proc/vmcore ./vmcore
>
>   After we download vmcore file from Hikey board to host PC, we can
>   use 'crash' tool to check coresight dump info and extract trace data:
>   crash vmlinux vmcore
>   crash> log
>   [   37.559337] coresight f6402000.etf: invoke panic dump...
>   [   37.565460] coresight-tmc f6402000.etf: Dump ETB buffer 0x2000 at 0xffff80003b8da180
>   crash> rd 0xffff80003b8da180 0x2000 -r cs_etb_trace.bin
>
> - Use python script perf_cs_dump_wrapper.py to wrap trace data for
>   perf format compatible file and finally use perf to output CPU
>   execution flow:
>
>   On host PC run python script, please note now this script is not flexbile
>   to support all kinds of coresight topologies, this script still has hard coded
>   info related with coresight specific topology in Hikey:
>   python perf_cs_dump_wrapper.py -i cs_etb_trace.bin -o perf.data

I'm not sure what we'll do with "perf_cs_dump_wrapper.py" yet...  I
suspect openCSD on github will be a good place for it but let's see
about that later.

Regards,
Mathieu

>
>   On Hikey board:
>   ./perf script -v -F cpu,event,ip,sym,symoff --kallsyms ksymbol -i perf.data -k vmlinux
>
>   [002]          instructions:  ffff0000087d1d60 psci_cpu_suspend_enter+0x48
>   [002]          instructions:  ffff000008093400 cpu_suspend+0x0
>   [002]          instructions:  ffff000008093210 __cpu_suspend_enter+0x0
>   [002]          instructions:  ffff000008099970 cpu_do_suspend+0x0
>   [002]          instructions:  ffff000008093294 __cpu_suspend_enter+0x84
>   [002]          instructions:  ffff000008093428 cpu_suspend+0x28
>   [002]          instructions:  ffff00000809342c cpu_suspend+0x2c
>   [002]          instructions:  ffff0000087d1968 psci_suspend_finisher+0x0
>   [002]          instructions:  ffff0000087d1768 psci_cpu_suspend+0x0
>   [002]          instructions:  ffff0000087d19f0 __invoke_psci_fn_smc+0x0
>
> Have uploaded related tools into folder:
> http://people.linaro.org/~leo.yan/debug/coresight_dump/
>
> Changes from RFC:
> * Follow Mathieu's suggestion, use general framework to support dump
>   functionality.
> * Changed to use perf to analyse trace data.
>
> Leo Yan (4):
>   coresight: support panic dump functionality
>   coresight: add and remove panic callback for sink
>   coresight: tmc: hook panic callback for ETB/ETF
>   coresight: etb10: hook panic callback
>
>  drivers/hwtracing/coresight/Kconfig                |  10 ++
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  drivers/hwtracing/coresight/coresight-etb10.c      |  16 +++
>  drivers/hwtracing/coresight/coresight-panic-dump.c | 130 +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-priv.h       |  10 ++
>  drivers/hwtracing/coresight/coresight-tmc-etf.c    |  26 +++++
>  drivers/hwtracing/coresight/coresight.c            |  11 ++
>  include/linux/coresight.h                          |   2 +
>  8 files changed, 206 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-panic-dump.c
>
> --
> 2.7.4
>

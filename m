From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 5 Jun 2017 09:57:39 +0100
Subject: [PATCH v1 0/4] coresight: support panic dump functionality
In-Reply-To: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
References: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
Message-ID: <0b3d9f68-e8a2-b990-0c27-efa9e862f58b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/17 15:42, Leo Yan wrote:
> ### Introduction ###
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

> - After kernel panic happens, the kdump launches dump-capture kernel;
>   so we need save kernel's dump file on target:
>   cp /proc/vmcore ./vmcore


>   After we download vmcore file from Hikey board to host PC, we can
>   use 'crash' tool to check coresight dump info and extract trace data:
>   crash vmlinux vmcore
>   crash> log
>   [   37.559337] coresight f6402000.etf: invoke panic dump...
>   [   37.565460] coresight-tmc f6402000.etf: Dump ETB buffer 0x2000 at 0xffff80003b8da180
>   crash> rd 0xffff80003b8da180 0x2000 -r cs_etb_trace.bin
>

Have you explored appending the above information as a vmcoreinfo parameter via
vmcoreinfo_append_str() ? That would make it easier to list all the information
above and if needed, we may be able to extend the makedumpfile to dump the ETB
dumps from a given vmcore.
  
Suzuki

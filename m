From: rabin@rab.in (Rabin Vincent)
Date: Mon, 10 Aug 2015 21:31:16 +0200
Subject: Problem with ftrace uprobes on ARM
In-Reply-To: <55C8E417.7080607@techfak.uni-bielefeld.de>
References: <55C8E417.7080607@techfak.uni-bielefeld.de>
Message-ID: <20150810193116.GA2895@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 07:49:11PM +0200, Christian Ascheberg wrote:
> # objdump -t benchmark | grep "calc_sum"
> 00008574 g     F .text    00000020              calc_sum
> 
> # echo 'p /home/root/benchmark:0x8574' >
> /sys/kernel/debug/tracing/uprobe_events
> 
> # echo 1 >
> /sys/kernel/debug/tracing/events/uprobes/p_benchmark_0x8574/enable
> -sh: echo: write error: Invalid argument

The offset of the instruction in the file should be used, not the virtual
address.  For example, in the following example ls_main() is at 0x0009aec0 but
to set the breakpoint one actually has to use 0x92ec0:

$ arm-none-linux-gnueabi-nm busybox_unstripped | grep ls_main
0009aec0 T ls_main

$ arm-none-linux-gnueabi-objdump -F -d busybox_unstripped | grep '<ls_main>'
0009aec0 <ls_main> (File Offset: 0x92ec0):

By the way, I hope "benchmark" does not use Thumb instructions, because
uprobes on those aren't supported.  See arch_uprobe_analyze_insn().

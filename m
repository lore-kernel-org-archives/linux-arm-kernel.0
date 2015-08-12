From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Aug 2015 10:53:50 +0100
Subject: How to support multiple watchpoints on kernel after 3.10 when
 using arm debug architectures prior to 7.1?
In-Reply-To: <55CABA0F.9020901@huawei.com>
References: <55CABA0F.9020901@huawei.com>
Message-ID: <20150812095350.GI22485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 04:14:23AM +0100, long.wanglong wrote:
> The linux kernel after 3.10 (after the commit c512de95 "ARM:
> hw_breakpoint: reserve one breakpoint for watchpoint stepping" )
> reserve a single breakpoint, regardless of the number of watchpoints,
> when the hardware use the ARM Debug architectures prior to 7.1.
> 
> On these older CPUS, how to support multiple watchpoints when
> using kernel after 3.10?
> 
> Are there any risks if we change the function 'get_num_wrps(void)'
> and force it returning the number of watchpoints the hardware have?

Please read the comment in the file:

	/*
	 * On debug architectures prior to 7.1, when a watchpoint fires, the
	 * only way to work out which watchpoint it was is by disassembling
	 * the faulting instruction and working out the address of the memory
	 * access.
	 *
	 * Furthermore, we can only do this if the watchpoint was precise
	 * since imprecise watchpoints prevent us from calculating register
	 * based addresses.
	 *
	 * Providing we have more than 1 breakpoint register, we only report
	 * a single watchpoint register for the time being. This way, we always
	 * know which watchpoint fired. In the future we can either add a
	 * disassembler and address generation emulator, or we can insert a
	 * check to see if the DFAR is set on watchpoint exception entry
	 * [the ARM ARM states that the DFAR is UNKNOWN, but experience shows
	 * that it is set on some implementations].
	 */

So you need to write a disassembler + partial emulator (to compute
addresses) for all memory access instructions (including neon and vfp)
so that you can figure out which handler to call when you get a debug
exception. The mismatched stepping code would also need some work to
deal with overlapping watchpoints correctly so that we don't get stuck.

A hackier way is to probe whether or not the DFAR appears to be set
correctly on a watchpoint exception and use it anyway, but I'd definitely
want a way to disable that.

It's annoying, because sending a SIGTRAP to GDB is probably the common
case and userspace might be able to figure things out, but we can't make
that assumption in general since we can have multiple clients (e.g. perf)
owning different watchpoints.

As I've said before, divorcing the ptrace interface to hw_breakpoint
from perf would probably help somewhat, but it's a tricky challenge.

Will

From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 13 Apr 2010 09:37:40 +0300
Subject: [RFC 09/10] arm: implement reserve memory early parameter
In-Reply-To: <20100412210521.GW3048@n2100.arm.linux.org.uk>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<20100412210521.GW3048@n2100.arm.linux.org.uk>
Message-ID: <20100413063740.GB21896@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 11:05:21PM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Mar 29, 2010 at 12:26:35PM +0300, Mika Westerberg wrote:
> > Implemented mem=size$start early parameter which makes it possible to reserve
> > some memory from the kernel. This can be used for dump capture kernels to
> > preserve any memory used by the primary kernel.
> 
> Please note that if we move ARM over to LMB, these patches will have to
> be redone.

Yes.

> However, I'm not sure why this is required - it appears that x86 doesn't
> require this kind of feature.  Can you explain in more detail how this
> new parameter format would be used?

Well the idea is to preserve memory used by the primary kernel so that the dump
capture kernel is not allowed to use it.

When dump capture kernel is loaded with kexec (a userspace program) it goes
through system RAM found in /proc/iomem and marks all segments that are not
reserved for crash kernel as being reserved. This marking is done by
constructing kernel command line containing something like:

	mem=32M at 2112M mem=64M$2048M mem=160M$2144M mem=256M$2304M

Here the last 3 parameters are those that tell the dump capture kernel what
memory belongs to the primary kernel.

I actually tried to use only mem=32 at 2112M parameter but somehow the dump capture
kernel fails to boot. I couldn't find any reason for that, but it might be that
there is something I missed.

I get following when I start the kernel with only mem=32 at 2112M (the kernel is
linked to 0xc4000000):

<6>PID hash table entries: 128 (order: -3, 512 bytes)
<6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
<6>allocated 163840 bytes of page_cgroup
<6>please try 'cgroup_disable=memory' option if you don't want memory cgroups
<1>BUG: Bad page state in process swapper  pfn:84000
<1>Unhandled fault: alignment exception (0x001) at 0xfffffffb
<0>Internal error: : 1 [#1] PREEMPT
<0>last sysfs file: 
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.32.10-10448-g59e4695-dirty #12)
PC is at bad_page+0xe8/0x13c
LR is at 0x0
pc : [<c409fb9c>]    lr : [<00000000>]    psr: 00000193
sp : c44b7ed0  ip : c44b7e30  fp : c44b7ef4
r10: 00000000  r9 : 00080000  r8 : 7ffffbff
r7 : 00084000  r6 : 00080000  r5 : c45bd000  r4 : ffffffbf
r3 : fffffff7  r2 : 7fbffbff  r1 : c45bd000  r0 : c44544ee
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 84004019  DAC: 00000017
<0>Process swapper (pid: 0, stack limit = 0xc44b62e8)
<0>Stack: (0xc44b7ed0 to 0xc44b8000)
<0>7ec0:                                     c44cb004 0000087f c44b7f0c c44b7ee8
<0>7ee0: c45bd000 7ffffbff c44b7f1c c44b7ef8 c40a0a18 c409fac0 00000000 00000001
<0>7f00: 00080000 00084000 c402c0cc 00000001 c44b7f2c c44b7f20 c40a0c24 c40a09b4
<0>7f20: c44b7f44 c44b7f30 c40a0c60 c40a0c1c 00000007 00000001 c44b7f54 c44b7f48
<0>7f40: c4029134 c40a0c34 c44b7f9c c44b7f58 c4016c9c c40290c0 c44b7fa4 00002000
<0>7f60: 00000000 00000001 00086000 00080000 413fc082 00000000 c451f830 c402ae14
<0>7f80: c44ba62c 840291ec 413fc082 0000001f c44b7fac c44b7fa0 c4016dc4 c4016b78
<0>7fa0: c44b7fcc c44b7fb0 c400c43c c4016dbc c402ae18 c44fa140 c402ae18 c44fa140
<0>7fc0: c44b7ff4 c44b7fd0 c40089ec c400c35c c4008674 00000000 00000000 c402ae18
<0>7fe0: 10c53c7d c44fa4b0 00000000 c44b7ff8 84008034 c40088d4 00000000 00000000
Backtrace: 
[<c409fab4>] (bad_page+0x0/0x13c) from [<c40a0a18>] (free_hot_cold_page+0x70/0x22c)
 r5:7ffffbff r4:c45bd000
[<c40a09a8>] (free_hot_cold_page+0x0/0x22c) from [<c40a0c24>] (free_hot_page+0x14/0x18)
[<c40a0c10>] (free_hot_page+0x0/0x18) from [<c40a0c60>] (__free_pages+0x38/0x44)
[<c40a0c28>] (__free_pages+0x0/0x44) from [<c4029134>] (__free_pages_bootmem+0x80/0x84)
 r5:00000001 r4:00000007
[<c40290b4>] (__free_pages_bootmem+0x0/0x84) from [<c4016c9c>] (free_all_bootmem_core+0x130/0x224)
[<c4016b6c>] (free_all_bootmem_core+0x0/0x224) from [<c4016dc4>] (free_all_bootmem_node+0x14/0x18)
[<c4016db0>] (free_all_bootmem_node+0x0/0x18) from [<c400c43c>] (mem_init+0xec/0x208)
[<c400c350>] (mem_init+0x0/0x208) from [<c40089ec>] (start_kernel+0x124/0x2cc)
 r5:c44fa140 r4:c402ae18
[<c40088c8>] (start_kernel+0x0/0x2cc) from [<84008034>] (0x84008034)

Thanks,
MW

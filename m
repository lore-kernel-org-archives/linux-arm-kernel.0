From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 19 Oct 2016 10:51:24 +0800
Subject: [PATCH v2] arm64: kernel: numa: fix ACPI boot cpu numa node
 mapping
In-Reply-To: <728ef882-b1ee-9518-d291-ee475e9006eb@linaro.org>
References: <20161017145649.6189-1-lorenzo.pieralisi@arm.com>
 <728ef882-b1ee-9518-d291-ee475e9006eb@linaro.org>
Message-ID: <5806DFAC.7090503@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/18 16:39, Hanjun Guo wrote:
> On 2016/10/17 22:56, Lorenzo Pieralisi wrote:
>> Commit 7ba5f605f3a0 ("arm64/numa: remove the limitation that cpu0 must
>> bind to node0") removed the numa cpu<->node mapping restriction whereby
>> logical cpu 0 always corresponds to numa node 0; removing the
>> restriction was correct, in that it does not really exist in practice
>> but the commit only updated the early mapping of logical cpu 0 to its
>> real numa node for the DT boot path, missing the ACPI one, leading to
>> boot failures on ACPI systems owing to missing cpu<->node map for
>> logical cpu 0.
>>
>> Fix the issue by updating the ACPI boot path with code that carries out
>> the early cpu<->node mapping also for the boot cpu (ie cpu 0), mirroring
>> what is currently done in the DT boot path.
>>
>> Fixes: 7ba5f605f3a0 ("arm64/numa: remove the limitation that cpu0 must bind to node0")
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Thanks for the quick response and fix,
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> By the way, I got another boot failure [1] when we have multi
> NUMA nodes system with some memory-less nodes (only one node
> have memory), we are looking into it now, this patch needs
> to be merged first.
You should apply my numa MEMORYLESS patches first, because the two patches have not been upstreamed yet.
I just tested it base on 4.9-rc1 for dt numa, it worked well. I will connect you to check what's wrong on ACPI numa.

> 
> Thanks
> Hanjun
> 
> [1]: boot failure log:
> [    0.000000] NUMA: Adding memblock [0x0 - 0x3fffffff] on node 0
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x3fffffff]
> [    0.000000] NUMA: Adding memblock [0x1400000000 - 0x17ffffffff] on node 1
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x1400000000-0x17ffffffff]
> [    0.000000] NUMA: Adding memblock [0x1000000000 - 0x13ffffffff] on node 0
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0x13ffffffff]
> [    0.000000] NUMA: Initmem setup node 0 [mem 0x00000000-0x13fbffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x13fbffe500-0x13fbffffff]
> [    0.000000] NUMA: Initmem setup node 1 [mem 0x1400000000-0x17fbffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbfec500-0x17fbfedfff]
> [    0.000000] NUMA: Initmem setup node 2 [mem 0x00000000-0xffffffffffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbfeaa00-0x17fbfec4ff]
> [    0.000000] NUMA: NODE_DATA(2) on node 1
> [    0.000000] NUMA: Initmem setup node 3 [mem 0x00000000-0xffffffffffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbfe8f00-0x17fbfea9ff]
> [    0.000000] NUMA: NODE_DATA(3) on node 1
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000017fbffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000000024fff]
> [    0.000000]   node   0: [mem 0x0000000000026000-0x00000000319dffff]
> [    0.000000]   node   0: [mem 0x00000000319e0000-0x0000000031a4ffff]
> [    0.000000]   node   0: [mem 0x0000000031a50000-0x0000000031b2ffff]
> [    0.000000]   node   0: [mem 0x0000000031b30000-0x0000000031b3ffff]
> [    0.000000]   node   0: [mem 0x0000000031b40000-0x0000000039baffff]
> [    0.000000]   node   0: [mem 0x0000000039bb0000-0x000000003a143fff]
> [    0.000000]   node   0: [mem 0x000000003a144000-0x000000003f12ffff]
> [    0.000000]   node   0: [mem 0x000000003f130000-0x000000003f15ffff]
> [    0.000000]   node   0: [mem 0x000000003f160000-0x000000003fbfffff]
> [    0.000000]   node   0: [mem 0x0000001040000000-0x00000013fbffffff]
> [    0.000000]   node   1: [mem 0x0000001400000000-0x00000017fbffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000013fbffffff]
> [    0.000000] Initmem setup node 1 [mem 0x0000001400000000-0x00000017fbffffff]
> [    0.000000] Could not find start_pfn for node 2
> [    0.000000] Initmem setup node 2 [mem 0x0000000000000000-0x0000000000000000]
> [    0.000000] Could not find start_pfn for node 3
> [    0.000000] Initmem setup node 3 [mem 0x0000000000000000-0x0000000000000000]
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at mm/percpu.c:1916!
> [    0.000000] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.0-rc1-00083-g3dd62e5 #680
> [    0.000000] Hardware name: Hisilicon Hi1616 Evaluation Board (DT)
> [    0.000000] task: ffff000008d5e980 task.stack: ffff000008d50000
> [    0.000000] PC is at pcpu_embed_first_chunk+0x464/0x754
> [    0.000000] LR is at pcpu_embed_first_chunk+0x3f8/0x754
> [    0.000000] pc : [<ffff000008c65af0>] lr : [<ffff000008c65a84>] pstate: 200000c5
> [    0.000000] sp : ffff000008d53e90
> [    0.000000] x29: ffff000008d53e90 [    0.000000] x28: 0000000000000000
> [    0.000000]
> [    0.000000] x27: ffff000008d55e50 [    0.000000] x26: 0000000000000042
> [    0.000000]
> [    0.000000] x25: ffff000008d55d28 [    0.000000] x24: 0000000000000046
> [    0.000000]
> [    0.000000] x23: 0000000000000040 [    0.000000] x22: ffff8017fbfcff00
> [    0.000000]
> [    0.000000] x21: ffff000008ca6e20 [    0.000000] x20: ffff8017fbfd0518
> [    0.000000]
> [    0.000000] x19: 0000000000000042 [    0.000000] x18: ffff000008e3fb60
> [    0.000000]
> [    0.000000] x17: 000000000000001b [    0.000000] x16: 000000000000000b
> [    0.000000]
> [    0.000000] x15: 0000001400000000 [    0.000000] x14: 0000000000000004
> [    0.000000]
> [    0.000000] x13: 0000000000000000 [    0.000000] x12: 0000000000000069
> [    0.000000]
> [    0.000000] x11: 00000017fbffff00 [    0.000000] x10: 0000000000000004
> [    0.000000]
> [    0.000000] x9 : 0000000000000000 [    0.000000] x8 : ffff8017fbfd0f00
> [    0.000000]
> [    0.000000] x7 : 0000000000000000 [    0.000000] x6 : 0000000000000000
> [    0.000000]
> [    0.000000] x5 : 0000000000000000 [    0.000000] x4 : 000000000000003f
> [    0.000000]
> [    0.000000] x3 : 0000000000000040 [    0.000000] x2 : 0000000000000040
> [    0.000000]
> [    0.000000] x1 : 0000000000000001 [    0.000000] x0 : ffff000008ca7328
> [    0.000000]
> [    0.000000]
> [    0.000000] Process swapper (pid: 0, stack limit = 0xffff000008d50020)
> [    0.000000] Stack: (0xffff000008d53e90 to 0xffff000008d54000)
> [    0.000000] 3e80:                                   ffff000008d53f60 ffff000008c5616c
> [    0.000000] 3ea0: ffff000008ca5a08 ffff000008e2a000 ffff000008e2a000 ffff000008d55000
> [    0.000000] 3ec0: ffff000008ca5a08 ffff8017fbfffe80 0000000000000168 000000003c96a518
> [    0.000000] 3ee0: 000000003c971b98 0000000000c50018 ffff000008d53f60 ffff000008c56078
> [    0.000000] 3f00: ffff000008d1f000 ffff000008d14000 0000000000007480 0000000000002000
> [    0.000000] 3f20: ffff000008c560b0 0000000000001000 ffff000008d55e50 ffff000008d55d28
> [    0.000000] 3f40: ffff000008ca6000 0000000000000040 0000000000000001 0000000000000040
> [    0.000000] 3f60: ffff000008d53fa0 ffff000008c508d4 ffff000008ca5a08 ffff000008e2a000
> [    0.000000] 3f80: ffff000008e2a000 ffff000008d55000 ffff000008ca5a08 ffff000008c508d0
> [    0.000000] 3fa0: ffff000008d53ff0 ffff000008c501d8 000000003c94fa98 000000001e400000
> [    0.000000] 3fc0: 000000001e400000 000000025497ba19 0000000000000000 000000003f198a08
> [    0.000000] 3fe0: 0000000000000000 ffff000008ca5a08 0000000000000000 00000000008a325c
> [    0.000000] Call trace:
> [    0.000000] Exception stack(0xffff000008d53cc0 to 0xffff000008d53df0)
> [    0.000000] 3cc0: 0000000000000042 0001000000000000 ffff000008d53e90 ffff000008c65af0
> [    0.000000] 3ce0: ffff000008d53d30 ffff0000081aa024 0000000000000001 0000000000001000
> [    0.000000] 3d00: ffff000008d53d30 ffff0000081aa034 0000000000000001 0000000000001000
> [    0.000000] 3d20: 00000017fbfcff00 0000000000000004 ffff000008d53d90 ffff0000081aa2c8
> [    0.000000] 3d40: 00000017fbfcff00 0000000000001000 0000000000000000 0000000000000000
> [    0.000000] 3d60: ffff000008ca7328 0000000000000001 0000000000000040 0000000000000040
> [    0.000000] 3d80: 000000000000003f 0000000000000000 0000000000000000 0000000000000000
> [    0.000000] 3da0: ffff8017fbfd0f00 0000000000000000 0000000000000004 00000017fbffff00
> [    0.000000] 3dc0: 0000000000000069 0000000000000000 0000000000000004 0000001400000000
> [    0.000000] 3de0: 000000000000000b 000000000000001b
> [    0.000000] [<ffff000008c65af0>] pcpu_embed_first_chunk+0x464/0x754
> [    0.000000] [<ffff000008c5616c>] setup_per_cpu_areas+0x3c/0xcc
> [    0.000000] [<ffff000008c508d4>] start_kernel+0x10c/0x398
> [    0.000000] [<ffff000008c501d8>] __primary_switched+0x5c/0x64
> [    0.000000] Code: 0b000318 17ffffd8 6b17031f 54000080 (d4210000)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> 
> 
> .
> 

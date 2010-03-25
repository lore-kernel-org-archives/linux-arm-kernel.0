From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 17:46:45 -0000
Subject: [PATCH] ARM: Fix virtual kernel memory printing for sparsemem
In-Reply-To: <1269532886.10064.31.camel@e102109-lin.cambridge.arm.com>
References: <20100325145324.12837.85927.stgit@e102109-lin.cambridge.arm.com>	
	<20100325151030.GD6590@n2100.arm.linux.org.uk>	
	<1269530669.10064.28.camel@e102109-lin.cambridge.arm.com>	
	<20100325153043.GE6590@n2100.arm.linux.org.uk>
	<1269532886.10064.31.camel@e102109-lin.cambridge.arm.com>
Message-ID: <000b01cacc43$237d4d90$6a77e8b0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > And show_mem() ?  It seems to suffer from the same problem.
> 
> And that's a patch which fixes both (but as you said, it would be good
> if more people test it on various platforms).
> 
> 
> ARM: Fix kernel memory printing for sparsemem
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The show_mem() and mem_init() function are assuming that the page map is
> contiguous and calculates the start and end page of a bank using (map +
> pfn). This fails with SPARSEMEM where pfn_to_page() must be used.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <Will.Deacon@arm.com>
> Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Right - I tried calling show_mem() after the Kernel has booted up [I hacked
c_show() so that it calls show_mem() at the end then I executed cat /proc/cpuinfo].
This causes a page fault from an unaligned address [see bottom of email].

This was on a dual core Realview PBX-A9 with SPARSEMEM enabled. Catalin's patch
for mem_init() and show_mem() fixed the problem for me.

Tested-by: Will Deacon <will.deacon@arm.com>

Will


dhcp-dualA9:~# cat /proc/cpuinfo
[  118.928349] Mem-info:
[  118.935545] DMA per-cpu:
[  118.943316] CPU    0: hi:   90, btch:  15 usd:  85
[  118.957840] CPU    1: hi:   90, btch:  15 usd:   0
[  118.972374] Normal per-cpu:
[  118.980895] CPU    0: hi:  186, btch:  31 usd:  82
[  118.995414] CPU    1: hi:  186, btch:  31 usd:  62
[  119.010071] active_anon:494 inactive_anon:0 isolated_anon:0
[  119.010132]  active_file:930 inactive_file:1205 isolated_file:0
[  119.010191]  unevictable:0 dirty:21 writeback:0 unstable:0
[  119.010245]  free:254401 slab_reclaimable:111 slab_unreclaimable:323
[  119.010304]  mapped:646 shmem:0 pagetables:47 bounce:0
[  119.095992] DMA free:256512kB min:1024kB low:1280kB high:1536kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:260096kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[  119.205958] lowmem_reserve[]: 0 752 752
[  119.217943] Normal free:761092kB min:3028kB low:3784kB high:4540kB active_anon:1976kB inactive_anon:0kB active_file:3720kB inactive_file:4820kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:770048kB mlocked:0kB dirty:84kB writeback:0kB mapped:2584kB shmem:0kB slab_reclaimable:444kB slab_unreclaimable:1292kB kernel_stack:400kB pagetables:188kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[  119.334480] lowmem_reserve[]: 0 0 0
[  119.345253] DMA: 2*4kB 1*8kB 1*16kB 3*32kB 2*64kB 2*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 62*4096kB = 256512kB
[  119.376667] Normal: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 2*256kB 1*512kB 2*1024kB 2*2048kB 184*4096kB = 761084kB
[  119.409122] 2136 total pagecache pages
[  119.592380] Unable to handle kernel paging request at virtual address dc6e6be9
[  119.614377] pgd = bf484000
[  119.622723] [dc6e6be9] *pgd=00000000
[  119.633705] Internal error: Oops: 5 [#1] SMP
[  119.646557] last sysfs file: 
[  119.655487] Modules linked in:
[  119.664736] CPU: 0    Not tainted  (2.6.34-rc2 #4)
[  119.679291] PC is at show_mem+0xc0/0x174
[  119.691106] LR is at 0x24000
[  119.699825] pc : [<80031fe0>]    lr : [<00024000>]    psr: 60000013
[  119.699888] sp : bf491ec0  ip : 90002000  fp : 00000001
[  119.734386] r10: 00000003  r9 : 91202000  r8 : dc6e6be5
[  119.750127] r7 : 0002eefd  r6 : 000003b2  r5 : 0000010f  r4 : 00000149
[  119.769785] r3 : 91002160  r2 : 00000002  r1 : 0003000c  r0 : 803aed64
[  119.789457] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  119.810950] Control: 10c53c7d  Table: 8f48404a  DAC: 00000015
[  119.828256] Process cat (pid: 790, stack limit = 0xbf4902f8)
[  119.845303] Stack: (0xbf491ec0 to 0xbf492000)
[  119.858487] 1ec0: bff2a060 803aeae0 802b1340 000aa000 0000008b 00000001 bffd9c80 8002b680
[  119.883152] 1ee0: 803aeaf0 00000001 bff2a060 00015000 00000400 bf491f80 00000000 800c55ec
[  119.907816] 1f00: 00014030 bff2a088 2abf5034 800284d4 00000000 00000000 f000010e bfc1f4e0
[  119.932480] 1f20: bffd9c80 bf491f80 00000400 00015000 bf490000 bfc1f528 00000000 800e7e98
[  119.957146] 1f40: bf491f80 00000400 bffd9c80 00015000 bf491f80 00000400 00000000 800accc0
[  119.981806] 1f60: bffd9c80 00015000 bffd9c80 00015000 00000000 00000000 00000400 800ace14
[  120.006464] 1f80: 00000000 00000000 00000400 00000000 00000400 00015000 00015000 00000003
[  120.031129] 1fa0: 800292a8 80029100 00000400 00015000 00000003 00015000 00000400 00015000
[  120.055788] 1fc0: 00000400 00015000 00015000 00000003 7fffe000 00000000 2aad0000 00000000
[  120.080457] 1fe0: 00000003 7e8e8ba8 0000ad20 2ab84c0c 60000010 00000003 e7911103 e1a00008
[  120.105197] [<80031fe0>] (show_mem+0xc0/0x174) from [<8002b680>] (c_show+0x1cc/0x22c)
[  120.128879] [<8002b680>] (c_show+0x1cc/0x22c) from [<800c55ec>] (seq_read+0x1bc/0x428)
[  120.152869] [<800c55ec>] (seq_read+0x1bc/0x428) from [<800e7e98>] (proc_reg_read+0x94/0xa8)
[  120.178112] [<800e7e98>] (proc_reg_read+0x94/0xa8) from [<800accc0>] (vfs_read+0xa8/0x150)
[  120.203052] [<800accc0>] (vfs_read+0xa8/0x150) from [<800ace14>] (sys_read+0x3c/0x68)
[  120.226772] [<800ace14>] (sys_read+0x3c/0x68) from [<80029100>] (ret_fast_syscall+0x0/0x30)
[  120.251964] Code: e20ee909 e35e0909 0593800c 11a08003 (e5988004) 
[  120.270706] ---[ end trace 8e8702d3596a05ac ]---

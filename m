From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 08 Sep 2015 19:01:00 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150906235414.GQ21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 7 Sep 2015 00:54:15 +0100")
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
 <20150906235414.GQ21084@n2100.arm.linux.org.uk>
Message-ID: <877fo0x2ur.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> Gah, silly me. But even with [1], I still get an error [2]. I have a
>> confirmation that I have a "Page Permission" fault on the
>> probe_kernel_address().
>
> Hmm, that's not right.  If it's the DACR, then it should be a page domain
> fault, not a page permission fault.
>
>> [2] Oops
>> ========
>> # insmod /tmp/unalign.ko 
>> RJK1: fsr=23 far=e1c23643 dacr=51
>> RJK2: fsr=23 far=e1c23643 dacr=51
>> RJK3: fsr=2f far=bf00202c dacr=51
>> RJK: fault=4 instr=0x00000000 instrptr=bf00202c
>
> Can you add a show_pte(current->mm, instrptr) to dump those page
> table entries please?
Most certainly, here we go :

# insmod /tmp/unalign.ko 
RJK1: fsr=23 far=e1c1f743 dacr=51
RJK2: fsr=23 far=e1c1f743 dacr=51
pgd = e1cc4000
[bf00202c] *pgd=c1cab851, *pte=c1cb504f, *ppte=c1cb501f
RJK3: fsr=2f far=bf00202c dacr=51
RJK4: fault=4 instr=0x00000000 instrptr=bf00202c
pgd = e1cc4000
[bf00202c] *pgd=c1cab851, *pte=c1cb504f, *ppte=c1cb501f

Unable to handle kernel paging request at virtual address e1c1f743
pgd = e1cc4000
[e1c1f743] *pgd=c1c0044e(bad)
Internal error: Oops: 823 [#1] ARM
Modules linked in: unalign(+)
CPU: 0 PID: 608 Comm: insmod Not tainted 4.2.0-rc8-next-20150828-cm-x300+ #926
Hardware name: CM-X300 module
task: e1c68380 ti: e1c84000 task.ti: e1c84000
PC is at u_init+0x2c/0x40 [unalign]
LR is at u_init+0x14/0x40 [unalign]
pc : [<bf00202c>]    lr : [<bf002014>]    psr: a0000013
sp : e1c85df8  ip : e1c1f700  fp : 1e3e041c
r10: e1c1fc00  r9 : 00000001  r8 : 00000000
r7 : bf002000  r6 : e1cad660  r5 : c0b85b80  r4 : c0b85b80
r3 : e1c1f740  r2 : 00000004  r1 : a0000013  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: c1cc4018  DAC: 00000051
Process insmod (pid: 608, stack limit = 0xe1c84198)

It happens on both mioa701(pxa270) and cm-x300(pxa310), with the same
cross-compiler+host and kernel source.
Yet doesn't happen on zylonite(pxa310), but different cross-compiler+host.

I'll try to have a single kernel (binary) tried over the cm-x300 and zylonite to
cross-check.

Cheers.

-- 
Robert

PS: unalign.ko is a module which does a p=kmalloc(4096), then dereferences
    *(p+3)

[1] Personal memo: memory pagetables
====================================
# cat /sys/kernel/debug/kernel_page_tables 
---[ Modules ]---
0xbf000000-0xbf001000           4K     RW x      MEM/CACHED/WBRA
0xbf002000-0xbf003000           4K     RW x      MEM/CACHED/WBRA
---[ Kernel Mapping ]---
0xc0000000-0xc4000000          64M     RW x     
0xe0000000-0xe4000000          64M     RW x     
---[ vmalloc() Area ]---
0xe4804000-0xe4844000         256K     RW NX     SO/UNCACHED
0xe4845000-0xe4850000          44K     RW NX     MEM/CACHED/WBRA
0xe485a000-0xe485b000           4K     RW NX SHD DEV/SHARED
0xe485c000-0xe485d000           4K     RW NX SHD DEV/SHARED
0xe485e000-0xe485f000           4K     RW NX     SO/UNCACHED
0xe4860000-0xe4870000          64K     RW NX SHD DEV/SHARED
0xe487a000-0xe487d000          12K     RW NX     MEM/CACHED/WBRA
0xe4880000-0xe48c0000         256K     RW NX SHD DEV/SHARED
0xe48c1000-0xe4903000         264K     RW NX     MEM/CACHED/WBRA
0xe4904000-0xe491e000         104K     RW NX     SO/UNCACHED
0xe49a0000-0xe49b0000          64K     RW NX SHD DEV/SHARED
0xe49b1000-0xe49d5000         144K     RW NX     MEM/CACHED/WBRA
0xe49d6000-0xe49e1000          44K     RW NX     MEM/CACHED/WBRA
0xf2000000-0xf4000000          32M     RW x  SHD
0xf6000000-0xf6200000           2M     RW x  SHD
0xf6200000-0xf6201000           4K     RW NX SHD DEV/SHARED
0xf6300000-0xf6400000           1M     RW x  SHD
---[ vmalloc() End ]---
---[ Fixmap Area ]---
---[ Vectors ]---
0xffff0000-0xffff1000           4K USR ro x      MEM/CACHED/WBRA
0xffff1000-0xffff2000           4K     ro x      MEM/CACHED/WBRA
---[ Vectors End ]---

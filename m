From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 9 Mar 2016 02:12:56 +0000
Subject: BUG in HugeTLBFS with Contiguous hint
Message-ID: <20160309021252.GA4573@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I am very sorry for the very late bug report. I have just come across
this error.

Whilst testing something else, I found that 2MB HugeTLB pages formed
from contiguous pte's cause BUGs to appear when running through the
libhugetlbfs test suite.

I have been digging into this and I think the problem is due to the
huge pages not being unmapped properly (the nature of the bugs is that
compound pages have a non-negative compound mapped count, thus appear
as mapped in the hugetlbfs inode destruction logic); but I have not
yet been able to convincingly isolate the problem.

I ran with 64KB PAGE_SIZE and CONFIG_DEBUG_VM. Failure mode at the
bottom of this email for a 4.5-rc7 kernel.

Also, whilst reading through the code again, I think that
find_num_contig can be better implemented by pulling through the vma
(thus hstate) and avoid the need for a page table walk. This may make
things slightly more reliable when DBM is enabled (as the current code
depends on being able to pull out a matching pte), but would require
some core changes.

I'll keep hacking, but, It may be better to temporarily disable (or
revert) contiguous hint hugetlb pages for now as I don't think a quick
fix can be found in time for the release.

I am really sorry for not spotting this earlier.

Steps to reproduce the problem:

$ sudo umount /dev/hugepages/
$ sudo mount -t hugetlbfs none -o pagesize=2m /dev/hugepages/
$ echo 200 | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
$ cd libhugetlbfs
$ sudo make check
zero_filesize_segment (2M: 64):	PASS
test_root (2M: 64):	PASS
meminfo_nohuge (2M: 64):	PASS
gethugepagesize (2M: 64):	PASS
gethugepagesizes (2M: 64):	PASS
HUGETLB_VERBOSE=1 empty_mounts (2M: 64):	PASS
HUGETLB_VERBOSE=1 large_mounts (2M: 64):	PASS
find_path (2M: 64):	PASS
unlinked_fd (2M: 64):	PASS
readback (2M: 64):	------------[ cut here ]------------
kernel BUG at fs/hugetlbfs/inode.c:446!
Internal error: Oops - BUG: 0 [#1] SMP
Modules linked in:
CPU: 7 PID: 1448 Comm: readback Not tainted 4.5.0-rc7 #148
Hardware name: linux,dummy-virt (DT)
task: fffffe0040964b00 ti: fffffe00c2668000 task.ti: fffffe00c2668000
PC is at remove_inode_hugepages+0x44c/0x480
LR is at remove_inode_hugepages+0x264/0x480
pc : [<fffffe00002f3e8c>] lr : [<fffffe00002f3ca4>] pstate: 80000145
sp : fffffe00c266ba60
x29: fffffe00c266ba60 x28: fffffe00c2668000 
x27: fffffdff6012a000 x26: fffffe0000e53aa8 
x25: 000003ffffffffff x24: fffffe00c266bb28 
x23: fffffe0000e53000 x22: 0000000000000000 
x21: fffffe00008dab80 x20: 0000000000000000 
x19: 00000000000006e0 x18: 000003ffc16024e0 
x17: 000003fee51f2010 x16: fffffe00000c02d0 
x15: 0010e3a4021ba085 x14: 0000000000000000 
x13: fffffdff6012a000 x12: fffffe0000d03420 
x11: 0000000000000001 x10: 0000000000000000 
x9 : 0000000000000000 x8 : 0000000000000001 
x7 : 0000000000000000 x6 : 00000000a11cc4d7 
x5 : 00000000deadbeff x4 : 0000000037a194a6 
x3 : 000000003c82d1ff x2 : 0000000000080008 
x1 : 0000000000001100 x0 : 0000000000000001 

Process readback (pid: 1448, stack limit = 0xfffffe00c2668020)
Stack: (0xfffffe00c266ba60 to 0xfffffe00c266c000)
ba60: fffffe00c266bc40 fffffe00002f4df8 fffffe00c26f0470 fffffe00c26f0590
ba80: fffffe00008dab80 fffffe00c26f04f8 fffffe0000d02058 fffffe00c2668000
baa0: fffffe0000ddd000 000000000000005e fffffe00008b2000 fffffe00c2668000
bac0: 0000000000000001 0000000000000000 fffffe00c26f05f8 fffffe00c26f0600
bae0: 000000000000000e fffffe00c26f0470 0000000000000140 0000000000000000
bb00: 00000001ff2e0000 fffffe00c26f05d8 0000000000000001 0000000000000000
bb20: fffffdff6012a000 fffffe0000cbc948 fffffe0000dd2580 0000000000000020
bb40: 0000000000000000 fffffe0000dd2580 0000000000000140 fffffdff603f6b80
bb60: fffffe00c266bb90 fffffe000019a51c 0000000000000001 0000000000000001
bb80: 0000000000000001 fffffdff6003a200 0000000000000000 0000000000000000
bba0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
bbc0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
bbe0: 0000000000400088 0000000000000000 0000000000000000 0000000000000000
bc00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
bc20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
bc40: fffffe00c266bc60 fffffe000022b8f4 fffffe00c26f0470 fffffe00004f8850
bc60: fffffe00c266bc90 fffffe000022c4a8 fffffe00c26f0470 fffffe005b4e0000
bc80: fffffe00c26f05b8 fffffe00c26f0470 fffffe00c266bce0 fffffe0000226930
bca0: fffffe0030740780 fffffe00c26f0470 fffffe00307407d8 fffffe00307f3b40
bcc0: fffffe00c26f0470 fffffe00307f3b98 000000000000011e 0000000000000000
bce0: fffffe00c266bd10 fffffe0000226af8 fffffe0030740780 fffffe00307407d8
bd00: 0000000000000001 fffffe00002123b0 fffffe00c266bd50 fffffe0000212464
bd20: fffffe00c1084c00 0000000000000008 fffffe00c26f0470 fffffe00c1fc0620
bd40: fffffe0030740780 fffffe00c1084c10 fffffe00c266bda0 fffffe0000212588
bd60: fffffe00c1084c00 fffffe0040965160 fffffe0040964b00 fffffe0040965184
bd80: fffffe0000e14000 fffffe00c1e21720 fffffe00c266bdb0 0000000000000000
bda0: fffffe00c266bdc0 fffffe00000d86dc fffffe005b030c00 fffffe00000db7dc
bdc0: fffffe00c266be00 fffffe00000bfaa0 fffffe0040964b00 fffffe00c266be70
bde0: 0000000000000001 000003fee50c12c8 fffffe0000d00000 0000000000000000
be00: fffffe00c266be80 fffffe00000c0268 fffffe00c213b6c0 0000000000000000
be20: fffffe00c2668000 000003fee50c12c8 0000000060000000 0000000000000015
be40: 000000000000011e 000000000000005e fffffe00008b2000 fffffe00c2668000
be60: 0000000060000000 fffffe0000211844 0000000000000001 0000000000000000
be80: fffffe00c266beb0 fffffe00000c02f0 0000000000000000 000003fee51d2080
bea0: ffffffffffffffff 000003fee50c12c8 0000000000000000 fffffe0000085a30
bec0: 0000000000000000 0000000000000000 0000000000000000 00000000ffffffff
bee0: 0000000000000000 0000000000000000 00000000fbad2887 000003fee5230000
bf00: 000003fee528ca50 0000000000000001 000000000000005e fefefeff5252404f
bf20: 00000000ffffffff 0000000000000008 0000000000000020 0000000024f55898
bf40: 00000008f36b792c 0010e3a4021ba085 0000000000000000 000003fee51f2010
bf60: 000003ffc16024e0 0000000000000000 000003fee51d2080 0000000000000020
bf80: 000003fee5167510 0000000000000001 0000000000000000 0000000000000000
bfa0: 0000000000000000 0000000000000000 0000000000000000 000003ffc1602880
bfc0: 000003fee5056268 000003ffc1602860 000003fee50c12c8 0000000060000000
bfe0: 0000000000000000 000000000000005e 0000000000000000 0000000000000000
Call trace:
Exception stack(0xfffffe00c266b8a0 to 0xfffffe00c266b9c0)
b8a0: 00000000000006e0 0000000000000000 fffffe00c266ba60 fffffe00002f3e8c
b8c0: fffffe0000adaaa8 0000000000005f80 0000000000007180 0000000000004d00
b8e0: 0000000000007f40 0000000000080000 0000000000003400 000000007fd7ffc0
b900: fffffe00c266b950 fffffe000019c5ac fffffe0000dd2580 0000000000000140
b920: fffffe00c266b970 fffffe000019c5ac fffffe0000dd1c00 0000000000000140
b940: 0000000000000001 0000000000001100 0000000000080008 000000003c82d1ff
b960: 0000000037a194a6 00000000deadbeff 00000000a11cc4d7 0000000000000000
b980: 0000000000000001 0000000000000000 0000000000000000 0000000000000001
b9a0: fffffe0000d03420 fffffdff6012a000 0000000000000000 0010e3a4021ba085
[<fffffe00002f3e8c>] remove_inode_hugepages+0x44c/0x480
[<fffffe00002f4df8>] hugetlbfs_evict_inode+0x28/0x4c
[<fffffe000022b8f4>] evict+0xb4/0x180
[<fffffe000022c4a8>] iput+0x1b0/0x214
[<fffffe0000226930>] __dentry_kill+0x1b8/0x20c
[<fffffe0000226af8>] dput+0x174/0x25c
[<fffffe0000212464>] __fput+0x12c/0x1dc
[<fffffe0000212588>] ____fput+0x20/0x2c
[<fffffe00000d86dc>] task_work_run+0xb0/0xd4
[<fffffe00000bfaa0>] do_exit+0x2c0/0x9f0
[<fffffe00000c0268>] do_group_exit+0x48/0xb0
[<fffffe00000c02f0>] __wake_up_parent+0x0/0x3c
[<fffffe0000085a30>] el0_svc_naked+0x24/0x28
Code: b9009ba0 17ffffce d1000400 17ffff8c (d4210000) 
---[ end trace aafd4feb4a6ad9bf ]---
Fixing recursive fault but reboot is needed!

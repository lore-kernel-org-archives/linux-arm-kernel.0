From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 9 Mar 2016 17:17:39 +0530
Subject: [PATCH] arm64: Fix the ptep_set_wrprotect() to set PTE_DIRTY if
 (PTE_DBM && !PTE_RDONLY)
In-Reply-To: <20160309100605.GJ6192@e104818-lin.cambridge.arm.com>
References: <1457499768-31176-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20160309100605.GJ6192@e104818-lin.cambridge.arm.com>
Message-ID: <CAFpQJXUaXYkVNCc1OjLxCmpKu6b26LOaMv0V9XYRn7pLAGk2SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 3:36 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Mar 09, 2016 at 10:32:48AM +0530, Ganapatrao Kulkarni wrote:
>> Commit 2f4b829c625e ("arm64: Add support for hardware updates of the
>> access and dirty pte bits") introduced support for handling hardware
>> updates of the access flag and dirty status.
>>
>> ptep_set_wrprotect is setting PTR_DIRTY if !PTE_RDONLY,
>> however by design it suppose to set PTE_DIRTY
>> only if (PTE_DBM && !PTE_RDONLY). This patch addes code to
>> test and set accordingly.
>
> The reasoning behind the original code is that if !PTE_RDONLY, you have
> no way to tell whether the page was written or not since it is already
> writable, independent of the DBM. So by clearing the DBM bit (making the
> page read-only), we need to ensure that a potential dirty state is
> transferred to the software PTE_DIRTY bit.
>
> By checking PTE_DBM && !PTE_RDONLY, you kind of imply that you can have
> a page with !PTE_DBM && !PTE_RDONLY. Given that PTE_DBM is actually
> PTE_WRITE, PTE_RDONLY must always be set when !PTE_DBM. The bug may be
> elsewhere not setting these bits correctly.

but i do see this macro,
#define pte_hw_dirty(pte)       (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))

i dont see this issue, if i comment out arm64 implementation of
ptep_set_wrprotect()
>
>> This patch fixes BUG,
>> kernel BUG at /build/linux-StrpB2/linux-4.4.0/fs/ext4/inode.c:2394!
>> Internal error: Oops - BUG: 0 [#1] SMP
>
> Which bug is this? It's a PageWriteback() check in the for-next/core
> branch. What kernel version are you using?

i am using 4.4.0

>
> BTW, in 4.5-rc2 we pushed commit ac15bd63bbb2 ("arm64: Honour !PTE_WRITE
> in set_pte_at() for kernel mappings"), though not sure that's what you
> are hitting.

i have tried this patch, but issue still exist. crash log below

root at ubuntu:/home/ganapat/test# [  733.853009] kernel BUG at
fs/ext4/inode.c:2394!
[  733.857533] Internal error: Oops - BUG: 0 [#1] SMP
[  733.862313] Modules linked in: ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
nf_reject_ipv4 xt
_CHECKSUM iptable_mangle xt_tcpudp bridge stp llc ip6table_filter
ip6_tables iptable_filter ip_tables ebtable_nat ebtables x_tables
ghash_ce sha2_ce sha1_ce joydev input_leds ax88179_178a us
bnet gpio_keys thunderx_edac_lmc thunderx_edac_ccpi edac_core
i2c_octeon nicvf shpchp uio_pdrv_genirq uio rtc_efi nls_iso8859_1
nicpf thunder_bgx hid_generic usbhid hid ahci libahci mdio_oct
eon
[  733.912389] CPU: 38 PID: 573 Comm: kworker/u192:1 Not tainted 4.4.0+ #15
[  733.919076] Hardware name: www.cavium.com ThunderX Unknown/ThunderX
Unknown, BIOS 0.3 Jan 21 2016
[  733.927940] Workqueue: writeback wb_workfn (flush-8:0)
[  733.933071] task: ffff8000f9548000 ti: ffff8000f9550000 task.ti:
ffff8000f9550000
[  733.940543] PC is at mpage_prepare_extent_to_map+0x25c/0x264
[  733.946190] LR is at mpage_prepare_extent_to_map+0x134/0x264
[  733.951837] pc : [<ffff8000002c2d98>] lr : [<ffff8000002c2c70>]
pstate: 60400145
[  733.959218] sp : ffff8000f9553830
[  733.962520] x29: ffff8000f9553830 x28: 0000000000000000
[  733.967824] x27: ffff8000f9553a00 x26: ffff8000f95538b8
[  733.973128] x25: 0000000000000000 x24: ffff801f6ae88a38
[  733.978431] x23: ffff8000f95538c0 x22: ffffffffffffffff
[  733.983734] x21: 0000000000004800 x20: ffff8000f95538b8
[  733.989037] x19: ffff7c03c001eac0 x18: 0000ffffcac831f0
[  733.994340] x17: 0000ffffaf7a9040 x16: ffff8000000c0d68
[  733.999643] x15: 000000002fd55332 x14: 0000000000000006
[  734.004946] x13: ffff811f65be2da0 x12: 0000000000000000
[  734.010250] x11: 0000000000000040 x10: 0000000000000000
[  734.015553] x9 : 0000000000000220 x8 : 0000000000000100
[  734.020856] x7 : 0000000000001000 x6 : 0000000000001000
[  734.026158] x5 : 0000000000000000 x4 : 0000000000000001
[  734.031461] x3 : 000000000000014a x2 : 5fffe0000001023d
[  734.036764] x1 : ffff7c03c001eac0 x0 : 5fffe0000001023d
[  734.549044] Call trace:
[  734.551481] [<ffff8000002c2d98>] mpage_prepare_extent_to_map+0x25c/0x264
[  734.558171] [<ffff8000002c6c48>] ext4_writepages+0x2f8/0x9e4
[  734.563820] [<ffff8000001c44ec>] do_writepages+0x40/0x6c
[  734.569120] [<ffff800000264ecc>] __writeback_single_inode+0x5c/0x2dc
[  734.575460] [<ffff800000265644>] writeback_sb_inodes+0x20c/0x3cc
[  734.581453] [<ffff8000002658a8>] __writeback_inodes_wb+0xa4/0xe8
[  734.587447] [<ffff800000265ad4>] wb_writeback+0x1e8/0x278
[  734.592833] [<ffff800000266348>] wb_workfn+0x2a4/0x394
[  734.597960] [<ffff8000000d7470>] process_one_work+0x16c/0x390
[  734.603693] [<ffff8000000d77d0>] worker_thread+0x13c/0x42c
[  734.609168] [<ffff8000000dddfc>] kthread+0xe8/0xfc
[  734.613948] [<ffff800000085c10>] ret_from_fork+0x10/0x40
[  734.619248] Code: 17ffffdc aa1303e0 97fbd172 17ffffb8 (d4210000)
[  734.640344] ---[ end trace 0b4626b567403558 ]---

>
> --
> Catalin

thanks
Ganapat

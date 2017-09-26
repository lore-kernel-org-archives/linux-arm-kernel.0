From: rruigrok@codeaurora.org (Ruigrok, Richard)
Date: Tue, 26 Sep 2017 08:23:35 -0600
Subject: ARM64: kernel panics in DABT in sys_msync path
In-Reply-To: <20170926102324.GC8693@arm.com>
References: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
 <20170925105335.GA24042@arm.com>
 <20170925140240.vl5mvbce5lb37dxe@yury-thinkpad>
 <20170925190426.6prpcfn7lly26clm@yury-thinkpad>
 <a3b714ae-97a5-8458-9bf7-140eeeebc4b9@codeaurora.org>
 <20170926102324.GC8693@arm.com>
Message-ID: <547ed590-3ab4-cc11-cbea-f587541d2b08@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/26/2017 4:23 AM, Will Deacon wrote:
> On Mon, Sep 25, 2017 at 01:54:57PM -0600, Ruigrok, Richard wrote:
>> I also found this issue with kernels from 4.11 through 4.13.  In my tests, I
>> found that it reproduces only with 4K page and Transparent Huge Pages. With 64K
>> page I was not able to reproduce. RH also reported it here: https://
>> bugzilla.redhat.com/show_bug.cgi?id=1491504 Linaro reported on the RPK kernel
>> (4.12) on Centriq2400 and ThunderX
>>  
>>
>> https://bugs.linaro.org/show_bug.cgi?id=3191
>>
>> https://bugs.linaro.org/show_bug.cgi?id=3068.
> These two aren't the same bug (that's a forward progress issue that we're
> currently working on). I don't have permission to look at the redhat one,
> but is it just an RCU stall or actually the Oops reported by Yury?
>
>> I was able to bisect down to a specific commit.
> I think we're chasing two different things here, so not sure I trust the
> bisect!
>
> Will
The RCU stall is side effect.? The issue I'm seeing has the same stack trace and same stimulus (rwtest).? Following are the details.

I agree the bisect needs to be verified.? Yury could you test commits before and at the bisect point I provided.? I did extensive test on our platform and bisect converged consistently to the same commit.

Details:

When running ARM64 kernel configured with THP enabled:
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
And 4k page (CONFIG_ARM64_4K_PAGES=y)
?
Running ltp release 20170516-182-g738dbdb? rwtest:? runltp -p -f fs -s rwtest
?
An unhandled page fault occurs in the mm code, when PC hits? line at mm/page_vma_mapped.c
http://elixir.free-electrons.com/linux/v4.13/source/mm/page_vma_mapped.c#L163
When an invalid pvmw pointer is passed to check_pte, in addition to the unhandled page fault, the entire system is brought down since the core on which the page fault occurs halts while holding the spinlock:??? spin_lock(pvmw->ptl);
>From <http://elixir.free-electrons.com/linux/v4.13/source/mm/page_vma_mapped.c#L163>
All other cores will show:? NMI watchdog: BUG: soft lockup - CPU#<n> stuck for 22s! [doio:4152]


list *(?? 0xffff0000081b9210 +0x70)
?
(gdb) list *(?? 0xffff0000081b9210 +0x70)
0xffff0000081b9280 is in page_mkclean_one (mm/rmap.c:1028).
1023??????????????????? .address = address,
1024??????????????????? .flags = PVMW_SYNC,
1025??????????? };
1026??????????? int *cleaned = arg;
1027
1028??????????? while (page_vma_mapped_walk(&pvmw)) {
1029??????????????????? int ret = 0;
1030??????????????????? address = pvmw.address;
1031??????????????????? if (pvmw.pte) {
1032??????????????????????????? pte_t entry;
(gdb)
?
?
Dump of assembler code for function check_pte:
?? 0xffff0000081b80c0 <+0>:???? ldr???? w1, [x0,#48]
list *(0xffff0000081b80c0 + 0x68)
?
(gdb) list *(0xffff0000081b80c0 + 0x68)
0xffff0000081b8128 is in check_pte (mm/page_vma_mapped.c:63).
58????????????????????????????? return false;
59????? #else
60????????????????????? WARN_ON_ONCE(1);
61????? #endif
62????????????? } else {
63????????????????????? if (!pte_present(*pvmw->pte))
64????????????????????????????? return false;
65
66????????????????????? /* THP can be referenced by any subpage */
67????????????????????? if (pte_page(*pvmw->pte) - pvmw->page >=
?
?
?
[? 544.799399] Unable to handle kernel paging request at virtual address ffff800000000c10
[? 544.806371] pgd = ffff8007d4d7b000
[? 544.809753] [ffff800000000c10] *pgd=0000000000000000
[? 544.814695] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[? 544.820248] Modules linked in:
[? 544.823287] CPU: 2 PID: 4153 Comm: doio Not tainted 4.10.0-dev-0907-t64-09623-g726c7c0 #93
[? 544.831526] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development Platform/ABW|SYS|CVR,1DPC|V3?????????? , BIOS XBL.DF.2.0.R1-00542 QDF2400_REL CR
[? 544.845328] task: ffff8007d8428d00 task.stack: ffff8007db4ac000
[? 544.851248] PC is at check_pte+0x68/0x150
[? 544.855231] LR is at page_vma_mapped_walk+0x260/0x3d8
[? 544.860259] pc : [<ffff0000081b8128>] lr : [<ffff0000081b8470>] pstate: 00400145
[? 544.867637] sp : ffff8007db4af8a0
[? 544.870942] x29: ffff8007db4af8a0 x28: 0000000000000714
[? 544.876231] x27: 0088000000000000 x26: ff77ffffffffffff
[? 544.881526] x25: 0400000000000001 x24: 0040000000000041
[? 544.886821] x23: ffff8007d77f7000 x22: ffff8007db4afa34
[? 544.892116] x21: ffff000009276000 x20: ffff7e001f292600
[? 544.897411] x19: ffff8007db4af958 x18: 0000000000000a03
[? 544.902706] x17: 0000ffff945fb1a0 x16: ffff0000081b7ee8
[? 544.908001] x15: ffff8007bd6a6b48 x14: 0000000000000040
[? 544.913297] x13: 0000000000000000 x12: 0000000000000002
[? 544.918592] x11: 0000000000000230 x10: 0000000000001200
[? 544.923887] x9 : ffff7e001f2925c0 x8 : 0000000000001200
[? 544.929182] x7 : 0000000000000001 x6 : 0000000000000c35
[? 544.934477] x5 : 0000000000000001 x4 : 0000000000000182
[? 544.939772] x3 : 0400000000000001 x2 : ffff800000000c10
[? 544.945067] x1 : 0000000000000000 x0 : ffff8007db4af958
?
?
?
?
?
[? 545.425022] Call trace:??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? [10/44993]
[? 545.427453] Exception stack(0xffff8007db4af6d0 to 0xffff8007db4af800)
[? 545.433870] f6c0:?????????????????????????????????? ffff8007db4af958 0001000000000000
[? 545.441683] f6e0: ffff8007db4af8a0 ffff0000081b8128 ffff8007db4af710 ffff0000081dc514
[? 545.449495] f700: 0000000000000000 ffff0000091ef000 ffff8007db4af770 ffff0000087f0444
[? 545.457308] f720: ffff8007d9f1e148 ffff0000095ad000 ffff8007d80eb000 0000000001011200
[? 545.465120] f740: ffff8007db4af7a0 ffff00000817cf40 0000000000000000 ffff8007d8e7f700
[? 545.472933] f760: 0000000001091220 ffff0000080fd998 ffff8007db4af958 0000000000000000
[? 545.480745] f780: ffff800000000c10 0400000000000001 0000000000000182 0000000000000001
[? 545.488558] f7a0: 0000000000000c35 0000000000000001 0000000000001200 ffff7e001f2925c0
[? 545.496370] f7c0: 0000000000001200 0000000000000230 0000000000000002 0000000000000000
[? 545.504183] f7e0: 0000000000000040 ffff8007bd6a6b48 ffff0000081b7ee8 0000ffff945fb1a0
[? 545.512008] [<ffff0000081b8128>] check_pte+0x68/0x150
[? 545.517043] [<ffff0000081b9280>] page_mkclean_one+0x70/0x1a0
[? 545.522672] [<ffff0000081b94dc>] rmap_walk_file+0xe4/0x290
[? 545.528141] [<ffff0000081bb788>] rmap_walk+0x48/0x70
[? 545.533089] [<ffff0000081bb9a8>] page_mkclean+0x88/0xa0
[? 545.538313] [<ffff0000081866dc>] clear_page_dirty_for_io+0x9c/0x200
[? 545.544564] [<ffff000008280a20>] mpage_submit_page+0x48/0x98
[? 545.550190] [<ffff000008280bb8>] mpage_process_page_bufs+0x148/0x158
[? 545.556526] [<ffff000008280d0c>] mpage_prepare_extent_to_map+0x144/0x270
[? 545.563217] [<ffff000008284f20>] ext4_writepages+0x3b0/0xa00
[? 545.568853] [<ffff000008188ccc>] do_writepages+0x24/0x48
[? 545.574161] [<ffff00000817b454>] __filemap_fdatawrite_range+0x9c/0xe8
[? 545.580571] [<ffff00000817b5b4>] filemap_write_and_wait_range+0x2c/0x88
[? 545.587175] [<ffff00000827c540>] ext4_sync_file+0x58/0x300
[? 545.592652] [<ffff00000822b46c>] vfs_fsync_range+0x44/0xc0
[? 545.598107] [<ffff0000081b806c>] SyS_msync+0x184/0x1d8
[? 545.603242] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
[? 545.608530] Code: f9401002 d2800023 f2e08003 52800001 (f9400042)
[? 545.614630] ---[ end trace 065a200dac27fe87 ]---
[? 545.619213] note: doio[4153] exited with preempt_count 1
[? 569.734898] NMI watchdog: BUG: soft lockup - CPU#27 stuck for 22s! [doio:4152]
[? 569.741155] Modules linked in:
[? 569.744193]
[? 569.745671] CPU: 27 PID: 4152 Comm: doio Tainted: G????? D???????? 4.10.0-dev-0907-t64-09623-g726c7c0 #93
[? 569.755218] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development Platform/ABW|SYS|CVR,1DPC|V3?????????? , BIOS XBL.DF.2.0.R1-00542 QDF2400_REL CR
[? 569.769020] task: ffff8007d842ce00 task.stack: ffff8007d8280000
[? 569.774938] PC is at _raw_spin_lock+0x34/0x48
[? 569.779279] LR is at alloc_set_pte+0x438/0x560

Thanks,
Richard.
>> First bad commit is:
>> commit f27176cfc363d395eea8dc5c4a26e5d6d7d65eaf
>> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Date: Fri Feb 24 14:57:57 2017 -0800
>>
>> mm: convert page_mkclean_one() to use page_vma_mapped_walk()
>>
>> For consistency, it worth converting all page_check_address() to
>> page_vma_mapped_walk(), so we could drop the former.
>>
>> PMD handling here is future-proofing, we don't have users yet. ext4
>> with huge pages will be the first.
>>
>> I did not use virtualization, simply booting kernel and running the LTP
>> rwtest:   ./runltp -p -f fs -s rwtest
>> To validate bisecting (good points), I ran 30 iterations.  Usually it
>> reproduces in 5-10 iterations.
>>
>> If you have any suggestions for instrumentation I can run tests, we can work
>> with 4.13 or on 4.11 at the above bisect point.
>> I have not tried the 4.14-rc's yet.

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

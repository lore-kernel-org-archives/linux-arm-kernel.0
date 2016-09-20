From: beanhuo@micron.com (Bean Huo (beanhuo))
Date: Tue, 20 Sep 2016 13:10:39 +0000
Subject: ftrace function_graph causes system crash
Message-ID: <7d0e88fff8e64591ac31be3adbbf763c@SIWEX5A.sing.micron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all 
I just use ftrace to do some latency study, found that function_graph can not
Work, as long as enable it, will cause kernel panic. I searched this online.
Found that there are also some cause the same as mine. I am a newer of ftrace. 
I want to know who know what root cause? Here is some partial log:


echo function_graph > current_tracer 
[    9.583813] Unable to handle kernel paging request at virtual address b0200083
[    9.590997] pgd = c0004000
[    9.593683] [b0200083] *pgd=00000000
[    9.597253] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    9.602542] Modules linked in:
[    9.605586] CPU: 1 PID: 15 Comm: kworker/1:0 Not tainted 4.0.0-xilinx-00043-gc701690-dirty #515
[    9.614256] Hardware name: Xilinx Zynq Platform
[    9.618793] Workqueue:  0xe3a00001 ( ??)
[    9.622765] task: df517500 ti: df518000 task.ti: df518000
[    9.628162] PC is at rb_update_write_stamp+0x18/0xa0
[    9.633100] LR is at rb_commit+0x34/0xdc
[    9.637005] pc : [<c00b6674>]    lr : [<c00b716c>]    psr: 60000093
[    9.637005] sp : df51a0f0  ip : df40b00c  fp : df51a104
[    9.648456] r10: 00000000  r9 : 00000000  r8 : 00bbff80
[    9.653666] r7 : c0edcf18  r6 : df51a190  r5 : df404100  r4 : df484680
[    9.660175] r3 : b020006b  r2 : df40b000  r1 : df40b2bc  r0 : df484680
[    9.666687] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    9.674065] Control: 18c5387d  Table: 1ee7004a  DAC: 00000015
[    9.679792] Process kworker/1:0 (pid: 15, stack limit = 0xdf518210)
[    9.686041] Stack: (0xdf51a0f0 to 0xdf51a000)
[    9.690411] [<c00b6674>] (rb_update_write_stamp) from [<c00b716c>] (rb_commit+0x34/0xdc)
[    9.698478] [<c00b716c>] (rb_commit) from [<c00b7968>] (ring_buffer_unlock_commit+0x30/0x18c)
[    9.706987] [<c00b7968>] (ring_buffer_unlock_commit) from [<c00beca4>] (__buffer_unlock_commit+0x20/0x28)
[    9.716534] [<c00beca4>] (__buffer_unlock_commit) from [<c00ca094>] (__trace_graph_entry+0x94/0xa8)
[    9.725557] [<c00ca094>] (__trace_graph_entry) from [<c00ca260>] (trace_graph_entry+0x1b8/0x224)
[    9.734323] [<c00ca260>] (trace_graph_entry) from [<c0020824>] (prepare_ftrace_return+0x70/0xac)
[    9.743089] [<c0020824>] (prepare_ftrace_return) from [<c0020404>] (ftrace_graph_caller+0x18/0x20)
[    9.752020] Code: e24cb004 e5903048 e3c1ceff e3cc200f (e5933018) 
[    9.758104] ---[ end trace 5781781938261a54 ]---
[    9.762689] Kernel panic - not syncing: Fatal exception
[   10.933397] SMP: failed to stop secondary CPUs
[   10.937805] ---[ end Kernel panic - not syncing: Fatal exception
[   10.943779] CPU1: stopping
[   10.946471] CPU: 1 PID: 15 Comm: kworker/1:0 Tainted: G      D         4.0.0-xilinx-00043-gc701690-dirty #515
[   10.956358] Hardware name: Xilinx Zynq Platform
[   10.960889] Workqueue:  0xe3a00001 ( ??)
[   10.964896] [<c0021d64>] (unwind_backtrace) from [<c001c1f4>] (show_stack+0x20/0x24)
[   10.972620] [<c001c1f4>] (show_stack) from [<c0592250>] (dump_stack+0x80/0xd0)
[   10.979822] [<c0592250>] (dump_stack) from [<c001efa4>] (ipi_cpu_stop+0x4c/0x80)
[   10.987197] [<c001efa4>] (ipi_cpu_stop) from [<c001f728>] (handle_IPI+0x74/0xbc)
[   10.994573] [<c001f728>] (handle_IPI) from [<c0008720>] (gic_handle_irq+0x68/0x70)
[   11.002123] [<c0008720>] (gic_handle_irq) from [<c001cd84>] (__irq_svc+0x44/0x7c)
[   11.009569] Exception stack(0xdf519e70 to 0xdf519eb8)
[   11.014608] 9e60:                                     00000034 df518000 00000000 c08d9524
[   11.022770] 9e80: 00000000 00000000 c00317c8 00000000 c00b6674 00000000 00000008 df519edc
[   11.030929] 9ea0: df519eb8 df519eb8 c058f64c c058f650 60000113 ffffffff
[   11.037541] [<c001cd84>] (__irq_svc) from [<c058f650>] (panic+0x188/0x20c)
[   11.044399] [<c058f650>] (panic) from [<c001c578>] (die+0x380/0x3e0)
[   11.050739] [<c001c578>] (die) from [<c0027c20>] (__do_kernel_fault+0x74/0x94)
[   11.057941] [<c0027c20>] (__do_kernel_fault) from [<c0027f3c>] (do_page_fault+0x2fc/0x31c)
[   11.066185] [<c0027f3c>] (do_page_fault) from [<c0028004>] (do_translation_fault+0x2c/0xc0)

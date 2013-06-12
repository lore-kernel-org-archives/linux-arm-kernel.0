From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Jun 2013 13:24:51 +0530
Subject: [BUG ?] ARM: imx27: dmaengine: imx-dma: SD-Card: copy hangs
 forever
In-Reply-To: <1370813946.5019.254.camel@mars>
References: <1330676927-7330-1-git-send-email-javier.martin@vista-silicon.com>
 <1370813946.5019.254.camel@mars>
Message-ID: <20130612075451.GJ4107@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 11:39:06PM +0200, Christoph Fritz wrote:
> Hi,
Thanks for the bug report, we are discussing this issue in [1]

--
~Vinod

[1]: http://www.spinics.net/lists/arm-kernel/msg249815.html
> 
>  an imx27-board (pca100) hits a DEADLOCK with current stable Kernel
> 3.4.47 while adding a SD-Card:
> 
> =================================
> [ INFO: inconsistent lock state ]
> 3.4.47-00059-ga5527fe #213 Not tainted
> ---------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> swapper/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  (&(&imxdma->lock)->rlock){?.-...}, at: [<c01b9d18>] imxdma_tasklet+0x1c/0x138
> {IN-HARDIRQ-W} state was registered at:
>   [<c004e96c>] __lock_acquire+0x97c/0x1900
>   [<c004fd98>] lock_acquire+0x64/0x78
>   [<c03bcd18>] _raw_spin_lock+0x40/0x50
>   [<c01ba018>] dma_irq_handler+0xc8/0x358
>   [<c005c750>] handle_irq_event_percpu+0x50/0x1c8
>   [<c005c904>] handle_irq_event+0x3c/0x5c
>   [<c005ea5c>] handle_level_irq+0x8c/0xd8
>   [<c005c0c8>] generic_handle_irq+0x34/0x48
>   [<c000975c>] handle_IRQ+0x30/0x84
>   [<c00086e8>] avic_handle_irq+0x2c/0x4c
>   [<c03bd924>] __irq_svc+0x44/0x74
>   [<c00098c4>] default_idle+0x40/0x48
>   [<c0009a60>] cpu_idle+0x6c/0xe8
>   [<c0525700>] start_kernel+0x264/0x2a4
> irq event stamp: 20208
> hardirqs last  enabled at (20208): [<c001c0fc>] tasklet_action+0x30/0xe0
> hardirqs last disabled at (20207): [<c001c0e4>] tasklet_action+0x18/0xe0
> softirqs last  enabled at (20202): [<c001bc8c>] irq_enter+0x6c/0x70
> softirqs last disabled at (20203): [<c001bd2c>] irq_exit+0x9c/0xa8
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&(&imxdma->lock)->rlock);
>   <Interrupt>
>     lock(&(&imxdma->lock)->rlock);
> 
>  *** DEADLOCK ***
> 
> no locks held by swapper/0.
> 
> stack backtrace:
> [<c000d428>] (unwind_backtrace+0x0/0xf0) from [<c03b7724>] (print_usage_bug.part.25+0x208/0x268)
> [<c03b7724>] (print_usage_bug.part.25+0x208/0x268) from [<c004decc>] (mark_lock+0x4fc/0x620)
> [<c004decc>] (mark_lock+0x4fc/0x620) from [<c004e870>] (__lock_acquire+0x880/0x1900)
> [<c004e870>] (__lock_acquire+0x880/0x1900) from [<c004fd98>] (lock_acquire+0x64/0x78)
> [<c004fd98>] (lock_acquire+0x64/0x78) from [<c03bcd18>] (_raw_spin_lock+0x40/0x50)
> [<c03bcd18>] (_raw_spin_lock+0x40/0x50) from [<c01b9d18>] (imxdma_tasklet+0x1c/0x138)
> [<c01b9d18>] (imxdma_tasklet+0x1c/0x138) from [<c001c144>] (tasklet_action+0x78/0xe0)
> [<c001c144>] (tasklet_action+0x78/0xe0) from [<c001b76c>] (__do_softirq+0xc8/0x17c)
> [<c001b76c>] (__do_softirq+0xc8/0x17c) from [<c001bd2c>] (irq_exit+0x9c/0xa8)
> [<c001bd2c>] (irq_exit+0x9c/0xa8) from [<c0009760>] (handle_IRQ+0x34/0x84)
> [<c0009760>] (handle_IRQ+0x34/0x84) from [<c00086e8>] (avic_handle_irq+0x2c/0x4c)
> [<c00086e8>] (avic_handle_irq+0x2c/0x4c) from [<c03bd924>] (__irq_svc+0x44/0x74)
> Exception stack(0xc0549f60 to 0xc0549fa8)
> 9f60: 00000001 00000001 00000000 20000013 c0548000 c058dae8 c0554118 c0548000
> 9f80: c0b96500 41069264 a053ff1c 00000000 600000d3 c0549fa8 c0050664 c00098c4
> 9fa0: 20000013 ffffffff
> [<c03bd924>] (__irq_svc+0x44/0x74) from [<c00098c4>] (default_idle+0x40/0x48)
> [<c00098c4>] (default_idle+0x40/0x48) from [<c0009a60>] (cpu_idle+0x6c/0xe8)
> [<c0009a60>] (cpu_idle+0x6c/0xe8) from [<c0525700>] (start_kernel+0x264/0x2a4)
> 
> 
> This is also curious and may be related:
> 
> When CONFIG_IMX_DMA is disabled, copying a file to SD-Card is relatively
> fast:
>     $ dd if=/dev/zero of=/mnt/test count=102400  bs=1K
>     102400+0 records in
>     102400+0 records out
>     104857600 bytes (105 MB) copied, 33.573 s, 3.1 MB/s
> 
> When CONFIG_IMX_DMA is enabled, copying a file to SD-Card is
> very slow for small files and takes forever for files roughly bigger
> than 1.0MB:
> 
>     $ dd if=/dev/zero of=/mnt/test count=100000  bs=10
>     100000+0 records in
>     100000+0 records out
>     1000000 bytes (1.0 MB) copied, 18.3172 s, 54.6 kB/s
> 
>     $ dd if=/dev/zero of=/mnt/performance_test.102400KB count=100000  bs=20
> 
> INFO: task mmcqd/0:592 blocked for more than 30 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> mmcqd/0         D c03bbf14     0   592      2 0x00000000
> [<c03bbf14>] (__schedule+0x220/0x590) from [<c03ba11c>] (schedule_timeout+0x154/0x1bc)
> [<c03ba11c>] (schedule_timeout+0x154/0x1bc) from [<c03bbbac>] (wait_for_common+0xac/0x150)
> [<c03bbbac>] (wait_for_common+0xac/0x150) from [<c0285504>] (mmc_wait_for_req_done+0x1c/0x74)
> [<c0285504>] (mmc_wait_for_req_done+0x1c/0x74) from [<c028612c>] (mmc_start_req+0x54/0x118)
> [<c028612c>] (mmc_start_req+0x54/0x118) from [<c02911d0>] (mmc_blk_issue_rw_rq+0x64/0x380)
> [<c02911d0>] (mmc_blk_issue_rw_rq+0x64/0x380) from [<c029169c>] (mmc_blk_issue_rq+0x1b0/0x484)
> [<c029169c>] (mmc_blk_issue_rq+0x1b0/0x484) from [<c029293c>] (mmc_queue_thread+0x58/0xf4)
> [<c029293c>] (mmc_queue_thread+0x58/0xf4) from [<c0032acc>] (kthread+0x84/0x90)
> [<c0032acc>] (kthread+0x84/0x90) from [<c0009844>] (kernel_thread_exit+0x0/0x8)
> no locks held by mmcqd/0/592.
> INFO: task kjournald:595 blocked for more than 30 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kjournald       D c03bbf14     0   595      2 0x00000000
> [<c03bbf14>] (__schedule+0x220/0x590) from [<c03bc3b0>] (io_schedule+0x60/0x94)
> [<c03bc3b0>] (io_schedule+0x60/0x94) from [<c00c54a0>] (sleep_on_buffer+0x8/0x10)
> [<c00c54a0>] (sleep_on_buffer+0x8/0x10) from [<c03ba24c>] (__wait_on_bit+0x74/0xb8)
> [<c03ba24c>] (__wait_on_bit+0x74/0xb8) from [<c03ba2f4>] (out_of_line_wait_on_bit+0x64/0x70)
> [<c03ba2f4>] (out_of_line_wait_on_bit+0x64/0x70) from [<c0110ad8>] (journal_commit_transaction+0x6a0/0x14ac)
> [<c0110ad8>] (journal_commit_transaction+0x6a0/0x14ac) from [<c0113ea4>] (kjournald+0xc0/0x25c)
> [<c0113ea4>] (kjournald+0xc0/0x25c) from [<c0032acc>] (kthread+0x84/0x90)
> [<c0032acc>] (kthread+0x84/0x90) from [<c0009844>] (kernel_thread_exit+0x0/0x8)
> no locks held by kjournald/595.
> INFO: task dd:601 blocked for more than 30 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> dd              D c03bbf14     0   601    586 0x00000000
> [<c03bbf14>] (__schedule+0x220/0x590) from [<c03bc3b0>] (io_schedule+0x60/0x94)
> [<c03bc3b0>] (io_schedule+0x60/0x94) from [<c007104c>] (sleep_on_page+0x8/0x10)
> [<c007104c>] (sleep_on_page+0x8/0x10) from [<c03ba24c>] (__wait_on_bit+0x74/0xb8)
> [<c03ba24c>] (__wait_on_bit+0x74/0xb8) from [<c00712d4>] (wait_on_page_bit+0xbc/0xd0)
> [<c00712d4>] (wait_on_page_bit+0xbc/0xd0) from [<c0071dc4>] (grab_cache_page_write_begin+0x98/0xc4)
> [<c0071dc4>] (grab_cache_page_write_begin+0x98/0xc4) from [<c00fa3cc>] (ext3_write_begin+0x74/0x208)
> [<c00fa3cc>] (ext3_write_begin+0x74/0x208) from [<c007176c>] (generic_file_buffered_write+0x19c/0x260)
> [<c007176c>] (generic_file_buffered_write+0x19c/0x260) from [<c007283c>] (__generic_file_aio_write+0x234/0x490)
> [<c007283c>] (__generic_file_aio_write+0x234/0x490) from [<c0072af8>] (generic_file_aio_write+0x60/0xcc)
> [<c0072af8>] (generic_file_aio_write+0x60/0xcc) from [<c009b990>] (do_sync_write+0xa8/0xdc)
> [<c009b990>] (do_sync_write+0xa8/0xdc) from [<c009c2c0>] (vfs_write+0xa8/0x138)
> [<c009c2c0>] (vfs_write+0xa8/0x138) from [<c009c530>] (sys_write+0x40/0x6c)
> [<c009c530>] (sys_write+0x40/0x6c) from [<c0008ec0>] (ret_fast_syscall+0x0/0x38)
> 1 lock held by dd/601:
>  #0:  (&sb->s_type->i_mutex_key#12){+.+.+.}, at: [<c0072adc>] generic_file_aio_write+0x44/0xcc
> INFO: task mmcqd/0:592 blocked for more than 30 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 
> 
> With git bisect this issue was boiled down to this commit:
> 
> |   commit 9e15db7ce949e9f2d8bb6ce32a74212a4f662370
> |   Author: Javier Martin <javier.martin@vista-silicon.com>
> |   Date:   Fri Mar 2 09:28:47 2012 +0100
> |
> |       dmaengine: Add support for multiple descriptors for imx-dma.
> |
> |       dmaengine specifies the possibility that several descriptors
> |       can be queued for transfer. It also indicates that tasklets
> |       must be used for DMA callbacks.
> 
> I'm not sure if it only triggers a side effect. Any ideas?
> 
>  Thanks
>   -- Christoph
> 

-- 

From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Sep 2017 11:53:35 +0100
Subject: ARM64: kernel panics in DABT in sys_msync path
In-Reply-To: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
References: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
Message-ID: <20170925105335.GA24042@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

Thanks for the report.

On Mon, Sep 25, 2017 at 12:36:22AM +0300, Yury Norov wrote:
> Hi all,
> 
> I found that running with qemu-10 with '-smp 4' option kernel v4.13 and 
> v4.14-rc1 panics with LTP test rwtest03:
> rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$
> [ 2068.307587] Unable to handle kernel paging request at virtual address ffffffffc0000d68
> [ 2068.308195] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff00000901f000
> [ 2068.308387] [ffffffffc0000d68] *pgd=0000000000000000
> [ 2068.308643] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [ 2068.308865] Modules linked in:
> [ 2068.309013] CPU: 0 PID: 9861 Comm: doio Not tainted 4.13.0-00027-g2fdc18baa2ae #196
> [ 2068.309205] Hardware name: linux,dummy-virt (DT)
> [ 2068.309331] task: ffff80000300d400 task.stack: ffff80003d28c000
> [ 2068.309728] PC is at check_pte+0x8/0x130
> [ 2068.309848] LR is at page_vma_mapped_walk+0x240/0x498
> [ 2068.309995] pc : [<ffff0000081c5268>] lr : [<ffff0000081c55d0>] pstate: 00000145
> 
> [...]
> 
> [ 2068.338791] [<ffff0000081c5268>] check_pte+0x8/0x130
> [ 2068.339070] [<ffff0000081c66c0>] page_mkclean_one+0xa0/0x258
> [ 2068.339209] [<ffff0000081c6a70>] rmap_walk_file+0xe8/0x238
> [ 2068.339331] [<ffff0000081c88c8>] rmap_walk+0x48/0x70
> [ 2068.339436] [<ffff0000081c8ae8>] page_mkclean+0x80/0x98
> [ 2068.339592] [<ffff00000819178c>] clear_page_dirty_for_io+0xac/0x298
> [ 2068.339770] [<ffff0000082a36cc>] mpage_submit_page+0x2c/0x90
> [ 2068.340004] [<ffff0000082a3864>] mpage_process_page_bufs+0x134/0x140
> [ 2068.340261] [<ffff0000082a398c>] mpage_prepare_extent_to_map+0x11c/0x270
> [ 2068.340438] [<ffff0000082a9058>] ext4_writepages+0x2f0/0xb30
> [ 2068.340600] [<ffff000008193b78>] do_writepages+0x60/0x90
> [ 2068.340742] [<ffff000008185a44>] __filemap_fdatawrite_range+0xa4/0xf0
> [ 2068.340908] [<ffff0000081861c8>] file_write_and_wait_range+0x50/0xb8
> [ 2068.341071] [<ffff000008299b40>] ext4_sync_file+0x80/0x340
> [ 2068.341222] [<ffff00000823f668>] vfs_fsync_range+0x48/0xc8
> [ 2068.341425] [<ffff0000081c51f4>] SyS_msync+0x1bc/0x228
> [ 2068.341572] [<ffff00000808375c>] el0_svc_naked+0x20/0x24
> 
> The bug is reproducible for ilp32 and lp64 binaries. For kernel 4.12
> and for all kernels if '-smp 1' is passed to qemu, everything works
> fine. If no ideas, I think I'm able bisect it.

I tried to reproduce this on hardware, but failed to do so. Our nightly
tests are also coming back fine for rwtest03. I just built Qemu v2.10.0
and that also passes the test with -smp 4 for me, so I'm a bit stuck.

Could you share:

  * Your kernel .config
  * Your QEMU command line
  * Details of your userspace

please?

Thanks,

Will

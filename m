From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 16 Jul 2015 11:31:15 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
Message-ID: <20150716113115.45a17f17@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015 00:01:25 +0900
Jungseok Lee <jungseoklee85@gmail.com> wrote:

> I've gathered stack tracer data with your update.
> 
> 1) stack_trace
>         Depth    Size   Location    (35 entries)
>         -----    ----   --------
>   0)     4424      16   put_cpu_partial+0x28/0x1d0
>   1)     4408      80   get_partial_node.isra.64+0x13c/0x344
>   2)     4328     256   __slab_alloc.isra.65.constprop.67+0xd8/0x37c
>   3)     4072      32   kmem_cache_alloc+0x258/0x294
>   4)     4040     304   __alloc_skb+0x48/0x180
>   5)     3736      96   alloc_skb_with_frags+0x74/0x234
>   6)     3640     112   sock_alloc_send_pskb+0x1d0/0x294
>   7)     3528     160   sock_alloc_send_skb+0x44/0x54
>   8)     3368      64   __ip_append_data.isra.40+0x78c/0xb48
>   9)     3304     224   ip_append_data.part.42+0x98/0xe8
>  10)     3080     112   ip_append_data+0x68/0x7c
>  11)     2968      96   icmp_push_reply+0x7c/0x144
>  12)     2872      96   icmp_send+0x3c0/0x3c8
>  13)     2776     192   __udp4_lib_rcv+0x5b8/0x684
>  14)     2584      96   udp_rcv+0x2c/0x3c
>  15)     2488      32   ip_local_deliver+0xa0/0x224
>  16)     2456      48   ip_rcv+0x360/0x57c
>  17)     2408      64   __netif_receive_skb_core+0x4d0/0x80c
>  18)     2344     128   __netif_receive_skb+0x24/0x84
>  19)     2216      32   process_backlog+0x9c/0x15c
>  20)     2184      80   net_rx_action+0x1ec/0x32c
>  21)     2104     160   __do_softirq+0x114/0x2f0
>  22)     1944     128   do_softirq+0x60/0x68
>  23)     1816      32   __local_bh_enable_ip+0xb0/0xd4
>  24)     1784      32   ip_finish_output+0x1f4/0xabc
>  25)     1752      96   ip_output+0xf0/0x120
>  26)     1656      64   ip_local_out_sk+0x44/0x54
>  27)     1592      32   ip_send_skb+0x24/0xbc
>  28)     1560      48   udp_send_skb+0x1b4/0x2f4
>  29)     1512      80   udp_sendmsg+0x2a8/0x7a0
>  30)     1432     272   inet_sendmsg+0xa0/0xd0
>  31)     1160      48   sock_sendmsg+0x30/0x78
>  32)     1112      32   ___sys_sendmsg+0x15c/0x26c
>  33)     1080     400   __sys_sendmmsg+0x94/0x180
>  34)      680     320   SyS_sendmmsg+0x38/0x54
>  35)      360     360   el0_svc_naked+0x20/0x28
> 
> 2) stack_max_size
> 4504

Strange, on x86 I have this (with my patch applied):

        Depth    Size   Location    (39 entries)
        -----    ----   --------
  0)     3704      64   _raw_spin_lock+0x5/0x30
  1)     3640     200   get_partial_node.isra.80+0x54/0x1da
  2)     3440     208   __slab_alloc.isra.82+0x199/0x3f7
  3)     3232      80   kmem_cache_alloc+0x151/0x160
  4)     3152      16   mempool_alloc_slab+0x15/0x20
  5)     3136     128   mempool_alloc+0x58/0x150
  6)     3008      16   scsi_sg_alloc+0x42/0x50
  7)     2992     112   __sg_alloc_table+0x10b/0x150
  8)     2880      48   scsi_alloc_sgtable+0x43/0x80
  9)     2832      32   scsi_init_sgtable+0x2b/0x70
 10)     2800      80   scsi_init_io+0x59/0x1e0
 11)     2720     128   sd_init_command+0x66/0xd80
 12)     2592      24   scsi_setup_cmnd+0xa9/0x160
 13)     2568      88   scsi_prep_fn+0x7d/0x160
 14)     2480      48   blk_peek_request+0x168/0x2a0
 15)     2432     112   scsi_request_fn+0x3f/0x610
 16)     2320       8   __blk_run_queue+0x37/0x50
 17)     2312     104   queue_unplugged+0x41/0xe0
 18)     2208     112   blk_flush_plug_list+0x1b7/0x1e0
 19)     2096      80   blk_queue_bio+0x257/0x340
 20)     2016      48   generic_make_request+0xb1/0xf0
 21)     1968      96   submit_bio+0x76/0x130
 22)     1872      48   submit_bh_wbc.isra.35+0x10b/0x140
 23)     1824     112   __block_write_full_page.constprop.40+0x188/0x310
 24)     1712      64   block_write_full_page+0xdd/0x130
 25)     1648      16   blkdev_writepage+0x18/0x20
 26)     1632       8   __writepage+0x17/0x40
 27)     1624     312   write_cache_pages+0x21e/0x480
 28)     1312      96   generic_writepages+0x4a/0x70
 29)     1216      16   do_writepages+0x20/0x30
 30)     1200      96   __writeback_single_inode+0x45/0x350
 31)     1104     176   writeback_sb_inodes+0x218/0x3d0
 32)      928      80   __writeback_inodes_wb+0x8c/0xc0
 33)      848     128   wb_writeback+0x239/0x2c0
 34)      720     192   wb_workfn+0x24b/0x460
 35)      528      80   process_one_work+0x14b/0x430
 36)      448     128   worker_thread+0x117/0x460
 37)      320     144   kthread+0xc9/0xe0
 38)      176     176   ret_from_fork+0x3f/0x70

 # cat /debug/tracing/stack_max_size 
3704


> 
> In case of the number of entries, the following diff might be needed
> as I suggested in the previous reply. ;)
> 
> ----8<----
> 
> @@ -330,7 +333,7 @@ static int t_show(struct seq_file *m, void *v)
>  		seq_printf(m, "        Depth    Size   Location"
>  			   "    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> -			   max_stack_trace.nr_entries - 1);
> +			   max_stack_trace.nr_entries);

This would break x86.

>  
>  		if (!stack_tracer_enabled && !max_stack_size)
>  			print_disabled(m);
> 
> ----8<----
> 
> However, 80-byte gap still appears.

This seems to be specific to your arch.

> 
> Since max_stack_trace.skip is 3 in your update, save_stack_trace in arm64
> should be refactored to align with this value. 
> 
> max_stack_trace.skip should be set to 4 if AKASHI's [RFC 2/3] patch is merged.
> However, arch code is supposed to follow generic framework's rule in this case.
> Isn't it?
>

yeah, you don't want to update the skip level. It should just work.

I'll run this on my powerpc box and see if it shows something
different. If I have to, I'll even boot up my arm (not 64) board and
try it there.


-- Steve

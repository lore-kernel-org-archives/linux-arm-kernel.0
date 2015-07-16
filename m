From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 17 Jul 2015 00:01:25 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150716102405.2cc8c406@gandalf.local.home>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home> <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home> <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home> <55A6FA82.9000901@linaro.org>
 <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
Message-ID: <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 16, 2015, at 11:24 PM, Steven Rostedt wrote:

Hi, Steve

> On Thu, 16 Jul 2015 22:29:05 +0900
> Jungseok Lee <jungseoklee85@gmail.com> wrote:

[ snip ]

>> The data looks odd in two points.
>> 1) the number of entry
>> There is a mismatch between start token and real data
> 
> Yep, good catch. As soon as I read that, I realized exactly what the
> issue was ;-)
> 
>> 
>> 2) 80-byte gap
>> stack_max_size is not aligned with "Depth" field of the first entry of stack_trace.
>> 
>> IMHO, two items are not considered in this series as digging them out.
>> 
>> 1) skipped entries
>> As x variable is introduced in Steve's patch, it is needed to track down
>> how many entries are recorded in both stack_dump_trace and stack_dump_index.
> 
> Yep.
> 
>> 
>> 2) max_stack_trace.skip value
>> max_stack_trace.skip is 0 as applying Steve's patch. The above gap could be
>> observed unless the value is not considered in arch code. In the above example,
>> 80-byte gap is save_stack_trace function in arch/arm64/kernel/stacktrace.c.
>> 
>> As applying the following fix, stack_trace and stack_max_size are okay.
>> However, I'm not sure which code, arch or generic ftrace, should handle trace->skip.
>> The latter one is responsible for it under current implementation, not Steve's change.
>> 
>> Please correct me if I am wrong.
> 
> No, it's a bug in my patch. I'll make an update.
> 
> Does this new patch fix it for you?

I've gathered stack tracer data with your update.

1) stack_trace
        Depth    Size   Location    (35 entries)
        -----    ----   --------
  0)     4424      16   put_cpu_partial+0x28/0x1d0
  1)     4408      80   get_partial_node.isra.64+0x13c/0x344
  2)     4328     256   __slab_alloc.isra.65.constprop.67+0xd8/0x37c
  3)     4072      32   kmem_cache_alloc+0x258/0x294
  4)     4040     304   __alloc_skb+0x48/0x180
  5)     3736      96   alloc_skb_with_frags+0x74/0x234
  6)     3640     112   sock_alloc_send_pskb+0x1d0/0x294
  7)     3528     160   sock_alloc_send_skb+0x44/0x54
  8)     3368      64   __ip_append_data.isra.40+0x78c/0xb48
  9)     3304     224   ip_append_data.part.42+0x98/0xe8
 10)     3080     112   ip_append_data+0x68/0x7c
 11)     2968      96   icmp_push_reply+0x7c/0x144
 12)     2872      96   icmp_send+0x3c0/0x3c8
 13)     2776     192   __udp4_lib_rcv+0x5b8/0x684
 14)     2584      96   udp_rcv+0x2c/0x3c
 15)     2488      32   ip_local_deliver+0xa0/0x224
 16)     2456      48   ip_rcv+0x360/0x57c
 17)     2408      64   __netif_receive_skb_core+0x4d0/0x80c
 18)     2344     128   __netif_receive_skb+0x24/0x84
 19)     2216      32   process_backlog+0x9c/0x15c
 20)     2184      80   net_rx_action+0x1ec/0x32c
 21)     2104     160   __do_softirq+0x114/0x2f0
 22)     1944     128   do_softirq+0x60/0x68
 23)     1816      32   __local_bh_enable_ip+0xb0/0xd4
 24)     1784      32   ip_finish_output+0x1f4/0xabc
 25)     1752      96   ip_output+0xf0/0x120
 26)     1656      64   ip_local_out_sk+0x44/0x54
 27)     1592      32   ip_send_skb+0x24/0xbc
 28)     1560      48   udp_send_skb+0x1b4/0x2f4
 29)     1512      80   udp_sendmsg+0x2a8/0x7a0
 30)     1432     272   inet_sendmsg+0xa0/0xd0
 31)     1160      48   sock_sendmsg+0x30/0x78
 32)     1112      32   ___sys_sendmsg+0x15c/0x26c
 33)     1080     400   __sys_sendmmsg+0x94/0x180
 34)      680     320   SyS_sendmmsg+0x38/0x54
 35)      360     360   el0_svc_naked+0x20/0x28

2) stack_max_size
4504

In case of the number of entries, the following diff might be needed
as I suggested in the previous reply. ;)

----8<----

@@ -330,7 +333,7 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries - 1);
+			   max_stack_trace.nr_entries);
 
 		if (!stack_tracer_enabled && !max_stack_size)
 			print_disabled(m);

----8<----

However, 80-byte gap still appears.

Since max_stack_trace.skip is 3 in your update, save_stack_trace in arm64
should be refactored to align with this value. 

max_stack_trace.skip should be set to 4 if AKASHI's [RFC 2/3] patch is merged.
However, arch code is supposed to follow generic framework's rule in this case.
Isn't it?

Best Regards
Jungseok Lee

From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 15 Jul 2015 09:20:42 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150714093154.4d73e551@gandalf.local.home>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>	<1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>	<DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
Message-ID: <55A5A75A.1060401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2015 10:31 PM, Steven Rostedt wrote:
> On Tue, 14 Jul 2015 21:47:10 +0900
> Jungseok Lee <jungseoklee85@gmail.com> wrote:
>
>> Is the below example an unexpected result?
>> Entry 17 and 18 are ftrace_call and ftrace_ops_no_ops, respectively.

[snip]

> Note, function tracing does not disable interrupts. This looks to be
> that an interrupt came in while __aloc_skb() was being traced.

Yeah, I think so, too. But if my insight is correct, it's not __alloc_skb()
but one of functions that it calls. As I said in the commit log message
of patch[1/3], the exact traced function will not be listed by
save_stack_trace() because we don't create a stack frame at mcount().
I think this is a flaw in the current implementation (on x86).

what do you think, Steve?

-Takahiro AKASHI

>
> -- Steve
>
>>   17)     4080     168   ftrace_ops_no_ops+0xb4/0x16c
>>   18)     3912      32   ftrace_call+0x0/0x4
>>   19)     3880     144   __alloc_skb+0x48/0x180
>>   20)     3736      96   alloc_skb_with_frags+0x74/0x234
>>   21)     3640     112   sock_alloc_send_pskb+0x1d0/0x294
>>   22)     3528     160   sock_alloc_send_skb+0x44/0x54
>>   23)     3368      64   __ip_append_data.isra.40+0x78c/0xb48
>>   24)     3304     224   ip_append_data.part.42+0x98/0xe8
>>   25)     3080     112   ip_append_data+0x68/0x7c
>>   26)     2968      96   icmp_push_reply+0x7c/0x144
>>   27)     2872      96   icmp_send+0x3c0/0x3c8
>>   28)     2776     192   __udp4_lib_rcv+0x5b8/0x684
>>   29)     2584      96   udp_rcv+0x2c/0x3c
>>   30)     2488      32   ip_local_deliver+0xa0/0x224
>>   31)     2456      48   ip_rcv+0x360/0x57c
>>   32)     2408      64   __netif_receive_skb_core+0x4d0/0x80c
>>   33)     2344     128   __netif_receive_skb+0x24/0x84
>>   34)     2216      32   process_backlog+0x9c/0x15c
>>   35)     2184      80   net_rx_action+0x1ec/0x32c
>>   36)     2104     160   __do_softirq+0x114/0x2f0
>>   37)     1944     128   do_softirq+0x60/0x68
>>   38)     1816      32   __local_bh_enable_ip+0xb0/0xd4
>>   39)     1784      32   ip_finish_output+0x1f4/0xabc
>>   40)     1752      96   ip_output+0xf0/0x120
>>   41)     1656      64   ip_local_out_sk+0x44/0x54
>>   42)     1592      32   ip_send_skb+0x24/0xbc
>>   43)     1560      48   udp_send_skb+0x1b4/0x2f4
>>   44)     1512      80   udp_sendmsg+0x2a8/0x7a0
>>   45)     1432     272   inet_sendmsg+0xa0/0xd0
>>   46)     1160      48   sock_sendmsg+0x30/0x78
>>   47)     1112      32   ___sys_sendmsg+0x15c/0x26c
>>   48)     1080     400   __sys_sendmmsg+0x94/0x180
>>   49)      680     320   SyS_sendmmsg+0x38/0x54
>>   50)      360     360   el0_svc_naked+0x20/0x28
>>
>> Best Regards
>> Jungseok Lee
>

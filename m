From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Aug 2018 12:54:03 +0100
Subject: [PATCH RESEND] arm64: don't dump stack for usermode address in
 show_regs
In-Reply-To: <0003f02c-fc35-b4e9-3d3d-82ee8d02acb7@huawei.com>
References: <0003f02c-fc35-b4e9-3d3d-82ee8d02acb7@huawei.com>
Message-ID: <20180829115402.GB1125@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ding, [+James]

On Wed, Aug 29, 2018 at 06:17:30PM +0800, Ding Tianhong wrote:
> I met this problem when do some testcase on my arm64 board system:
> 
> 160935.412546] BUG: soft lockup - CPU#0 stuck for 116s! [cce_hlt_no_shar:12141]
> [160935.413292] CPU: 0 PID: 12141 Comm: cce_hlt_no_shar Tainted: G
> [160935.413429] Hardware name: Hisilicon Phosphorxxxx ESL (DT)
> [160935.413571] task: ffff800024efe300 ti: ffff80001670c000 task.ti: ffff80001670c000
> [160935.413711] PC is at 0xffffa0bf76b0
> [160935.413818] LR is at 0xffffa0c003a8
> [160935.413936] pc : [<0000ffffa0bf76b0>] lr : [<0000ffffa0c003a8>] pstate: 20000000
> [160935.414060] sp : 0000ffff9ed56d00
> [160935.414157] x29: 0000ffff9ed56d00 x28: 0000ffffa0eae6f0
> [160935.414307] x27: 0000ffff9ed57c60 x26: 0000000000000000
> [160935.414456] x25: 0000ffffa0a33250 x24: 0000000000001000
> [160935.414605] x23: 0000ffffa0a37320 x22: 0000ffffa0eae000
> [160935.414754] x21: 0000000000002d2a x20: 0000ffff9ed58840
> [160935.414903] x19: 0000000000000005 x18: 0000ffffcda37490
> [160935.415053] x17: 0000ffffa0c0033c x16: 0000ffffa0c4cc60
> [160935.415206] x15: 00312d6898000000 x14: 0000ffffa0c2670e
> [160935.415354] x13: 000000000000016e x12: 0000000000000000
> [160935.415502] x11: 0000ffff9ed56e00 x10: 0000000000000020
> [160935.415652] x9 : 2079726f00000000 x8 : 0000000000000040
> [160935.415796] x7 : 0000000000000000 x6 : 0000ffff9ed58290
> [160935.415943] x5 : 0000000000000000 x4 : 0000000000000000
> [160935.416089] x3 : 0000000000000000 x2 : 0000000000000000
> [160935.416236] x1 : 00000000ffff0000 x0 : 0000000000000005
> [160935.416371] Call trace:
> [160935.416477] Unable to handle kernel paging request at virtual address ffff9ed56d00
> [160935.416604] pgd = ffff800011991000
> [160935.416705] [ffff9ed56d00] *pgd=00000000193a0003, *pud=000000001e447003, ....
> [160935.416954] Internal error: Oops: 9600000f [#1] SMP

This looks like we're somehow dereferencing the user frame-pointer from the
READ_ONCE_NOCHECK in unwind_frame(). However, I really don't see how that
can happen, since the kernel entry code pushes a dummy frame record or
zeroes, which will terminate any backtrace before we hit the user
addresses. Furthermore, we explicitly check that the frame pointer points
to an accessible stack before we dereference it. Hmm.

I also tried to reproduce this locally using sysrq+l to trigger backtracing
in IRQ context, but I haven't managed to hit any problems.

Can you give me some hints as to how to reproduce this with mainline,
please?

Will

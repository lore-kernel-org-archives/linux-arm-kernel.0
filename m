From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 16:54:14 +0000
Subject: [PATCH v2] arm64: disable kasan when accessing frame->fp in
 unwind_frame
In-Reply-To: <1454951589-18238-1-git-send-email-yang.shi@linaro.org>
References: <1454951589-18238-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160209165414.GT22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 09:13:09AM -0800, Yang Shi wrote:
> When boot arm64 kernel with KASAN enabled, the below error is reported by
> kasan:
> 
> BUG: KASAN: out-of-bounds in unwind_frame+0xec/0x260 at addr ffffffc064d57ba0
> Read of size 8 by task pidof/499
> page:ffffffbdc39355c0 count:0 mapcount:0 mapping:          (null) index:0x0
> flags: 0x0()
> page dumped because: kasan: bad access detected
> CPU: 2 PID: 499 Comm: pidof Not tainted 4.5.0-rc1 #119
> Hardware name: Freescale Layerscape 2085a RDB Board (DT)
> Call trace:
> [<ffffffc00008d078>] dump_backtrace+0x0/0x290
> [<ffffffc00008d32c>] show_stack+0x24/0x30
> [<ffffffc0006a981c>] dump_stack+0x8c/0xd8
> [<ffffffc0002e4400>] kasan_report_error+0x558/0x588
> [<ffffffc0002e4958>] kasan_report+0x60/0x70
> [<ffffffc0002e3188>] __asan_load8+0x60/0x78
> [<ffffffc00008c92c>] unwind_frame+0xec/0x260
> [<ffffffc000087e60>] get_wchan+0x110/0x160
> [<ffffffc0003b647c>] do_task_stat+0xb44/0xb68
> [<ffffffc0003b7730>] proc_tgid_stat+0x40/0x50
> [<ffffffc0003ac840>] proc_single_show+0x88/0xd8
> [<ffffffc000345be8>] seq_read+0x370/0x770
> [<ffffffc00030aba0>] __vfs_read+0xc8/0x1d8
> [<ffffffc00030c0ec>] vfs_read+0x94/0x168
> [<ffffffc00030d458>] SyS_read+0xb8/0x128
> [<ffffffc000086530>] el0_svc_naked+0x24/0x28
> Memory state around the buggy address:
>  ffffffc064d57a80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f4 f4
>  ffffffc064d57b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffffc064d57b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                                   ^
>  ffffffc064d57c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffc064d57c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Since the shadow byte pointed by the report is 0, so it may mean it is just hit
> oob in non-current task. So, disable the instrumentation to silence these
> warnings.

Curious, but how did you trigger this? I'm just trying to confirm that
mainline is affected, but my machine boots happily with KASAN and STACKTRACE
selected and I can cat /proc/self/{stack,stat} quite happily.

What am I missing?

Will

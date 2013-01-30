From: walimisdev@gmail.com (walimis)
Date: Wed, 30 Jan 2013 18:41:34 +0800
Subject: [PATCH] serial: pl010/pl011: move clk_enable from console write
 to setup
In-Reply-To: <CACRpkdbEMO0wuDDXcd6oW6Jnn3LBhATBdcoHJEAdg7MrU6h-jQ@mail.gmail.com>
References: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
 <CACRpkdbEMO0wuDDXcd6oW6Jnn3LBhATBdcoHJEAdg7MrU6h-jQ@mail.gmail.com>
Message-ID: <CA+8yKp-VGp=HWoSH4Ce0f9-+u5mYDFN0ri7_nN3q4aOAeY223A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resend to mailling list.

2013/1/30 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Jan 29, 2013 at 5:05 PM, Liming Wang <walimisdev@gmail.com> wrote:
>
>> There seems no need to call clk_enable in every console writing. And we
>> can move clk_enable to setup function to enable the clock only once.
>> Also combine the clk_enable and clk_prepare to clk_prepare_enable.
>>
>> Signed-off-by: Liming Wang <walimisdev@gmail.com>
>
> NAK.
>
> Consider the case where the console outputs nothing or
> a string every 30 minutes. Why should we not gate off the

Yes, it's reasonable. But I haven't see any other serial drivers do that except
pl010/pl011. Except the above consideration, is there any reason that we have to
do clk_enable in console write?

> clock between these sporadic prints?

It works fine under the normal condition, but I encountered backtrace
while using kgdboc under preempt_rt  kernel:

# echo "g" >/proc/sysrq-trigger
SysRq : DEBUG
<3>BUG: sleeping function called from invalid context at kernel/rtmutex.c:646
<3>in_atomic(): 1, irqs_disabled(): 128, pid: 676, name: sh
[<80017d64>] (unwind_backtrace+0x0/0x104) from [<8068fc24>]
(dump_stack+0x20/0x24)
[<8068fc24>] (dump_stack+0x20/0x24) from [<80061130>] (__might_sleep+0xf4/0x108)
[<80061130>] (__might_sleep+0xf4/0x108) from [<80698fc4>]
(rt_spin_lock+0x2c/0x38)
[<80698fc4>] (rt_spin_lock+0x2c/0x38) from [<80027f1c>] (clk_enable+0x2c/0x4c)
[<80027f1c>] (clk_enable+0x2c/0x4c) from [<803fddcc>]
(pl011_console_write+0x34/0x148)
[<803fddcc>] (pl011_console_write+0x34/0x148) from [<8009e60c>]
(vkdb_printf+0x384/0xa78)
[<8009e60c>] (vkdb_printf+0x384/0xa78) from [<8009ed44>] (kdb_printf+0x44/0x58)
[<8009ed44>] (kdb_printf+0x44/0x58) from [<800a399c>]
(kdb_main_loop+0x10c/0x914)
[<800a399c>] (kdb_main_loop+0x10c/0x914) from [<800a7a34>]
(kdb_stub+0x800/0x95c)
[<800a7a34>] (kdb_stub+0x800/0x95c) from [<8009b7b0>]
(kgdb_cpu_enter+0x350/0x780)
[<8009b7b0>] (kgdb_cpu_enter+0x350/0x780) from [<8009be64>]
(kgdb_handle_exception+0x94/0x1bc)
[<8009be64>] (kgdb_handle_exception+0x94/0x1bc) from [<80016efc>]
(kgdb_compiled_brk_fn+0x38/0x40)
[<80016efc>] (kgdb_compiled_brk_fn+0x38/0x40) from [<800082f4>]
(do_undefinstr+0x154/0x184)
[<800082f4>] (do_undefinstr+0x154/0x184) from [<80699a2c>]
(__und_svc_finish+0x0/0x14)
Exception stack(0xbcd6de08 to 0xbcd6de50)
de00:                   bcd6c000 bcd6c028 bcd6de68 80020318 809b77c0 809b77c8
de20: 80923e5c 00000007 00000000 bcd6c000 bcd6df68 bcd6deac bcd6de38 bcd6de90
de40: 800627d8 8009ac28 600d0013 ffffffff
[<80699a2c>] (__und_svc_finish+0x0/0x14) from [<8009ac28>]
(kgdb_breakpoint+0x50/0x80)
[<8009ac28>] (kgdb_breakpoint+0x50/0x80) from [<8009af18>]
(sysrq_handle_dbg+0x4c/0x70)
[<8009af18>] (sysrq_handle_dbg+0x4c/0x70) from [<803e9c38>]
(__handle_sysrq+0x138/0x19c)
[<803e9c38>] (__handle_sysrq+0x138/0x19c) from [<803e9ce4>]
(write_sysrq_trigger+0x48/0x58)
[<803e9ce4>] (write_sysrq_trigger+0x48/0x58) from [<801886c8>]
(proc_reg_write+0x88/0xb0)
[<801886c8>] (proc_reg_write+0x88/0xb0) from [<80132b1c>] (vfs_write+0xb8/0x148)
[<80132b1c>] (vfs_write+0xb8/0x148) from [<80132e64>] (sys_write+0x50/0x124)
[<80132e64>] (sys_write+0x50/0x124) from [<8000e7a0>]
(ret_fast_syscall+0x0/0x30)
[<80132e64>] (sys_write+0x50/0x124) from [<8on processor 1 due to Keyboard Entry
[1]kdb>

It seems that clk_enable/clk_disable are called in pl011_console_write
function with the irq disabeld. So that spin_lock in clk_enable/clk_disable
trips the rtmutex debug code.

There are two ways to resolve the issues:
1. One way is to convert spin_lock in clk_enable/clk_disable to raw spin_lock.
2. Another way is to move clk_enable/clk_disable from console write.

This patch is an attempt to make clear whether we can move
clk_enable/clk_disable from console write.

Thanks
Liming Wang

>
> Yours,
> Linus Walleij

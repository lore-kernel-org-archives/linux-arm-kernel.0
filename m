From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 10:48:34 +0000
Subject: [PATCH] serial: pl010/pl011: move clk_enable from console
 write to setup
In-Reply-To: <CA+8yKp-VGp=HWoSH4Ce0f9-+u5mYDFN0ri7_nN3q4aOAeY223A@mail.gmail.com>
References: <1359475526-17523-1-git-send-email-walimisdev@gmail.com>
 <CACRpkdbEMO0wuDDXcd6oW6Jnn3LBhATBdcoHJEAdg7MrU6h-jQ@mail.gmail.com>
 <CA+8yKp-VGp=HWoSH4Ce0f9-+u5mYDFN0ri7_nN3q4aOAeY223A@mail.gmail.com>
Message-ID: <20130130104834.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 06:41:34PM +0800, walimis wrote:
> 2013/1/30 Linus Walleij <linus.walleij@linaro.org>:
> > On Tue, Jan 29, 2013 at 5:05 PM, Liming Wang <walimisdev@gmail.com> wrote:
> >
> >> There seems no need to call clk_enable in every console writing. And we
> >> can move clk_enable to setup function to enable the clock only once.
> >> Also combine the clk_enable and clk_prepare to clk_prepare_enable.
> >>
> >> Signed-off-by: Liming Wang <walimisdev@gmail.com>
> >
> > NAK.
> >
> > Consider the case where the console outputs nothing or
> > a string every 30 minutes. Why should we not gate off the
> 
> Yes, it's reasonable. But I haven't see any other serial drivers do that except
> pl010/pl011. Except the above consideration, is there any reason that we have to
> do clk_enable in console write?

The reason that it's done is because the author of the driver (me) is also
the author of the clk API, and I know how these things work, and I know
how to code drivers to work most effectively with it.

Everyone else appears to be totally and utterly lazy about it.

> It works fine under the normal condition, but I encountered backtrace
> while using kgdboc under preempt_rt  kernel:
> 
> # echo "g" >/proc/sysrq-trigger
> SysRq : DEBUG
> <3>BUG: sleeping function called from invalid context at kernel/rtmutex.c:646
> <3>in_atomic(): 1, irqs_disabled(): 128, pid: 676, name: sh
> [<80017d64>] (unwind_backtrace+0x0/0x104) from [<8068fc24>]
> (dump_stack+0x20/0x24)
> [<8068fc24>] (dump_stack+0x20/0x24) from [<80061130>] (__might_sleep+0xf4/0x108)
> [<80061130>] (__might_sleep+0xf4/0x108) from [<80698fc4>]
> (rt_spin_lock+0x2c/0x38)
> [<80698fc4>] (rt_spin_lock+0x2c/0x38) from [<80027f1c>] (clk_enable+0x2c/0x4c)

Well, I guess that's down to the use of rt_spin_lock there.  I think that's
one for the RT Preempt guys; I don't deal with RT kernels at all - I know
nothing about that.

In standard kernel programming it is perfectly acceptable to take spinlocks
in non-preemptable contexts like this.

> This patch is an attempt to make clear whether we can move
> clk_enable/clk_disable from console write.

clk_enable/clk_disable should be callable from this context; the bug is that
they aren't.

From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Nov 2013 11:29:12 -0600
Subject: STOP THE MADNESS
In-Reply-To: <20131126163031.GC16735@n2100.arm.linux.org.uk>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
Message-ID: <CAL_Jsq+AYEN2GQxgkN5a+eJsC-80n9y6Y9JngpZN7FzbLGdENw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 10:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Versatile PB926 is currently broken in mainline because of this, and it's
> damn obvious that people are just churning out changes to "update" drivers
> without testing them at all.
>
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.0-rc1+ #652
> Backtrace:
> [<c0016f0c>] (dump_backtrace) from [<c00172ac>] (show_stack+0x18/0x1c)
>  r6:c798ace0 r5:00000000 r4:c78257e0 r3:00200140
> [<c0017294>] (show_stack) from [<c0329ea0>] (dump_stack+0x20/0x28)
> [<c0329e80>] (dump_stack) from [<c004fa80>] (__lock_acquire+0x1c0/0x1b80)
> [<c004f8c0>] (__lock_acquire) from [<c0051970>] (lock_acquire+0x6c/0x80)
>  r10:00000000 r9:c0455234 r8:00000060 r7:c047d798 r6:600000d3 r5:00000000
>  r4:c782c000
> [<c0051904>] (lock_acquire) from [<c032e484>] (_raw_spin_lock_irqsave+0x60/0x74)
>  r6:c01a1100 r5:800000d3 r4:c798acd0
> [<c032e424>] (_raw_spin_lock_irqsave) from [<c01a1100>] (pl061_irq_type+0x28/0x)
>  r6:00000000 r5:00000000 r4:c798acd0
> [<c01a10d8>] (pl061_irq_type) from [<c0059ef4>] (__irq_set_trigger+0x70/0x104)
>  r6:00000000 r5:c01a10d8 r4:c046da1c r3:c01a10d8
> [<c0059e84>] (__irq_set_trigger) from [<c005b348>] (irq_set_irq_type+0x40/0x60)
>  r10:c043240c r8:00000060 r7:00000000 r6:c046da1c r5:00000060 r4:00000000
> [<c005b308>] (irq_set_irq_type) from [<c01a1208>] (pl061_irq_map+0x40/0x54)
>  r6:c79693c0 r5:c798acd0 r4:00000060
> [<c01a11c8>] (pl061_irq_map) from [<c005d27c>] (irq_domain_associate+0xc0/0x190)
>  r5:00000060 r4:c046da1c
> [<c005d1bc>] (irq_domain_associate) from [<c005d604>] (irq_domain_associate_man)
>  r8:00000008 r7:00000000 r6:c79693c0 r5:00000060 r4:00000000
> [<c005d5d0>] (irq_domain_associate_many) from [<c005d864>] (irq_domain_add_simp)
>  r8:c046578c r7:c035b72c r6:c79693c0 r5:00000060 r4:00000008 r3:00000008
> [<c005d814>] (irq_domain_add_simple) from [<c01a1380>] (pl061_probe+0xc4/0x22c)
>  r6:00000060 r5:c0464380 r4:c798acd0
> [<c01a12bc>] (pl061_probe) from [<c01c0450>] (amba_probe+0x74/0xe0)
>  r10:c043240c r9:c0455234 r8:00000000 r7:c047d7f8 r6:c047d744 r5:00000000
>  r4:c0464380
>
> This is caused by the recently introduced irq_domain_add_simple() call
> being placed before the spinlock has been initialised, and guess what
> the side effect of that call is.

IMO, the whole commit causing this problem should be reverted for
additional reasons. Irq generic chp and irqdomains are orthogonal
features/infrastructure and should not be mutually exclusive. We need
to fix irq generic chip.

commit f1f70479e999217ecbf619d71837fc5d77c680fb
Author: Haojian Zhuang <haojian.zhuang@linaro.org>
Date:   Sun Feb 17 19:42:49 2013 +0800

    gpio: pl061: support irqdomain

    Drop the support of irq generic chip. Now support irqdomain instead.

    Although set_wake() is defined in irq generic chip & it is not really
    used in pl061 gpio driver. Drop it at the same time.

    Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


Rob

From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 May 2014 11:02:34 +0100
Subject: [PATCH v7 06/15] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NTku5zS5QONpOqdhAXgfFutGC4jyAAo-UGnAsc=Xan8dw@mail.gmail.com>
References: <1399795571-17231-7-git-send-email-haojian.zhuang@linaro.org>
 <1399981484-31628-1-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405131449270.980@knanqh.ubzr>
 <CAD6h2NRMzgsZWkP8MYbCHqo4JkojbJxjj-kZwSj65A1SNBNRyw@mail.gmail.com>
 <alpine.LFD.2.11.1405151549330.17310@knanqh.ubzr>
 <CAD6h2NTku5zS5QONpOqdhAXgfFutGC4jyAAo-UGnAsc=Xan8dw@mail.gmail.com>
Message-ID: <20140521100234.GB3830@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 12:43:59PM +0800, Haojian Zhuang wrote:
> On 16 May 2014 04:01, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Thu, 15 May 2014, Haojian Zhuang wrote:
> >
> >> On 14 May 2014 03:43, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> > On Tue, 13 May 2014, Haojian Zhuang wrote:
> >> >
> >> >> +     data = readl_relaxed(fabric + FAB_SF_MODE);
> >> >> +     if (on)
> >> >> +             data |= 1 << cluster;
> >> >> +     else
> >> >> +             data &= ~(1 << cluster);
> >> >> +     writel_relaxed(data, fabric + FAB_SF_MODE);
> >> >> +     while (1) {
> >> >> +             if (data == readl_relaxed(fabric + FAB_SF_MODE))
> >> >> +                     break;
> >> >> +     }
> >> >> +}
> >> >
> >> > The above could be easily coded in assembly for the power_up_setup
> >> > callback thusly:
> >> >
> >> > hip04_power_up_setup:
> >> >
> >> >         cmp     r0, #0                  @ check affinity level
> >> >         bxeq    lr                      @ nothing to do at CPU level
> >> >
> >> >         mrc     p15, 0, r0, c0, c0, 5   @ get MPIDR
> >> >         ubfx    r0, r0, #8, #8          @ extract cluster number
> >> >
> >> >         adr     r1, .LC0
> >> >         ldmia   r1, {r2, r3}
> >> >         sub     r2, r2, r1              @ virt_addr - phys_addr
> >> >         ldr     r1, [r2, r3]            @ get fabric_phys_addr
> >> >         mov     r2, #1
> >> >         ldr     r3, [r1, #FAB_SF_MODE]  @ read "data"
> >> >         orr     r3, r3, r2, lsl r0      @ set cluster bit
> >> >         str     r3, [r1, #FAB_SF_MODE]  @ write it back
> >> >
> >> > 1:      ldr     r2, [r1, #FAB_SF_MODE]  @ read register content
> >> >         cmp     r2, r3                  @ make sure it matches
> >> >         bne     1b                      @ otherwise retry
> >> >
> >> >         bx      lr
> >> >
> >> > :LC0:   .word   .
> >> >         .word   fabric_phys_addr - .LC0
> >> >
> >> > That should be it.
> >> >
> >>
> >> No. These code should be executed before new CPU on. If I transfer
> >> them to assembler code, it means that code will be executed after
> >> new CPU on.
> >
> > Exact.
> >
> >> Then it results me failing to make new CPU online.
> >
> > The assembly code could be wrong as well.  Are you sure this is not the
> > actual reason?
> >
> > Is there some documentation for this stuff?
> >
> 
> There's no problem in assembly code. I even rewrite your assembly code.
> 
> If I keep my c code with assembly code, new CPU could be online right.
> If I only use assembly code, I only get the kernel panic. So it's not
> caused by assembly code. It's caused by executing code after new CPU
> on.
> 
> There's no documentation on this. They didn't prepare well on documents.
> I think they'll improve it in the future.

It's essential to understand what the hardware is actually doing here.

If we don't understand exactly what toggling those bits in FAB_SF_MODE
actually does, then it's impossible to judge on how to do it safely.

Cheers
---Dave

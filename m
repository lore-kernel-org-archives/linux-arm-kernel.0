From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Jan 2017 15:34:32 +0100
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
Message-ID: <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2017 at 3:15 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Something hits a brick wall when initializing the hardware breakpoints.

Should be noted that since I'm not using the breakpoints, the dirtyfix is to put

return 0;

in the first line of arch_hw_breakpoint_init() in
arch/arm/kernel/hw_breakpoint.c

I suspect that is not an accepable solution ...

It hangs at PC is at write_wb_reg+0x20c/0x330
Which is c03101dc, and looks like this in objdump -d:

c031020c:       ee001eba        mcr     14, 0, r1, cr0, cr10, {5}
c0310210:       eaffffb3        b       c03100e4 <write_wb_reg+0x114>
c0310214:       ee001eb9        mcr     14, 0, r1, cr0, cr9, {5}
c0310218:       eaffffb1        b       c03100e4 <write_wb_reg+0x114>
c031021c:       ee001eb8        mcr     14, 0, r1, cr0, cr8, {5}
c0310220:       eaffffaf        b       c03100e4 <write_wb_reg+0x114>
c0310224:       ee001eb7        mcr     14, 0, r1, cr0, cr7, {5}
c0310228:       eaffffad        b       c03100e4 <write_wb_reg+0x114>
c031022c:       ee001eb6        mcr     14, 0, r1, cr0, cr6, {5}
c0310230:       eaffffab        b       c03100e4 <write_wb_reg+0x114>
c0310234:       ee001eb5        mcr     14, 0, r1, cr0, cr5, {5}
c0310238:       eaffffa9        b       c03100e4 <write_wb_reg+0x114>

No idea if this helps.

Yours,
Linus Walleij

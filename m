From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 27 Nov 2013 15:54:49 -0300
Subject: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
In-Reply-To: <CAAYSxhqU9GZdaoTjoCAeyQ4h-KPVzU0BH0D1eLYJoFZ+s8tPgQ@mail.gmail.com>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <20131126183559.GA18570@localhost>
 <CAAYSxhqU9GZdaoTjoCAeyQ4h-KPVzU0BH0D1eLYJoFZ+s8tPgQ@mail.gmail.com>
Message-ID: <20131127185448.GA21422@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:03:03PM -0800, Tim Kryger wrote:
> On Tue, Nov 26, 2013 at 10:36 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> 
> > Since v3.13-rc1, this commit seems to have introduced some oddities on
> > some of our boards. See this log snippet:
> >
> > Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> > ????R?console [ttyS0] enabled
> > console [ttyS0] enabled
> > bootconsole [earlycon0] disabled
> > bootconsole [earlycon0] disabled
> > dw-apb-uart d0012100.serial: Couldn't set LCR to 191
> > dw-apb-uart d0012100.serial: Couldn't set LCR to 191
> > dw-apb-uart d0012100.serial: Couldn't set LCR to 224
> > dw-apb-uart d0012100.serial: Couldn't set LCR to 224
> > d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq = 18, base_baud = 15625000) is a 16550A
> >
> > This behavior appear in at least Armada 370 and Armada XP boxes.
> >
> > I confirm reverting this commit fixes the issue and things get back to normal.
> > Here's the complete kernel log: sprunge.us/gMdL
> >
> > Ideas?
> 
> Hi Ezequiel,
> 
> An external device may be keeping the UART busy and preventing LCR
> from being written.
> 
> What device is attached to ttyS1?

There's no device attached at ttyS1. I've just tested this in another
box and it seems the same error is obtained on each unused port:

[...]
dw-apb-uart d0012100.serial: Couldn't set LCR to 191
dw-apb-uart d0012100.serial: Couldn't set LCR to 191
dw-apb-uart d0012100.serial: Couldn't set LCR to 224
dw-apb-uart d0012100.serial: Couldn't set LCR to 224
d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq = 18, base_baud = 15625000) is a 16550A
dw-apb-uart d0012200.serial: Couldn't set LCR to 191
dw-apb-uart d0012200.serial: Couldn't set LCR to 191
dw-apb-uart d0012200.serial: Couldn't set LCR to 224
dw-apb-uart d0012200.serial: Couldn't set LCR to 224
d0012200.serial: ttyS2 at MMIO 0xd0012200 (irq = 31, base_baud = 15625000) is a 16550A
dw-apb-uart d0012300.serial: Couldn't set LCR to 191
dw-apb-uart d0012300.serial: Couldn't set LCR to 191
dw-apb-uart d0012300.serial: Couldn't set LCR to 224
dw-apb-uart d0012300.serial: Couldn't set LCR to 224
d0012300.serial: ttyS3 at MMIO 0xd0012300 (irq = 32, base_baud = 15625000) is a 16550A

In this board, I only have ttyS0 (console) connected.

> Also, do you know the version of the Synopsys IP?
> If built with ADDITIONAL_FEATURES=YES, the version can be read from
> the hardware:
> 
> # busybox devmem 0xd00121f8 32
> 

No, I don't know this IP version and ADDITIONAL_FEATURES seems not built.

Thanks for taking a look at this!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

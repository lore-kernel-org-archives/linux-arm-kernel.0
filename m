From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Mar 2018 18:36:14 +0000
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <CAHp75VcPMmATbCCczm3NqNDGCda6J5vga-FDW4SFABaqBKe4iw@mail.gmail.com>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
 <20180302135854.76ue5jzsg7lvxjxw@katana>
 <20180302140901.lrjqiaa2k4nxkqco@mwanda>
 <20180302153221.GB9418@n2100.armlinux.org.uk>
 <20180302162821.bmsxgrqqaginjooo@lakrids.cambridge.arm.com>
 <CAHp75VcPMmATbCCczm3NqNDGCda6J5vga-FDW4SFABaqBKe4iw@mail.gmail.com>
Message-ID: <20180303183613.GE9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2018 at 06:25:17PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 2, 2018 at 6:28 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Mar 02, 2018 at 03:32:22PM +0000, Russell King - ARM Linux wrote:
> >> How do we break this status quo and finally solve the IRQ 0 and
> >> NO_IRQ issue?
> 
> Guys, the question: Wouldn't be request_irq() failed when it gets a
> wrong number on input?

Unfortunately not - IRQ 0 is kind of valid on x86 (it's the i8253 PIT)
and an exception is made for x86 arch code with regard to this.  It
gets setup using setup_irq() rather than request_irq() (see
arch/x86/kernel/time.c::setup_default_timer_irq()).

request_irq() doesn't deny IRQ 0 - it denies IRQ_NOTCONNECTED and
anything that irq_to_desc() returns NULL for, which can be a radix
tree lookup or simply any unsigned IRQ number less than NR_IRQS for
legacy platforms.

If you're on a DT platform, then the IRQ subsystem avoids allocating
IRQ0 for any DT IRQ controller, so DT platforms should be fine.  It's
just the legacy platforms that continue to be an ongoing issue wrt
the IRQ 0 / NO_IRQ business, and those will generally be using the
non-radix tree version of irq_to_desc().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

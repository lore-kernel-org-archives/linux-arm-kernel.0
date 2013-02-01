From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 31 Jan 2013 23:46:58 -0700
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130201061450.GS29973@lunn.ch>
References: <51082C4E.5050903@gmail.com> <20130130000341.GA10600@schnuecks.de>
 <51086E86.8040705@gmail.com> <20130130083044.GA25688@schnuecks.de>
 <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
 <20130131224457.GB17976@schnuecks.de>
 <20130201000109.GK7717@titan.lakedaemon.net>
 <20130201001932.GA13044@obsidianresearch.com>
 <20130201061450.GS29973@lunn.ch>
Message-ID: <20130201064658.GA17576@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 07:14:50AM +0100, Andrew Lunn wrote:
> > My guesses would be the RTC and/or GPIO blocks (the GPIO blinker needs
> > a clock), based on table 94.
> 
> I've used AT91 parts where you can do GPO with the clock disabled, but
> GPI needed a ticking clock. So, yes, GPIO is a good candidate for
> ruint clock as well.
> 
> Looking through the data sheets, and comparing against the gated
> clocks, we have the following without their own clock:
> 
> RTC, I2C (a.k.a. TWI), UART, NAND, SPI, Watchdog, eFuse,

Hmm..

If watchdog is on the runit clock then the bridge registers and thus
the timer are on the runit clock, so the whole point would be moot.

Any easy test would be to boot a system with a minimal DT, basically
serial only, and have the kernel disable the runit clock, read a
register from one of those blocks, enable the clock and print OK. The
ones that lock up need the runit clock for sure. 7 boots should answer
the question :)

My guess is that all the peripherals behind mbus unit 0x1 (see table
94, and table 96) are controlled by that clock gate. The other gates
seem to be organized by mbus unit, and there is something very tidy
about that from a hardware perspective :)

Jason

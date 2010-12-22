From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 12:22:40 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20101221182037.GA4783@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
Message-ID: <20101222122240.GB14693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 06:20:37PM +0000, Russell King - ARM Linux wrote:
> Having just looked at this while trying to undo the DMA API abuses
> in the PL011 UART driver, I'm getting rather frustrated with this
> code.

Right, just tried this on the Versatile PB/926, which has a PL080.
The result is DMA errors.  This turns out to be the hard-coding of
which AHB bus is used.

You can't hard-code this information into the driver - it's part of
the bus matrix configuration.  On Versatile PB/926, the two AHB
buses have different memory maps - see DUI0224 page 3-13:

* DMA0 (which is DMA AHB M1) has access to the APB peripherals
  but not the system memory.
* DMA1 (which is DMA AHB M2) has access to the system memory but
  none of the APB peripherals.

Throwing in #ifdef's to sort this out resolves the problem on the PB/926.

Looking at the driver code too, I'm having a hard time understanding it,
probably because of the use of "master" and "slave" - I don't think this
has anything to do with which AHB master is used.  The comments against
pl08x_choose_master_bus() seem to imply that it controls which AHB master
is used, but it has no apparant effect on that.  I don't think this
function does anything like that anymore.

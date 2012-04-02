From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 22:46:14 +0100
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <20120402200034.GL5812@mwesterb-mobl.ger.corp.intel.com>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
 <20120402200034.GL5812@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <20120402214614.GK24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 11:00:34PM +0300, Mika Westerberg wrote:
> Anyway it looks like handle_IRQ() enables interrupts when it is finished with
> the current interrupt which then causes hw to interrupt second time resulting
> failure in case of ep93xx.

Soft IRQ processing in the irq exit path will enable interrupts, and
this is probably where the problem is showing up.

You've identified an important difference between the level 1 interrupt
controller handlers and the chained handlers, and I suggest that folk
re-implement their level 1 interrupt handlers in the same way as the
assembly code was: re-read the interrupt register each time round the
loop.

Otherwise, we're going to have to move all the L1 stuff up a level,
so that you only have one irq_enter() ... irq_exit() around the L1
handler.  That means you'll avoid running any softirqs until you've
cleared down all interrupts in the system, which might be bad news for
softirq latency (and it'd be different from x86 behaviour, where softirqs
are run after each non-nested IRQ is handled.)

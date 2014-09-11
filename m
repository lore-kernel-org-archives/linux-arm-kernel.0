From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 11 Sep 2014 08:32:58 -0400
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <54118AAB.2010205@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
Message-ID: <5411967A.6090406@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2014 07:42 AM, Sebastian Andrzej Siewior wrote:
> I also need a watchdog timer for TX since it seems that on omap3 the
> DMA engine suddenly forgets to continue with DMA?

One difference I noticed between the omap driver and the 8250 driver is
the way modem status interrupts are handled.

The omap driver only checks modem status for the UART_IIR_MSI interrupt type.
The 8250 driver checks modem status at every interrupt (other than NO_INT).

I think the UART_MSR_DCTS bit always reflects that the CTS input has changed
between reads of the MSR _even if auto CTS is on_. So perhaps the hardware
is being stopped by uart_handle_cts_change() when auto CTS is on?

Regards,
Peter Hurley

[The UPF_HARD_FLOW thing was pretty much just done for omap even though
8250 already had auto CTS/auto RTS. Serial core hardware flow control support
needs a redo as drivers have pretty much tacked stuff on randomly.]

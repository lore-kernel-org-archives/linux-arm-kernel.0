From: nschichan@freebox.fr (Nicolas Schichan)
Date: Mon, 09 Feb 2015 14:34:42 +0100
Subject: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
In-Reply-To: <1410377411-26656-4-git-send-email-bigeasy@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-4-git-send-email-bigeasy@linutronix.de>
Message-ID: <54D8B772.1010405@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2014 09:29 PM, Sebastian Andrzej Siewior wrote:
> The serial8250_do_startup() function unconditionally clears the
> interrupts and for that it reads from the RX-FIFO without checking if
> there is a byte in the FIFO or not. This works fine on OMAP4+ HW like
> AM335x or DRA7.
> OMAP3630 ES1.1 (which means probably all OMAP3 and earlier) does not like
> this:

Hello,

Sorry to wake up an old thread, but I'm affraid that this patch causes
problems on Marvell 88f6282 (Kirkwood).

When a caracter is received on the UART while the kernel is printing
the boot messages, as soon as the kernel configures the UART for
receiving (after root filesystem mount), it gets stuck printing the
following message repeatedly:

serial8250: too much work for irq29

Once stuck, the reception of another character allows the boot process
to finish.

>From what I can gather, when we hit that, the UART_IIR_NO_INT is 0 (so the
interrupt is raised), but the UART_LSR_DR bit is 0 as well so the UART_RX
register is never read to clear the interrupt.

We are using the second UART multiplexed on mpps 15 and 16.

Reverting this particular patch fixes the issue.

We are seing the problem on a 3.18 kernel.

Regards,

-- 
Nicolas Schichan
Freebox SAS

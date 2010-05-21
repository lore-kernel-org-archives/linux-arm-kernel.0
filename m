From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 22:35:29 +0100
Subject: Known issues with amba-pl010.c driver?
In-Reply-To: <0D753D10438DA54287A00B0270842697636F32378A@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636F1BC928@AUSP01VMBX24.collaborationhost.net>
	<20100521193150.GF11042@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636F32378A@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100521213529.GJ11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 04:17:28PM -0500, H Hartley Sweeten wrote:
> Hard to tell, but it is very noticeable just doing something like 'dmesg'
> on the console.
> 
> I first get some random number of characters, anywhere from none to something
> less than a full line (80 characters).  Then there is a noticeable pause.  This
> is followed by some random length block of data, another pause, then the
> remainder of the output.
> 
> I'm not sure if it will help but the 'dmesg' output on my system is 7,472
> bytes.
> 
> It might have nothing to do with the pl010 driver itself.  I just don't know
> where to start digging in the driver stack to figure out where the pauses are
> coming from.

I assume that this isn't a new problem, but something that's always
happened?

The function in pl010 which loads the characters into the TX fifo is
pl010_tx_chars().  Note that without XON/XOFF flow control,
uap->port.x_char will always be zero.

The loop which loads the FIFO is:

        count = uap->port.fifosize >> 1;
        do {
                writel(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
                xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
                uap->port.icount.tx++;
                if (uart_circ_empty(xmit))
                        break;
        } while (--count > 0);

and the thinking here is that the hardware gives us an interrupt when the
FIFO drops below half-full, so we load the FIFO up with up to half the
maximum number of characters at each interrupt.

In the case of ARM's PL010, that's a 16 byte FIFO - but yours may be
a different depth.  If it's smaller, the driver needs to know that so
it doesn't overrun the FIFO.  I'd suggest ensuring that 'fifosize' is
correct for your implementation.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Oct 2012 15:39:27 +0100
Subject: [RFC 00/24] OMAP serial driver flow control fixes, and
 preparation for DMA engine conversion
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <20121006143927.GF15246@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another potential bug - in serial_omap_set_termios() there is this:

	if (up->use_dma) {
                serial_out(up, UART_TI752_TLR, 0);
                up->scr |= UART_FCR_TRIGGER_4;
	} else {
                /* Set receive FIFO threshold to 1 byte */
                up->fcr &= ~OMAP_UART_FCR_RX_FIFO_TRIG_MASK;
                up->fcr |= (0x1 << OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT);
	}

Is that:
                up->scr |= UART_FCR_TRIGGER_4;

line really correct?  It looks wrong to be using a FCR register mask with
something that ends up in the OMAP SCR register...

I'm beginning to wonder how many of the "workarounds" which have been
applied to this driver, particularly those to do with FIFO triggers and
idle stuff are actually down to the horribly broken and buggy set_termios
code.  I'm coming to the conclusion that all those workarounds should be
removed, and we start again from a clean slate with a properly written
driver which observes the register access rules - thereby ensuring that
the correct values get written to the registers that we expect them to.

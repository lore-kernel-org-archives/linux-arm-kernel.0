From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Oct 2012 16:35:28 +0100
Subject: [RFC 00/24] OMAP serial driver flow control fixes, and
 preparation for DMA engine conversion
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <20121006153528.GA28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another issue:

serial_omap_set_termios()
{
...
        /* FIFOs and DMA Settings */
 
        /* FCR can be changed only when the
         * baud clock is not running
         * DLL_REG and DLH_REG set to 0.
         */
        serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);     
        serial_out(up, UART_DLL, 0);
        serial_out(up, UART_DLM, 0);
        serial_out(up, UART_LCR, 0);
...
        serial_out(up, UART_FCR, up->fcr);
...
}

serial_omap_restore_context()
{
        serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
        serial_out(up, UART_DLL, up->dll);
        serial_out(up, UART_DLM, up->dlh);
        serial_out(up, UART_LCR, 0x0); /* Operational mode */
        serial_out(up, UART_IER, up->ier);
        serial_out(up, UART_FCR, up->fcr);
}

Either the comment is wrong, or the code in serial_omap_restore_context()
is wrong; they can't both be right.  Please can someone let me know which
is the right version so we can fix that inconsistency.

Thanks.

From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 8 Feb 2018 17:16:07 +0200
Subject: [PATCH 1/2] serial: 8250: Don't service RX FIFO if interrupts are
 disabled
In-Reply-To: <20180208125542.15649-2-vigneshr@ti.com>
References: <20180208125542.15649-1-vigneshr@ti.com>
 <20180208125542.15649-2-vigneshr@ti.com>
Message-ID: <CAHp75Vdo+B=Z+ScUgYvoWMSP7G6iC=LOiW57dViXCXm=g2gOLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 8, 2018 at 2:55 PM, Vignesh R <vigneshr@ti.com> wrote:
> Currently, data in RX FIFO is read based on UART_LSR register state even
> if RDI and RLSI interrupts are disabled in UART_IER register.
> This is because when IRQ handler is called due to TX FIFO empty event,
> RX FIFO is serviced based on UART_LSR register status instead of
> UART_IIR status. This defeats the purpose of disabling UART RX
> FIFO interrupts during throttling(see, omap_8250_throttle()) as IRQ
> handler continues to drain UART RX FIFO resulting in overflow of buffer
> at tty layer.
> Fix this by making sure that driver drains UART RX FIFO only when
> UART_IIR_RDI is set along with UART_LSR_BI or UART_LSR_DR bits.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>

> -       if (status & (UART_LSR_DR | UART_LSR_BI)) {
> +       if (status & (UART_LSR_DR | UART_LSR_BI) &&
> +           iir & UART_IIR_RDI) {

>                 if (!up->dma || handle_rx_dma(up, iir))

handle_rx_dma() checks for IRQ status as well.

But for now it seems we are on safe side since checks are done versus
IRQ status with bit 2 set, meaning that iir & RDI will be true.

>                         status = serial8250_rx_chars(up, status);
>         }

Anyway, thanks for the patch, though I need some time to test it on
non-OMAP hardware with DMA enabled.

-- 
With Best Regards,
Andy Shevchenko

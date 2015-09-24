From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 24 Sep 2015 18:11:35 -0500
Subject: [PATCH v5 02/11] drivers: PL011: refactor pl011_startup()
In-Reply-To: <1432225584-4655-3-git-send-email-andre.przywara@arm.com>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-3-git-send-email-andre.przywara@arm.com>
Message-ID: <CAOZdJXVxDjkoCJsqE6zH_UEQcxp9T2fY1YTfV7zvWjXwwbziEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 11:26 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> +static void pl011_enable_interrupts(struct uart_amba_port *uap)
> +{
> +       spin_lock_irq(&uap->port.lock);
> +
> +       /* Clear out any spuriously appearing RX interrupts */
> +       writew(UART011_RTIS | UART011_RXIS,
> +              uap->port.membase + UART011_ICR);
> +       uap->im = UART011_RTIM;
> +       if (!pl011_dma_rx_running(uap))
> +               uap->im |= UART011_RXIM;
> +       writew(uap->im, uap->port.membase + UART011_IMSC);
> +       spin_unlock_irq(&uap->port.lock);
> +}

Shouldn't this function be using spin_lock_irqsave() and
spin_unlock_irqrestore()?  If interrupts are generally disabled before
calling this function, then they will be enabled by the
spin_unlock_irq() call, and I don't think we want that.  This function
is only supposed to enable pl011 interrupts, not all interrupts.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

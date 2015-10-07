From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 7 Oct 2015 11:13:33 -0500
Subject: [PATCH 2/2] pl011: factor our FIFO to TTY code
In-Reply-To: <1298146644-31007-1-git-send-email-linus.walleij@stericsson.com>
References: <1298146644-31007-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOZdJXVVgd=YTn33VAB2GbfuPkGGapr0C=dN7J+KhdcJuOpKuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:17 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> +static int pl011_fifo_to_tty(struct uart_amba_port *uap)
> +{
> +       u16 status, ch;
> +       unsigned int flag, max_count = 256;
> +       int fifotaken = 0;
> +
> +       while (max_count--) {
> +               status = readw(uap->port.membase + UART01x_FR);
> +               if (status & UART01x_FR_RXFE)
> +                       break;
> +
> +               /* Take chars from the FIFO and update status */
> +               ch = readw(uap->port.membase + UART01x_DR) |
> +                       UART_DUMMY_DR_RX;

I know this patch is four years old, but I just noticed a bug, and I
can't figure out how no else noticed it.  Or maybe I'm imagining
things.

#define UART_DUMMY_DR_RX        (1 << 16)

UART_DUMMY_DR_RX cannot fit into 'ch', because ch is a 16-bit integer.
So the UART_DUMMY_DR_RX is lost.

What does UART_DUMMY_DR_RX do, anyway?  It's set in two places, but no
one ever checks for it.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

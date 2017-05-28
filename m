From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 28 May 2017 03:04:15 +0300
Subject: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
In-Reply-To: <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 10:50 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> On new LPUART versions, the oversampling ratio for the receiver can be
> changed from 4x (00011) to 32x (11111) which could help us get a more
> accurate baud rate divider.
>
> The idea is to use the best OSR (over-sampling rate) possible.
> Note, OSR is typically hard-set to 16 in other LPUART instantiations.
> Loop to find the best OSR value possible, one that generates minimum
> baud diff iterate through the rest of the supported values of OSR.

> +lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
> +{
> +       u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
> +       u32 clk = sport->port.uartclk;
> +
> +       /*
> +        * The idea is to use the best OSR (over-sampling rate) possible.
> +        * Note, OSR is typically hard-set to 16 in other LPUART instantiations.
> +        * Loop to find the best OSR value possible, one that generates minimum
> +        * baud_diff iterate through the rest of the supported values of OSR.
> +        *
> +        * Calculation Formula:
> +        *  Baud Rate = baud clock / ((OSR+1) ? SBR)
> +        */
> +       baud_diff = baudrate;
> +       osr = 0;
> +       sbr = 0;
> +

> +       for (tmp_osr = 4; tmp_osr <= 32; tmp_osr++) {

I _think_ you may simplify this and avoid for-loop if you reconsider approach.

> +               /* calculate the temporary sbr value  */
> +               tmp_sbr = (clk / (baudrate * tmp_osr));
> +               if (tmp_sbr == 0)
> +                       tmp_sbr = 1;
> +
> +               /*
> +                * calculate the baud rate difference based on the temporary
> +                * osr and sbr values
> +                */

> +               tmp_diff = clk / (tmp_osr * tmp_sbr) - baudrate;

(32 - 4 + 1) times division is called...

> +
> +               /* select best values between sbr and sbr+1 */
> +               tmp = clk / (tmp_osr * (tmp_sbr + 1));
> +               if (tmp_diff > (baudrate - tmp)) {
> +                       tmp_diff = baudrate - tmp;
> +                       tmp_sbr++;
> +               }
> +
> +               if (tmp_diff <= baud_diff) {
> +                       baud_diff = tmp_diff;
> +                       osr = tmp_osr;
> +                       sbr = tmp_sbr;
> +               }
> +       }

> +       /* handle buadrate outside acceptable rate */
> +       if (baud_diff > ((baudrate / 100) * 3))
> +               dev_warn(sport->port.dev,
> +                        "unacceptable baud rate difference of more than 3%%\n");

Shouldn't you fall back to previous setting?

> +
> +       tmp = lpuart32_read(sport->port.membase + UARTBAUD);
> +

> +       if ((osr > 3) && (osr < 8))

Isn't it

if (osr ^ BIT(2) < BIT(2))

?

> +               tmp |= UARTBAUD_BOTHEDGE;

> +}

> +       if (of_device_is_compatible(port->dev->of_node, "fsl,imx7ulp-lpuart")) {
> +               lpuart32_serial_setbrg(sport, baud);

> +       } else {
> +               sbr = sport->port.uartclk / (16 * baud);
> +               bd &= ~UARTBAUD_SBR_MASK;
> +               bd |= sbr & UARTBAUD_SBR_MASK;
> +               bd |= UARTBAUD_BOTHEDGE;
> +               bd &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
> +               lpuart32_write(bd, sport->port.membase + UARTBAUD);
> +       }

Perhaps it makes sense to split this to a helper function as well (in
a separate patch).

-- 
With Best Regards,
Andy Shevchenko

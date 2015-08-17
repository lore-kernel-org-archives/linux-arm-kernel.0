From: anirudha.sarangi@xilinx.com (Anirudha Sarangi)
Date: Mon, 17 Aug 2015 15:55:10 +0000
Subject: [PATCH 1/4] serial: xuartps: Fix termios issue for enabling odd
 parity
In-Reply-To: <55D20017.4010008@hurleysoftware.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
 <55D20017.4010008@hurleysoftware.com>
Message-ID: <59506B47DEDD3943ABF9AC60020F4E2978D6E7EA@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Peter Hurley [mailto:peter at hurleysoftware.com]
> Sent: Monday, August 17, 2015 9:09 PM
> To: Michal Simek
> Cc: linux-kernel at vger.kernel.org; monstr at monstr.eu; Anirudha Sarangi; Soren
> Brinkmann; Jiri Slaby; linux-serial at vger.kernel.org; Greg Kroah-Hartman; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/4] serial: xuartps: Fix termios issue for enabling odd parity
>
> On 08/17/2015 03:22 AM, Michal Simek wrote:
> > From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> >
> > Existing set_termios does not handle the option for enabling odd
> > parity. This patch fixes it.
>
> NAK. PARODD does not enable parity generation or detection.
>
What if someone is trying to change from even to odd parity?
In this conditional case, we setup some register bit for the same.
Is the above use case not a valid one?

Regards
Anirudha

> Regards,
> Peter Hurley
>
> > Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >
> >  drivers/tty/serial/xilinx_uartps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 009e0dbc12d2..a3020344ac9d 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -723,7 +723,7 @@ static void cdns_uart_set_termios(struct uart_port
> *port,
> >     else
> >             cval |= CDNS_UART_MR_STOPMODE_1_BIT; /* 1 STOP bit */
> >
> > -   if (termios->c_cflag & PARENB) {
> > +   if ((termios->c_cflag & PARENB) || (termios->c_cflag & PARODD)) {
> >             /* Mark or Space parity */
> >             if (termios->c_cflag & CMSPAR) {
> >                     if (termios->c_cflag & PARODD)
> >



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

From: anirudha.sarangi@xilinx.com (Anirudha Sarangi)
Date: Mon, 17 Aug 2015 18:07:00 +0000
Subject: [PATCH 2/4] serial: xuartps: Do not handle overrun errors under
 IGNPAR option
In-Reply-To: <55D20992.60302@hurleysoftware.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com>
 <41df6eb35d69801afa5b686a6974e3c3bf65178a.1439796149.git.michal.simek@xilinx.com>
 <55D20297.6010500@hurleysoftware.com>
 <59506B47DEDD3943ABF9AC60020F4E2978D6E7FF@XAP-PVEXMBX02.xlnx.xilinx.com>
 <55D20992.60302@hurleysoftware.com>
Message-ID: <59506B47DEDD3943ABF9AC60020F4E2978D6EDC0@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Peter Hurley [mailto:peter at hurleysoftware.com]
> Sent: Monday, August 17, 2015 9:50 PM
> To: Anirudha Sarangi; Michal Simek
> Cc: linux-kernel at vger.kernel.org; monstr at monstr.eu; Soren Brinkmann; Jiri
> Slaby; linux-serial at vger.kernel.org; Greg Kroah-Hartman; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/4] serial: xuartps: Do not handle overrun errors under
> IGNPAR option
>
> On 08/17/2015 11:58 AM, Anirudha Sarangi wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Peter Hurley [mailto:peter at hurleysoftware.com]
> >> Sent: Monday, August 17, 2015 9:20 PM
> >> To: Michal Simek
> >> Cc: linux-kernel at vger.kernel.org; monstr at monstr.eu; Anirudha Sarangi;
> >> Soren Brinkmann; Jiri Slaby; linux-serial at vger.kernel.org; Greg
> >> Kroah-Hartman; linux- arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH 2/4] serial: xuartps: Do not handle overrun
> >> errors under IGNPAR option
> >>
> >> On 08/17/2015 03:22 AM, Michal Simek wrote:
> >>> From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> >>>
> >>> The existing implementation includes overrun errors under IGNPAR
> >>> option. This patch fixes it by including only parity and framing
> >>> error under IGNPAR option.
> >>
> >> The convention adopted by Linux serial drivers is to ignore overrun
> >> errors if both IGNPAR and IGNBRK are set.
> >>
> > I just followed the set_termios documentation, which says that IGNPAR is for
> parity and framing.
> > The current controller does not support break detection reliably.
> > That is probably why we don?t have IGNBRK.
>
> My point is about how a user-space process tells the serial driver to ignore
> overrun errors, as well, and not specifically about break handling.
>
I understand and this particular change is not very important in the patch set.
I can happily remove it.

Regards
Anirudha
> >
> > Regards
> > Anirudha
> >
> >> Regards,
> >> Peter Hurley
> >>
> >>> Signed-off-by: Anirudha Sarangi <anirudh@xilinx.com>
> >>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >>> ---
> >>>
> >>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/tty/serial/xilinx_uartps.c
> >>> b/drivers/tty/serial/xilinx_uartps.c
> >>> index a3020344ac9d..c4437e8929ff 100644
> >>> --- a/drivers/tty/serial/xilinx_uartps.c
> >>> +++ b/drivers/tty/serial/xilinx_uartps.c
> >>> @@ -691,7 +691,7 @@ static void cdns_uart_set_termios(struct
> >>> uart_port *port,
> >>>
> >>>     if (termios->c_iflag & IGNPAR)
> >>>             port->ignore_status_mask |= CDNS_UART_IXR_PARITY |
> >>> -                   CDNS_UART_IXR_FRAMING |
> >> CDNS_UART_IXR_OVERRUN;
> >>> +                                       CDNS_UART_IXR_FRAMING;
> >>>
> >>>     /* ignore all characters if CREAD is not set */
> >>>     if ((termios->c_cflag & CREAD) == 0)
> >>>
> >
> >
> >
> > This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be proprietary,
> privileged or copyrighted under applicable law. If you are not the intended
> recipient, do not read, copy, or forward this email message or any attachments.
> Delete this email message and any attachments immediately.
> >



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

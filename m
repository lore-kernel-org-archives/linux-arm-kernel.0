From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Jul 2013 09:33:05 +0200
Subject: [PATCH 2/3] serial: mxs: enable the DMA only when the rts/cts is
 enabled
In-Reply-To: <51E3D499.3060902@freescale.com>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <1373857736-30108-2-git-send-email-b32955@freescale.com>
 <20130715082716.GM12139@pengutronix.de>
 <51E3B5B5.1030706@freescale.com>
 <20130715090755.GN12139@pengutronix.de>
 <51E3D499.3060902@freescale.com>
Message-ID: <20130716073305.GP12139@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 06:53:13PM +0800, Huang Shijie wrote:
> ? 2013?07?15? 17:07, Uwe Kleine-K?nig ??:
> >Hello,
> >
> >On Mon, Jul 15, 2013 at 04:41:25PM +0800, Huang Shijie wrote:
> >>? 2013?07?15? 16:27, Uwe Kleine-K?nig ??:
> >>>do you want to say that the driver fails to only enable DMA when RTS/CTS
> >>>are available; or that today the driver can handle DMA just fine even
> >>>without RTS/CTS? I interpret your commit log as the latter, your patch
> >>>implements the former however.
> >>in the mxs-auart, if the RTS/CTS is not invalid, the DMA should be
> >>not enabled.
> >>
> >>But current code lost the limit, a uart without the RTS/CTS may also
> >>enables the DMA in which case the uart
> >>may does not run or run in a abnormal way.
> >So this sounds like a fix that should go into stable and so preferably
> >should be the first patch in your series.
> This patch depends on the first patch. :)
But it's not a hard dependency.

> >Something like:
> >
> >	serial: mxs-auart: DMA unreliable without RTS/CTS
> >
> >	According to [add some document name here] DMA doesn't work
> >	reliable without hardware handshaking. So make DMA dependant on
> >	a newly introdused property "fsl,uart-has-rtscts".
> >
> >	Cc: stable at kernel.org # [first affected version]
> >
> >The flag is only used to decide if dma should be enabled. So I think an
> >in-code comment would be nice, too. Is it still correct to set
> ok.
> >AUART_CTRL2_RTSEN and AUART_CTRL2_RTS and read AUART_STAT_CTS when
> >fsl,uart-has-rtscts is not provided?
> i think it's correct. (if i have a imx28-evk board, i can test it.)
> 
> If you enable the RTS/CTS from the application, the
> tty_port_cts_enabled() will be true.
> we will set the AUART_CTRL2_RTSEN in the end when the
> "fsl,uart-has-rtscts" is enabled.
> 
> 
> >(BTW, mxs_auart_set_mctrl has:
> >
> >	u32 ctrl = readl(u->membase + AUART_CTRL2);
> >
> >	ctrl&= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
> >         if (mctrl&  TIOCM_RTS) {
> >                 if (tty_port_cts_enabled(&u->state->port))
> >                         ctrl |= AUART_CTRL2_RTSEN;
> >                 else
> >                         ctrl |= AUART_CTRL2_RTS;
> >         }
> >
> >	s->ctrl = mctrl;
> >
> >A comment for the diligent reader about the difference between RTSEN and
> >RTS would be nice. Also I wonder if shadowing mctrl is sensible and used
> Please see the spec about the RTSEN and RTS.
Right, it's not hard for me. Other might not have the manual handy, so
a comment telling:

> RTSEN enable the flow control by the hardware;
> RTS enable the flow control by the software.

would be nice.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

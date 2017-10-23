From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 23 Oct 2017 10:26:31 +0200
Subject: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
In-Reply-To: <20171022184956.exmjlpcbzkvlp7xg@pengutronix.de>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
 <20171022184956.exmjlpcbzkvlp7xg@pengutronix.de>
Message-ID: <201710231026.32595.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sunday 22 October 2017 20:49:56 Uwe Kleine-K?nig wrote:
> On Fri, Oct 20, 2017 at 02:25:11PM -0700, Troy Kisky wrote:
> > On 10/20/2017 2:20 PM, Troy Kisky wrote:
> > > Since imx_disable_rx_int is only called by imx_startup,
> > > let's integrate it into that function.
> > >
> > > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > > ---
> > > v2: new patch
> > > ---
> > >  drivers/tty/serial/imx.c | 39
> > > ++++++++++----------------------------- 1 file changed, 10
> > > insertions(+), 29 deletions(-)
> >
> > While testing this series, I noticed that sending a break on the serial
> > port caused
> >
> > imx-uart 2020000.serial: DMA transaction error.
> >
> > Is that normal ?
>
> I remember that J?rgen (added to To explictly) hit this or a similar
> problem before, maybe he can commen?

Yes, it hit me on i.MX53 after DMA was enabled by default. The driver 
currently doesn't handle the "break" event when DMA is active. In this case 
the DMA callback returns with an error (that's the message you see, but 
it's not an error in this case...), the driver clears the flags and drops 
the (break) event itself.

jb

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ?? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions ? ? ? ? ? ? ? ?? ?| http://www.pengutronix.de/ ?|

From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 13:57:03 +0300
Subject: [RFC/PATCH 10/13] serial: omap: stick to put_autosuspend
In-Reply-To: <CAMQu2gzm4z8DbCiz4hOS2nKa2HzNofmp=SPORYEu2Z_H3+JN9Q@mail.gmail.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-11-git-send-email-balbi@ti.com>
 <CAMQu2gzm4z8DbCiz4hOS2nKa2HzNofmp=SPORYEu2Z_H3+JN9Q@mail.gmail.com>
Message-ID: <20120821105702.GX10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 04:12:11PM +0530, Shilimkar, Santosh wrote:
> On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Everytime we're done using our TTY, we want
> > the pm timer to be reinitilized. By sticking
> > to pm_runtime_pm_autosuspend() we make sure
> > that this will always be the case.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/tty/serial/omap-serial.c | 33 ++++++++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index 6ea24c5..458d77c 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -164,7 +164,8 @@ static void serial_omap_enable_ms(struct uart_port *port)
> >         pm_runtime_get_sync(up->dev);
> >         up->ier |= UART_IER_MSI;
> >         serial_out(up, UART_IER, up->ier);
> > -       pm_runtime_put(up->dev);
> > +       pm_runtime_mark_last_busy(up->dev);
> > +       pm_runtime_put_autosuspend(up->dev);
> >  }
> >
> Can you please expand the change-log a bit ?
> Didn't follow the time re-init part completely.

It's really just a micro-optimization. The thing is:

if I call pm_runtime_put(), I will not reinitialize the pm timer to
whatever timeout value I used. This means that pm_runtime_put() could
actually execute right away (if timer was about to expire when I called
pm_runtime_put()). While this wouldn't cause any issues, it's better to
reinitialize the timer and make sure if there's another
read/write/set_termios/whatever coming right after this, UART is still
powered up.

I mean, it's really just trying to avoid context save & restore when
UART is still under heavy usage.

Does it make sense ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/d67495a8/attachment-0001.sig>

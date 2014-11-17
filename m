From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 20:07:31 +0000
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
Message-ID: <20141117200731.GY4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 12:05:45AM +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> 2014-11-17 21:44 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> > Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
> >
> >> Change clk_enable/disable() calls to clk_prepare_enable() and
> >> clk_disable_unprepare().
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >>  drivers/usb/gadget/udc/pxa25x_udc.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
> >> index 42f7eeb..e4964ee 100644
> >> --- a/drivers/usb/gadget/udc/pxa25x_udc.c
> >> +++ b/drivers/usb/gadget/udc/pxa25x_udc.c
> >> @@ -103,8 +103,8 @@ static const char ep0name [] = "ep0";
> >>
> >>  /* IXP doesn't yet support <linux/clk.h> */
> >>  #define clk_get(dev,name)    NULL
> >> -#define clk_enable(clk)              do { } while (0)
> >> -#define clk_disable(clk)     do { } while (0)
> >> +#define clk_prepare_enable(clk)      do { } while (0)
> >> +#define clk_disable_unprepare(clk)   do { } while (0)
> >>  #define clk_put(clk)         do { } while (0)
> >>
> >>  #endif
> >> @@ -932,7 +932,7 @@ static int pullup(struct pxa25x_udc *udc)
> >>               if (!udc->active) {
> >>                       udc->active = 1;
> >>                       /* Enable clock for USB device */
> >> -                     clk_enable(udc->clk);
> >> +                     clk_prepare_enable(udc->clk);
> >
> > Guess what, Russell's remark on i2c and serial made me cross-check.  And there
> > is a case where this will be called in irq context too ...
> >
> > See :
> > -> do_IRQ
> >   -> lubbock_vbus_irq()
> >     -> pxa25x_udc_vbus_session()
> >       -> pullup()
> >         -> clk_prepare_enable()
> >           -> CRACK
> >
> > Note that your patch is not really the faulty one, I think a threaded irq
> > instead of the "raw" irq should do the trick. And it is granted on UDC api that
> > vbus function is called in a "sleeping" context (Felipe correct me if I'm
> > wrong), so a patch to fix this before your current code would be fine.
> 
> OK, I will take a look. It seems the correct way would be to strip this code
> away to a phy, like gpio-vbus or nop phys. Do you have access to lubbock
> (or maybe Daniel, Haojian or Russell has?)?

Robert has my Lubbock now.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

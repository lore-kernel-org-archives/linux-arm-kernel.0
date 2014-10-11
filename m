From: johan@kernel.org (Johan Hovold)
Date: Sat, 11 Oct 2014 12:12:01 +0200
Subject: [PATCH 08/12] rtc: omap: restore irq state after reading TC
 registers
In-Reply-To: <20141010180225.GT31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-9-git-send-email-johan@kernel.org>
 <20141010180225.GT31348@saruman>
Message-ID: <20141011101201.GC18988@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 01:02:31PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 09, 2014 at 09:06:30PM +0200, Johan Hovold wrote:
> > Make sure to restore local irq state when reading the timer/calendar
> > (TC) registers, so that omap_rtc_read_time() can be called with
> > interrupts disabled.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/rtc/rtc-omap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index 0ef016553a97..62e2e9a9887a 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -239,8 +239,10 @@ static void bcd2tm(struct rtc_time *tm)
> >  
> >  static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >  {
> > +	unsigned long flags;
> > +
> >  	/* we don't report wday/yday/isdst ... */
> > -	local_irq_disable();
> > +	local_irq_save(flags);
> 
> you should really convert these to a real spin_lock_irq*(), that's
> because local_irq* do not get re-written with RT patchset, so this
> pretty much "breaks" RT.

The driver uses local_irq* throughout to guarantee registers are not
read or written during an update event.

In fact, at least on AM33xx, this is not even necessary when reading (as
opposed to writing) the TC registers, but I did not dare change that
without knowing how the legacy platforms work in this respect.

Do you suggest doing this conversion as part of, or on top of, this
series?

Johan

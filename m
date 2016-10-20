From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 20 Oct 2016 13:36:30 -0700
Subject: [PATCH v5 11/23] usb: chipidea: Emulate OTGSC interrupt enable
 path
In-Reply-To: <20161020101017.GA32001@b29397-desktop>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-12-stephen.boyd@linaro.org>
 <20161019011535.GC6294@b29397-desktop>
 <147684198705.24897.12451889548508263144@sboyd-linaro>
 <20161019080211.GA1968@b29397-desktop>
 <147694652997.28344.1048935134595924905@sboyd-linaro>
 <20161020101017.GA32001@b29397-desktop>
Message-ID: <147699579088.21058.4379586947317571921@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-10-20 03:10:18)
> On Wed, Oct 19, 2016 at 11:55:29PM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-10-19 01:02:11)
> > > On Tue, Oct 18, 2016 at 06:53:07PM -0700, Stephen Boyd wrote:
> > > > If you're asking if I've made modifications to extcon-usb-gpio, then the
> > > > answer is no. The branch on linaro.org git server from the cover-letter
> > > > is the branch I've used to test this with. This patch is specifically to
> > > > fix issues with that design on the db410c board that has only one pin
> > > > for ID and vbus detection. It's the schematic that we've discussed in
> > > > another thread.
> > > > 
> > > > extcon-usb-gpio sends two extcon events, EXTCON_USB_HOST (for the id
> > > > pin) and EXTCON_USB (for the vbus). So afaik it does support vbus
> > > > events.
> > > > 
> > > 
> > > Hmm, in fact, your ID event is the same with vbus event, you take
> > > external vbus event as ID event for extcon-usb-gpio handling. Yes,
> > > it can work due to it sends EXTCON_USB_HOST event first.
> > > 
> > > Where you change the USB_SW_SEL_PM pin?
> > 
> > Currently that is done with the mux driver I sent based on the extcon
> > event. We don't know if that's before or after the controller handles
> > the extcon event though, so the pin should probably be changed from the
> > chipidea driver instead to be more explicit. Why do you ask though?
> 
> I was just curious how you handle it, now I am clear. From my point,
> the suitable way may be: mux driver + user app (echo role through
> debugfs). The extcon-usb-gpio is not necessary, since you have already
> known role at mux driver.
> 
> The current kernel has no framework to handle dual-role switch at kernel
> space.

Ok. I'm planning that as future work after this set of patches is
merged.

> > > @@ -1963,6 +1963,8 @@ static int udc_id_switch_for_device(struct ci_hdrc *ci)
> > >                 /* Clear and enable BSV irq */
> > >                 hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
> > >                                         OTGSC_BSVIS | OTGSC_BSVIE);
> > > +       /* vbus change may has already been occurred */
> > 
> > "vbus change may have already occurred"?
> 
> Yes, will change.
> 

Great. Should I wait to incorporate your change into my series, or will
you apply the usb patches and Kishon can apply the phy patches?  This
patch #11 should be dropped, but otherwise I don't think there's
anything left to do for this series.

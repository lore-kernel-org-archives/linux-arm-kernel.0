From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 12 Aug 2013 10:11:06 -0500
Subject: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
In-Reply-To: <5205740A.50206@wwwdotorg.org>
References: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
 <5203FC1A.3090903@wwwdotorg.org> <1375993920.22740.9.camel@linux-builds1>
 <5204017A.1040607@wwwdotorg.org> <1375995281.22740.16.camel@linux-builds1>
 <520409F2.1090906@wwwdotorg.org> <1376003457.22740.25.camel@linux-builds1>
 <52055867.9000602@wwwdotorg.org> <1376088088.14580.4.camel@linux-builds1>
 <5205740A.50206@wwwdotorg.org>
Message-ID: <1376320266.28628.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:58 -0600, Stephen Warren wrote:
> On 08/09/2013 04:41 PM, Dinh Nguyen wrote:
> > On Fri, 2013-08-09 at 15:00 -0600, Stephen Warren wrote:
> >> On 08/08/2013 05:10 PM, Dinh Nguyen wrote:
> >>> On Thu, 2013-08-08 at 15:13 -0600, Stephen Warren wrote:
> >> ...
> >>>> Why is there a need to directly represent the divider anywhere? The
> >>>> driver can find the rate of the input clock, and I assume it knows what
> >>>> rate it wants the clock to run at, so can't it calculate the divider
> >>>> based on those two pieces of information?
> >>>
> >>> CC: Chris Ball
> >>>>
> >>>> Or, does the driver really not know what rate it wants the clock to be
> >>>> after the internal divider? If not, then I think that *rate* should be
> >>>> recorded in DT, not the divider to obtain that rate.
> >>>>
> >>>
> >>> I believe that this is the case, that the driver does not know what rate
> >>> it will clock the SD card at. I think internally we did have a "bus_hz"
> >>> in DT a while back. I guess I don't really understand why it would be
> >>> better to have a *rate* DT entry instead of a fixed-divider entry?
> >>
> >> The value of the divider depends on two things:
> >>
> >> 1) Input clock rate.
> >> 2) Desired rate after applying the internal divider.
> >>
> >> The input clock rate may vary, either between SoCs the IP is integrated
> >> into, or even at run-time perhaps base on clk_set_rate() etc.
> >>
> >> If the MMC driver knows the clock rate it wants to run at, it can
> >> calculate the divider easily; it can automatically adjust to any input
> >> clock that its environment may provide.
> >>
> >> If the MMC driver is simply told "use this divider", that's encoding
> >> assumptions about the rate of the input clock which might not be valid;.
> >> Encoding the desire clock rate within the MMC HW block allows the
> >> divider to be calculated based on the actual environment.
> > 
> > Thanks Stephen. That makes sense.
> > 
> > Chris, Jaehoon, and Seungwon, do you have any inputs? If not I will go
> > down the path of have the "bus-hz" in the DTS node for the clock rate of
> > the CIU clock. Then I would also make the same change to dw_mmc-exynos
> > but would need your help on what the rate would be.
> > 
> > For SOCFPGA, its 12.5 MHZ.
> 
> I'm not sure "bus-hz" is the right name; it's not clear from that name
> that it refers to an internal clock inside the MMC controller rather
> than the SD bus out to the card itself. Perhaps "controller-clock-hz" or
> something like that?

It appears that there is already "clock-frequency" binding defined in
synopsis-dw-mshc.txt design for this purpose.

* clock-frequency: should be the frequency (in Hz) of the ciu clock.  If
this is specified and the ciu clock is specified then we'll try to set
the ciu clock to this at probe time.

Since its already defined, I will go ahead and use this binding.

Thanks again for the review.

Dinh
> 

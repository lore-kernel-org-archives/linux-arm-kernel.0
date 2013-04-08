From: jhovold@gmail.com (Johan Hovold)
Date: Mon, 8 Apr 2013 11:00:23 +0200
Subject: [RFC 4/5] RTC: rtc-at91sam9: add device-tree support
In-Reply-To: <20130408073807.GQ20693@game.jcrosoft.org>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
 <1365347572-14972-4-git-send-email-jhovold@gmail.com>
 <20130408073807.GQ20693@game.jcrosoft.org>
Message-ID: <20130408090023.GC25605@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 09:38:07AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> > Add device-tree support.
> > 
> > The AT91 RTT can be used as an RTC if the atmel,at91-rtt-as-rtc-gpbr
> > property is present and set to the general-purpose backup register to
> > use to store the RTC time base.
> > 
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  .../devicetree/bindings/rtc/rtc-at91sam9.txt       | 19 ++++++++++++
> >  drivers/rtc/rtc-at91sam9.c                         | 36 +++++++++++++++++++++-
> >  2 files changed, 54 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt b/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> > new file mode 100644
> > index 0000000..0f54988
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> > @@ -0,0 +1,19 @@
> > +Atmel AT91 RTT as RTC
> > +=====================
> > +
> > +Required properties:
> > +- compatible: Should be "atmel,at91sam9260-rtt"
> > +- reg: Should contain register location and length
> > +- interrupts: Should contain interrupt for the RTT which is the IRQ line
> > +  shared across all System Controller members.
> > +- atmel,rtt-as-rtc-gpbr: Should contain the backup-register to use to store
> > +  the RTC time base
> > +
> > +Example:
> > +
> > +rtt at fffffd20 {
> > +		compatible = "atmel,at91sam9g45-rtt", "atmel,at91sam9260-rtt";
> > +		reg = <0xfffffd20 0x10>;
> > +		interrupts = <1 4 7>;
> > +		atmel,at91-rtt-as-rtc-gpbr = <0>;
> no you miss the point of the DT
> 
> you need to describe the hardware no a particular use of it

That was what I was trying to achieve by adding the two use-neutral
rtt and gpbr-nodes. But then the question is how would you influence
which out of two rtt-drivers to use?

Adding a property as above in the final board descriptions seemed
preferable to adding rtt-as-rtc to the compatible string of the rtt as
that would mean describing use rather than just hardware.

> the RTT is a general purpose timer backuped that we use in linux as a
> RTC with a gpbr to store the time
> 
> you need 2 binding on for the RTT one the RTT-rtc

As in adding some virtual hardware-node which uses the rtt and gpbr as
resources?

Thanks,
Johan

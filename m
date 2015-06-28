From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 28 Jun 2015 22:25:45 +0200
Subject: [PATCH V4 1/2] ARM: dts: sun6i: Add dts file for MSI Primo81
 tablet
In-Reply-To: <20150625172219.GA1773@excalibur.cnev.de>
References: <20150618115838.GL11732@lukather>
 <1435078949-3383-1-git-send-email-merker@debian.org>
 <1435078949-3383-2-git-send-email-merker@debian.org>
 <20150625104402.GB2266@lukather>
 <20150625172219.GA1773@excalibur.cnev.de>
Message-ID: <20150628202545.GW2266@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 07:22:19PM +0200, Karsten Merker wrote:
> > > +&ehci0 {
> > > +	/* rtl8188etv wifi is connected here */
> > 
> > No need to mention it, it's what discoverable buses are made for.
> 
> Hello Maxime,
> 
> using the same reasoning that caused you to ask for a description
> of the uart0 config (no external connector available, so why is
> there a uart0 enabled and how is it usable), I think it makes
> sense to leave this comment in the dts.  The Primo 81 doesn't
> have any external USB host connectors and the fact that the
> internal Realtek USB WLAN chip is connected there is the only
> reason that the EHCI controller gets enabled in the dts at all. 
> If you really prefer, I'll remove the comment in a V5; in that
> case please let me know.

Except that you have no way to magically find out where you're
supposed to get the UART from, while the WiFi module will be magically
discovered, reported in the logs, without any kind of user
interaction, and you actually don't even care.

> > > +&uart0 {
> > > +	/* The default uart0 pins (PH20: TX, PH21: RX) are not accessible
> > > +	 * on an external connector. Possible ways to get physical access
> > > +	 * to uart0 include:
> > > +	 * - disabling mmc0, changing the pinmuxing for the SD card pins
> > > +	 *   to the uart0 function (PF2: TX, PF4: RX) and using an SD card
> > > +	 *   breakout board
> > > +	 * - opening the case and finding appropriate test points connected
> > > +	 *   to PH20 and PH21
> > > +	 */
> > 
> > You already made a choice here, so just document the choice you
> > made. I'm guessing from what you said that it's the latter, in which
> > case please document which test points you're talking about.
> 
> Upwards in this thread you wrote:
> > [Karsten Merker wrote]
> > > I have tagged this patch RFC as I am unsure what to do with the
> > > /chosen/stdout-path node. For now, I have set Siarhei's original
> > > choice (first serial port), but I am unsure whether this is the
> > > right thing to do as the Primo81 does by default not have a
> > > user-accessible serial port.  The only way to get a serial
> > > console is to either break the case open and find some test
> > > points that carry the RX/TX lines (which with the Primo81 case
> > > poses a high risk of breaking the display glass), or to use an SD
> > > card breakout board and change the pinmuxing for the SD card pins
> > > to the "serial" function.  The latter would not work without
> > > modifying the dts, so the SD-breakout case doesn't really count
> > > for setting the default stdout-path in the general use case.
> >
> > Having that as a comment on top of whatever uart you've been using
> > would be great, so that people know where to look at on their device
> > to find it.
> 
> Maybe I have misunderstood you, but to my understanding the
> comment I added represents exactly what you asked me to do above?

Sorry if I haven't been clear enough.

> I cannot tell which test points carry the TX/RX lines from PH20
> and PH21 as I have not opened the case (and to my knowledge
> nobody else @linunx-sunxi has done that), due to the fact that
> the Primo 81 doesn't have one of typical cheap two-part plastic
> cases which can be easily opened without destroying anything, but
> a one-part aluminum case which fits tightly with the display
> glass.  To pry open the aluminium case one would have to apply
> pressure to the glass and I don't want to void my warranty and
> risk breaking the display while doing that.
>
> The u-boot and the android kernel that come preinstalled on the
> tablet use PH20 and PH21 for uart0, so there is an extremely high
> probability that there are test points on the board that carry
> these lines, but I cannot tell which ones.

So you enable a device that you have never actually tested, and you
document a procedure you have never seen to be working? I really hope
the rest of the DTS is not made that way too.

> So the same question as above: if you really want me to do
> that, I'll remove the SD card breakout info in a V5 (just tell me
> so), but I think it makes sense to leave it in the dts.

Don't enable what you haven't tested, or anything that isn't used for
what it's been intended to. Which means don't put any UART on there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150628/a2df72d7/attachment.sig>

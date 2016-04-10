From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Apr 2016 11:32:37 +0100
Subject: [linux-sunxi] Re: [PATCH 3/3] sunxi: A20-OLinuXino-LIME2: Add
 i2c2 bus in DTS
In-Reply-To: <56FFF17D.9010000@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
 <20160402103420.GH4227@lukather>
 <56FFF17D.9010000@computerlinguist.org>
Message-ID: <20160410103237.GA4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sat, Apr 02, 2016 at 06:21:17PM +0200, Michael Haas wrote:
> Hello Maxime,
> 
> thank you for taking the time to review this patch set.
> 
> On 04/02/2016 12:34 PM, Maxime Ripard wrote:
> > Hi,
> >
> > On Fri, Mar 25, 2016 at 08:04:07PM +0100, Michael Haas wrote:
> >> The A20 processor provides a third I2C bus on pins PB20 and PB21.
> >> The A20-OLinuXino-LIME2 exposes this bus via its GPIO1 port.
> >>
> >> Olimex also provide a breakout board called the
> >> A20-OLinuXino-LIME2-UEXT. This change is required to properly
> >> support I2C on the UEXT connector found there.
> >>
> >> Signed-off-by: Michael Haas <haas@computerlinguist.org>
> >
> > What are the other options on that pin? Is it something exclusively
> > dedicated to i2c on the pin headers and the documentation, or is
> > anyone free to use that pin for whatever he wishes?
> >
> > Thanks,
> > Maxime
> 
> I assume you are talking about the UEXT connector, not about PB20 and
> PB21. These are regular GPIO pins multiplexed with I2C, but no other
> function.
> 
> Regarding UEXT: the A20-OLinuXino-LIME2-UEXT breakout board supports two
> use cases here.
> 
> The first one: provide a simple adapter from the 0.05" pin headers on
> the olinuxino to the more common world of 0.1" headers. In this use
> case, you can plug the A20-OLinuXino-LIME2-UEXT intoany of LCD_CON or
> GIO-{1,2,3} and you're good to go.
> 
> The second one: here, you want to use UEXT modules provided by Olimex.
> It's a simple connector exposing I2C, SPI and UART as mentioned by
> Priit. To use UEXT, you have to use GPIO-1 to get the correct pin mapping.
> 
> Regarding the official documentation provided by Olimex. The
> A20-OLinuXino-Lime2_Rev_c.pdf shows the pins on GPIO-1 as PB20 and PB21.
> In the schematics for the breakout board,
> A20-OLinuXino-Lime2-UEXT_sch.pdf, the pins for the UEXT connector are
> labeled as PB20/SCK and PB21/SDA. This acknowledges the double use.
> However, PB20 and PB21 have pull-ups by default according to
> A20-OLinuXino-Lime2_Rev_c.pdf,
> which makes them a lot more useful as I2C than as GPIO.

Thanks for the explanation.

> What originally prompted me to submit this patch: I bought a breakout
> board and a small LCD with UEXT connector together with my board. Then I
> found out that it doesn't work out of the box because i2c2 is not
> enabled. Since using UEXT is probably common for that particular
> vendor, I believe it should be enabled by default.

Unfortunately, if it isn't present on the main board, it shouldn't be
in the DT for that board. Otherwise, people relying on these pins and
not using the UEXT connector would be force fed a configuration that
they don't want, without any way to remove it.

That kind of adjustements is a perfect use case for the overlays
though, so I'd rather suggest writing one for the UEXT connector.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160410/9d53644d/attachment.sig>

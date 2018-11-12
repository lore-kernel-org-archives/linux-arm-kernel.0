From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2018 17:00:05 +0000
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <fd70023a-815b-697a-d01f-6ae9efb83653@axentia.se>
References: <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
 <20180731074114.GF17271@n2100.armlinux.org.uk>
 <9d48e374-be2f-fbc0-ca92-1b7e1b68e358@axentia.se>
 <20180731092343.GH17271@n2100.armlinux.org.uk>
 <9bf5e0e9-c1e8-5af2-7fea-40f9618d4d52@axentia.se>
 <20180731111537.GJ17271@n2100.armlinux.org.uk>
 <59eeb1c4-163c-4fda-d51e-27f2f404fe3e@axentia.se>
 <20180801093528.GC30658@n2100.armlinux.org.uk>
 <1ad8d087-40a8-7a00-31cf-c4d34a9a12fb@axentia.se>
 <fd70023a-815b-697a-d01f-6ae9efb83653@axentia.se>
Message-ID: <20181112170005.GH30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 04:50:37PM +0000, Peter Rosin wrote:
> On 2018-08-02 08:06, Peter Rosin wrote:
> > On 2018-08-01 11:35, Russell King - ARM Linux wrote:
> >> On Wed, Aug 01, 2018 at 11:01:12AM +0200, Peter Rosin wrote:
> >>> I don't think it's a problem with the atmel I2C driver. IIRC, the
> >>> tda998x driver issues the command a initiate the EDID read, but that
> >>> times out. So it appears to be the TDA19988 that fails to read the
> >>> EDID over the DDC bus? Which brings me to the double problem with the
> >>> scopes mentioned above...
> >>
> >> It sounds like it.
> >>
> >> It may be helpful to know that there are HDMI pass-through boards
> >> available that give access to all the HDMI signals:
> >>
> >> https://elabbay.myshopify.com/collections/camera
> >> https://elabbay.myshopify.com/collections/camera/products/hdmi-af-af-v1a-hdmi-type-a-female-to-hdmi-type-a-male-pass-through-adapter-breakout-board
> >>
> >> I've never bought from them, so please don't take this as a
> >> recommendation - the fact that there seems to be no company details
> >> on their site doesn't seem good, and as the whois for elabbay.com is
> >> obscured also doesn't give me any confidence to buy from them.
> > 
> > I still will not be able to inspect the DDC bus between the TDA19988
> > and the buffer circuit (IP4786), but the gadget seems useful enough and
> > it's not a shitload of money. We'll see how long it takes for it to get
> > here...
> > 
> > Thanks for the pointer! Maybe :-)
> 
> I got the pass-through board a while back, and that board works as expected
> and there was no problem with ordering etc. What I could see with that was
> that the TDA19988 was able to initiate a start condition (SDA -> low) but
> then nothing more happened.
> 
> Then last week, someone noticed that even though the TDA19988 is driven by
> 1.8V, it still needs the high signals of the DDC bus to be above 3V, which
> was unexpected and not catered for by the design. Changing VCC(SYS) of the
> buffer circuit in place (IP4786, pin 27) to 3.3V fixed the issue and EDID
> reading works, and this was confirmed earlier today.
> 
> So, the problem was that the TDA19988 only ever saw "low" DDC signals, and
> probably aborted when the bus appeared busy. Or something.

Thanks for following up on this issue.

Normally, if a master device sees that the I2C clock is being held low,
it assumes that a slave is "clock stretching" and it will wait until it
is raised.  I wonder if that's what is causing this issue here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

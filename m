From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Jun 2013 22:55:12 +0100
Subject: Armada DRM driver on OLPC XO
In-Reply-To: <CAMLZHHSmoxDamhW6vcdfqhWH=FKR1m5-Z95P8LSZ+SFDO=yVhA@mail.gmail.com>
References: <20130625204726.BF65C12647A@dev.laptop.org>
 <20130628212723.GK4283@n2100.arm.linux.org.uk>
 <CAMLZHHSmoxDamhW6vcdfqhWH=FKR1m5-Z95P8LSZ+SFDO=yVhA@mail.gmail.com>
Message-ID: <20130628215512.GM4283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 03:36:37PM -0600, Daniel Drake wrote:
> On Fri, Jun 28, 2013 at 3:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jun 25, 2013 at 04:47:26PM -0400, Daniel Drake wrote:
> >> I have tested it on OLPC XO-1.75 (MMP2 aka Armada610) and OLPC XO-4 (MMP3
> >> aka PXA2128). After a bit of fighting, I have it running. Could you share your
> >> X driver, or your methodology for testing hardware cursors? I'd like to test
> >> your work there too.
> >
> > BTW... a point on this.  As you don't have the LCD_SPU_ADV_REG register,
> > you probably don't have support for ARGB cursors.  DRM only supports ARGB
> > cursors.  You can't down-convert an ARGB cursor to something which looks
> > reasonable in the kernel, so I'd suggest forgetting hardware cursors.
> > Even converting ARGB to transparency + RGB looks rubbish and wrong.
> 
> Interesting. Yes, a previous developer battled unsuccessfully with
> hardware cursors and in the end we ended up using low color depth ones
> which don't look great. I was wondering if you had found something
> new, but it sounds like that we really are limited by the hardware.

The "something new" is that the Armada 510 has support for ARGB, not
quite in the size that X and DRM prefers (64x64), but nevertheless
it's full alpha-blended RGB.  64x32 seems to work and X seems to be
happy with it - but there's no way at the moment for DRM to tell X
about that kind of capability (so a generic kms driver can't use it.)

However, as I say, that's not available on your SoC if you don't have
the LCD_SPU_ADV_REG register.

My plan is to push the cursor support out to the growing variant
backends, and leave it unimplemented on anything but Armada 510.

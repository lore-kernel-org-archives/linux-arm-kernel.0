From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 16 Feb 2012 08:27:04 -0800
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120216091352.GK3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120216091352.GK3852@pengutronix.de>
Message-ID: <20120216162703.GB3383@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 10:13:52AM +0100, Sascha Hauer wrote:
> On Wed, Feb 15, 2012 at 11:58:26PM -0800, Mark Brown wrote:

> > It's not per device, of course - there's an overhead from putting a
> > fixed regulator in but then per supply it's just a line.

> You mean one supply if the voltages are the same, right? Otherwise
> we need multiple fixed regulators (or we shouldn't claim that the
> board-dummy-fixed-catch-all regulator has a particular voltage)

I'd expect that anyone who's bothered by all this stuff wouldn't be
going to fill in the voltages accurately.

> > This is obviously not good for users, they'd still have to do error
> > checking to determine if the device was created or not and then manually
> > register the device with the driver core and ideally also care if that
> > worked or not.

> I understand that error checking is a good idea, but what do you mean
> with 'manually register the device with the core'? The regulator is
> registered with the core in this function.

Oh, in that case it seems really odd that it's returning a pointer to
the device rather than just returning success or failure.

> > Of course with device tree this all becomes moot as this won't be
> > happening from code anyway...

> I wonder what the devicetree guys will do with this situation anyway.
> The devicetree won't describe regulators that are actually not present
> in the hardware, does it?

In all these cases there is actually a physical supply of some kind; if
there isn't one then you'd expect the driver would have explicit code to
handle that in some way.

> Don't get me wrong. All I want is just a way for people to be able to
> add regulator support to drivers *without* breaking its users. Normally
> we have the policy in the kernel that changes to the kernel do not break
> its users. The smsc case violated this and it will happen again. In the
> end it doesn't even matter if a particular board could control a supply
> via software or not. Patches should not simply declare all users of a
> driver as broken.

Yes, I'm quite disappointed with people who are adding regulator support
without making an effort to go round all the uers and at least notify
the existing users of the device that they need updates.  There's a
limited amount we can do in the core
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120216/37a0292b/attachment.sig>

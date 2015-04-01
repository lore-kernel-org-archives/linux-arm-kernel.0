From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 01 Apr 2015 12:40:37 +0200
Subject: [PATCH RFC v2 04/12] drm/components: add generic vga encoder
 driver
In-Reply-To: <20150401102751.GZ24899@n2100.arm.linux.org.uk>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
 <1427882986-19110-5-git-send-email-heiko@sntech.de>
 <20150401102751.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <10579338.tTk9pSqjzX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Mittwoch, 1. April 2015, 11:27:51 schrieb Russell King - ARM Linux:
> On Wed, Apr 01, 2015 at 12:09:38PM +0200, Heiko Stuebner wrote:
> > This adds a driver for generic vga encoders like the Analog Devices
> > adv7123
> > and similar ics. These chips do not have any special configuration options
> > except a powersafe gpio.
> > 
> > An exception is added for the rcar-du driver which also implements support
> > for the adv7123 internally but is not yet converted to the component
> > framework.
> Why is this implemented as a master?  It's not the top level card device,
> it shouldn't be a master.  It should be a component.
> 
> I wonder if this is why you need your previous patches.  Componentised
> DRM works fine without needing to build lists of connectors and encoders.

It is a component to the upper drm driver (rockchip or whatever) but a master 
to the vga connector below, simply because the drm driver above (the lvds 
controller in this case) does not know and also probably shouldn't care what 
the structure below is.

So in this case the lvds knows there is either a panel or an encoder 
connected, but does not need to handle if this downstream component is some 
one-piece i2c component like a tv encoder or contains another component down 
below, like the vga-connector in this case.


Of course I may very well have overlooked some simpler method to achieve this, 
but got inspired to this by the similar way done in sti/sti_tvout.c


Heiko

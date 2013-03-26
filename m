From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Mar 2013 20:48:29 +0100
Subject: [PATCH 2/3] arm: kirkwood: factor pinmux descriptors for
 OpenBlocks A6
In-Reply-To: <20130322164440.5e5735d7@skate>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306181648.GE3904@lunn.ch> <20130322164440.5e5735d7@skate>
Message-ID: <20130326194829.GG631@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 04:44:40PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Wed, 6 Mar 2013 19:16:48 +0100, Andrew Lunn wrote:
> > On Wed, Mar 06, 2013 at 05:23:40PM +0100, Thomas Petazzoni wrote:
> > > The OpenBlocks A6 .dts file was using a long list of pinmux
> > > descriptors to select each GPIO of the external GPIO connector and the
> > > internal DIP switch, for no apparent reason. This commit factors those
> > > GPIO pins into two descriptors: one for the external GPIO connector
> > > and one for the internal DIP switch.
> > 
> > Hi Thomas
> > 
> > There is no need to pinmux gpio pins at all. The pinctrl driver does
> > it when the gpio driver requests the pins.
> > 
> > This stems from an error i made. I also didn't know this and added
> > hogs for gpio pins as i converted some boards. Others have then just
> > cut/paste my error.....
> 
> I was looking at this today to send an updated version of those
> patches. However, it turns out that having the pinctrl-0 property to
> associate pinmux configurations to a device has an advantage: pinctrl
> knows about this association.
> 
> If you keep the pinctrl-0 property in gpio-leds and gpio-keys,
> then /sys/kernel/debug/pinctrl/f1010000.pinctrl/pinmux-pins looks like
> this:
> 
> ======================================================================
> pin 38 (PIN38): gpio_keys.2 mvebu-gpio:38 function gpio group mpp38
> pin 39 (PIN39): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 40 (PIN40): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
> pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
> pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43
> ======================================================================
> 
> On the other hand, if you remove the pinctrl-0 property, the same file
> looks like this:
> 
> ======================================================================
> pin 38 (PIN38): (MUX UNCLAIMED) mvebu-gpio:38
> pin 39 (PIN39): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 40 (PIN40): (MUX UNCLAIMED) (GPIO UNCLAIMED)
> pin 41 (PIN41): (MUX UNCLAIMED) mvebu-gpio:41
> pin 42 (PIN42): (MUX UNCLAIMED) mvebu-gpio:42
> pin 43 (PIN43): (MUX UNCLAIMED) mvebu-gpio:43
> ======================================================================
> 
> So you no longer know by what device the pin is claimed. It is not
> horrible of course, but I find it quite nice to be able to see which
> pin is used by what device.
> 
> What do you think?

Hi Thomas

I think the first is more informative. Please use that.

  Thanks
	Andrew

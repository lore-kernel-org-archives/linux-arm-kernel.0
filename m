From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 27 Apr 2011 17:16:42 -0500
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <20110427215509.GE17290@n2100.arm.linux.org.uk>
References: <92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
	<BANLkTinv-MSg5Sobg2X1cJpAwPkM1Gevcg@mail.gmail.com>
	<BANLkTi=Oc+y+31KugbEy66Mp96=bf_G8Mg@mail.gmail.com>
	<BANLkTinv_-6dJJXAWc=NFTceXGA9sabanA@mail.gmail.com>
	<20110420163238.5f0e5ea6@lxorguk.ukuu.org.uk>
	<20110427215509.GE17290@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B027084269764D26C391E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 27, 2011 2:55 PM, Russell King wrote:
> On Wed, Apr 20, 2011 at 04:32:38PM +0100, Alan Cox wrote:
>>> Even if some people are only muxing pins that can also be used as GPIO,
>>> this is not always the case. We can shunt out the same pins to be used as
>>> I2C or SPI for example, that means this cannot be handled in a GPIO
>>> driver since it has nothing to do with GPIO pins at all.
>> 
>> It sounds very much to me like it belongs in the GPIO driver. That is the
>> one piece of code which knows what it is doing for all this configuration.
>
> I don't think so.  See PXA devices, where MFP (multifunction pin)
> configuration is entirely separate from GPIO - and there's some MFPs
> which don't even have GPIOs associated with them.
>
> If I'm reading the PXA930 MFP header file right, it also appears that
> GPIOs can be configured on to multiple different pins (eg, GPIO46 can
> be on GPIO46 or DF_nWE.  So refering to GPIO46 does not give you
> sufficient information for exactly what pin is to be configured here.
>
> To complicate matters, MFP configuration on PXA deals with stuff like
> low power mode configuration, drive strength, etc which is completely
> independent of the GPIO layer.

I agree with Russell.  The muxing goes way beyond GPIO use.

On the i.MX for example, the iomux is used to configured what the pads on the
chip are used for.  The pad configuration might be gpio related or it could be
setting the pad for use by one of the internal peripherals.

For instance, on the i.MX35 the uart3 rxd signal can appear on the pads: RTS2,
SD2_DATA0, ATA_DATA10, or FEC_TX_CLK.  All of these pads can also be configured
as a gpio or for use by some other on-board peripheral.

Also, like Russell mentions for the PXA930, some of the gpios can be routed to
multiple pins.  And some of the pads have no gpio use but multiple other uses.

Regards,
Hartley

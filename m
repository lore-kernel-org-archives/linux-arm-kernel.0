From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Feb 2014 08:25:11 +0900
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <1528854.BAQRr94nzx@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1580658.FIe4en5bEU@wuerfel> <52FF6A16.5080201@gmail.com>
 <1528854.BAQRr94nzx@wuerfel>
Message-ID: <20140217232511.GA2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 05:21:11PM +0100, Arnd Bergmann wrote:
> On Saturday 15 February 2014 14:22:30 Tomasz Figa wrote:

> > I'm not sure if we should assume that SPI = MMC over SPI. I believe 
> > there might be a custom protocol involved as well.

> In case of SD/MMC, you essentially have three separate command sets:
> SPI, MMC and SD, and each of them has multiple versions. MMC and SD
> compatible devices generally also support the SPI command set (IIRC

...

> If a device supports both SDIO and SPI, I think a straightforward
> implementation would be to use the exact same command set, but
> you are right that this isn't the only possibility, and the SD/MMC
> shows how they can be slightly different already.

I'm aware of existing devices that do in fact break this assumption.

> > Stepping aside from SPI, I already gave an example of a WLAN chip that 
> > supports multiple control busses [1]. In addition to the commonly used 
> > SDIO, it supports USB and HSIC as well:

> > [1] http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf

> > Moreover, some of Samsung boards use HSIC to communicate with modem 
> > chips, which have exactly the same problem as we're trying to solve here 
> > - they need to be powered on to be discovered.

> Thanks, this definitely makes a good example. I see that it also
> supports SPI mode for SDIO as mentioned in your link.

Slimbus has all these issues too with the added fun that for normal
operation some devices want to be in a low power mode where they're
disconnected from the Slimbus a lot of the time.

> * Olof's proposal (add properties or a child node to the host
>   controller node with just power-on sequencing information):
>   + We only need one implementation for each bus, possibly shared
>     across buses to some degree, and can handle lots of devices
>     without having to touch their individual drivers.
>   + A logical extension of things we already do on SD cards
>     (CD/WP GPIOs, external clocks and voltages supplied to
>     standard compliant devices as part of the normal probing)
>   - The shared code may get rather complex to deal with all
>     possible corner cases we run into over the years.
>   - Somewhat harder to do if you have to attach the power
>     information to a device node for a USB hub port, rather
>     than an SDIO controller that only has one slave device.

We would also need mechanisms to allow devices to take over the running
of their own resources for cases like the Slimbus ones I mentioned, and
some mechanism to cope with devices that hotplug themselves in normal
operation.

> * Arnd's proposal (change bus code to probe nonstandard devices
>   from DT if we can't easily detect them):

I've also proposed this in the past FWIW but never got far enough
through my list of things I want to do with my subsystems to actually
start coding.

>   - Has to be implemented in each driver that needs it, making
>     it harder to share code for drivers with the same need
>     (e.g. every device that just needs an external reset
>     trigger).

I think we can probably come up with some standard helpers that work
well for the common case here (see also some of the discussions about
power domains ensuring that core IP clocks are provided for IPs, it's
kind of circling back to the same issues).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/ff86593e/attachment.sig>

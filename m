From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 5 May 2012 01:03:09 +0100
Subject: Handling of modular boards
In-Reply-To: <20120504235225.GN897@n2100.arm.linux.org.uk>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <20120504225514.GM897@n2100.arm.linux.org.uk>
 <20120504234056.GV14230@opensource.wolfsonmicro.com>
 <20120504235225.GN897@n2100.arm.linux.org.uk>
Message-ID: <20120505000308.GX14230@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2012 at 12:52:25AM +0100, Russell King - ARM Linux wrote:

> How about this - we have struct platform_device_info, which is used to
> create platform devices.  We can use this as an array to describe what
> platform devices to create in the sub-driver, including what the resources
> should be etc.

We (well, I at least) need to handle devices on other buses like I2C and
SPI too but yes, that's the sort of thing I was looking for.

> However, there's a problem with this - what if you need to do some board
> level init before hand?  That needs to be handled somehow before these
> devices are instantiated.  That could be done via a callback through
> platform data.

> But... this all seems wrong, because rather than having a driver which
> knows about the details of the board, we now have all the details of the
> board in question back in platform code which originally declared the
> board device.  That's wrong, because a daughter board may be shared
> between different platforms, and we don't want multiple copies of that
> data all around the place.

> I don't think there's an easy or generic solution to this.

I think that's OK - if there's any init stuff that needs to be done on a
prior to identification of the board then presumably it's a generic
thing for the motherboard which will apply to any plugin module on that
board and can be done as part of the normal board init.  If the init
needs to be done after identification of the board then probably it
applies to any motherboard the board might be plugged in to so we can
just define callbacks for the plugin module that can be part of the
plugin module description.

Cases that depend on a specific combination will doubtless exist and do
have the problems you describe but are probably less frequent but I
think we can go a long way on the first two.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120505/b9172675/attachment.sig>

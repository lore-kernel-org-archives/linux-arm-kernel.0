From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Nov 2012 12:07:14 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdbCk9+HSBPtfT-1dO8paSRYJ5VXX_0SxiyxgrObnJEvmQ@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
 <20121030113407.GA24335@sirena.org.uk>
 <CACRpkdapQJY0aoam741O0fb8EeM9BLk_Psq5TaPG84J7wEvCLw@mail.gmail.com>
 <87obji8kta.fsf@deeprootsystems.com>
 <CACRpkdbCk9+HSBPtfT-1dO8paSRYJ5VXX_0SxiyxgrObnJEvmQ@mail.gmail.com>
Message-ID: <20121101120713.GA4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 09:54:00AM +0100, Linus Walleij wrote:

> Well, the pinctrl grabbers in these drivers are using these states also
> for platforms that do not even select CONFIG_PM.  For example
> mach-nomadik is quite happy that the PL011 driver is thusly
> muxing in its pins. And would require refactoring to use PM
> domains.

> So basically this requirement comes down to:

> - When dealing with a SoC IP block driver

> - That need to multiplex pins

> - Then your SoC must select CONFIG_PM and
>   CONFIG_PM_RUNTIME and
>   CONFIG_PM_GENERIC_DOMAINS and implement
>   proper domain handling hooks.

> Is this correct? And for Mark, Dmitry, does this correspond to
> your view?

For the pin hogging I'd actually been thinking separately that we should
just have the device core do a devm_pinctrl_get_set_default() prior to
probing the device and store the result in the struct device.  That
would immediately remove almost all of the current pinctrl users, users
that do need to do things with the data or check the result can then
pick up the pinctrl pointer from the device struct.

> It's actually something that needs to be acknowledged by the
> ARM SoC maintainers, because they will be the ones telling
> all subarch maintainers to go implement full PM handling
> with these three frameworks whenever an SoC driver want
> to handle pins.

Well, they're going to have to implement it somewhere anyway - either in
the drivers or in the SoC stuff.

> And IIUC not only pins but also silicon block clocks?

> I can surely fix these for "my" systems, but it really needs
> to be enforced widely or it will be a mess.

We definitely need to decide if it's something that should be open coded
everywhere.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121101/872838fb/attachment-0001.sig>

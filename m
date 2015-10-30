From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 30 Oct 2015 10:47:03 +0100
Subject: [PATCH] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
In-Reply-To: <CAMuHMdXBcZAXSm1hXv6E-hW9Zp-bPLpp-HxuWukS-Y837LBneQ@mail.gmail.com>
References: <1446151497-29833-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CAMuHMdXBcZAXSm1hXv6E-hW9Zp-bPLpp-HxuWukS-Y837LBneQ@mail.gmail.com>
Message-ID: <1446198423.4092.285.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-10-30 at 10:15 +0100, Geert Uytterhoeven wrote:
> Hi Sjoerd,
> 
> On Thu, Oct 29, 2015 at 9:44 PM, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:
> > Add an ethernet0 alias for the wired network card and an all 0
> > default
> > mac address so that u-boot can find the device-node and fill in the
> > mac address.
> 
> Thanks a lot!
> 
> I had the same issue on another board, and adding an "ethernet0"
> alias
> fixes it.

Happy to help, this stuff is really not that well document
unfortunately.

> > @@ -130,6 +134,8 @@
> > ?};
> > 
> > ?&gmac {
> > +???????/* To be filled in by U-Boot */
> > +???????mac-address = [00 00 00 00 00 00];
> > ????????status = "ok";
> > ?};
> 
> Note that in my case I didn't have to add an empty mac-address
> property.
> U-Boot (2015.04-something --- don't have the sources) seems to add a
> "local-mac-address" property automatically.

After submitting the patch i actually dived a bit deeper at how this
all hangs together.

The linux kernel checks for mac-address, local-mac-address and address
in the fdt node, in that order of preference. u-boot (at least recent
ones like you have), will set the mac-address property *if* it's
already defined but will always create the local-mac-address property
regardless.

So indeed practially, as you noticed, just setting the alias is enough.
I'm now just very confused about the intended meanings of the
properties, Documentation/devicetree/bindings/net/ethernet.txt doesn't
shed a lot of light on it:

- local-mac-address: array of 6 bytes, specifies the MAC address that?
? was assigned to the network device;
- mac-address: array of 6 bytes, specifies the MAC address that was?
? last used by the boot program; should be used in cases where the MAC?
? address assigned to the device by the boot program is different from?
? the "local-mac-address"property;

So yeah, I'm not sure what the "correct" fix is. It's tempting to
indeed just leave out the mac-address property though :)

-- 
Sjoerd Simons
Collabora Ltd.

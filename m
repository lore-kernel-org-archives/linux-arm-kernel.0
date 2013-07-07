From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Jul 2013 09:15:01 +0200
Subject: MTD EEPROM support and driver integration
In-Reply-To: <8997501.Dchyii8uWX@wuerfel>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
Message-ID: <20130707071501.GD11243@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 09:06:49PM +0200, Arnd Bergmann wrote:
> On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:
> > What other option would we have?
> > 
> > I also thought about writing an EEPROM framework of its own, but the
> > line is really thin between a large EEPROM and say a small SPI
> > dataflash, which would make it pretty hard to choose between such a
> > framework and MTD.
> 
> Isn't flash by definition block based, while EEPROM can be written
> in byte or word units? I think that is a significant difference, although
> it doesn't necessarily mean that we can't use MTD for both.

Ah, right.

> We also have a bunch of OTP drivers spread around the kernel, it probably
> makes sense to consolidate them at the same time, at least on the DT binding
> side if not the device drivers.

>From a quick grep, the only one I've seen so far are:
  - imx6q, that has a hook at machine start to poke into its OCOTP to
    retrieve some frequency scaling parameters it seems. I'm not sure
    how the current solution could improve the situation for this
    use-case, but the DT bindings of the OCOTP is just a DT node, with
    no clients, so we have nothing to worry about here.
  - imx28, that has a hook at machine start to look up the MAC address
    values and patch the ethernet controller nodes to add the right
    local-mac-address property. This one could benefit from the new
    bindings, but we already mentionned it, and I intended to develop
    with an imx28 board anyway.
  - picoxcell-pc3x3 DTSI has a node for a OTP device, but they don't
    seem to be doing anything with it, nor do they seem to have a driver
    for it. So I guess we don't care about migrating for this one
    either.

Did you have other cases in mind?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130707/43d6a3f5/attachment.sig>

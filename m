From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Jul 2014 10:35:09 +0200
Subject: a case for a common efuse API?
In-Reply-To: <53BC4DD7.20906@codeaurora.org>
References: <53BC4DD7.20906@codeaurora.org>
Message-ID: <20140709083509.GQ13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Jul 08, 2014 at 01:00:23PM -0700, Stephen Boyd wrote:
> Hi,
> 
> On MSM chips we have some efuses (called qfprom) where we store things
> like calibration data, speed bins, etc. We need to read out data from
> the efuses in various drivers like the cpufreq, thermal, etc. This
> essentially boils down to a bunch of readls on the efuse from a handful
> of different drivers. In devicetree this looks a little odd because
> these drivers end up having an extra reg property (or two) that points
> to a register in the efuse and some length, i.e you see this:
> 
> 	thermal-sensor at 34000 {
> 		compatible = "sensor";
> 		reg = <0x34000 0x1000>, <0x10018 0xc>;
> 		reg-names = "sensor", "efuse_calib";
> 	}
> 
> 
> I imagine in DT we want something more like this:
> 
> 	efuse: efuse at 10000 {
> 		compatible = "efuse";
> 		reg = <0x10000 0x1000>;
> 	}
> 
> 	thermal-sensor at 34000 {
> 		compatible = "sensor";
> 		reg = <0x34000 0x1000>;
> 		efuse = <&efuse 0x18>;
> 	}

We have pretty much the same things in the Allwinner SoCs. We have an
efuse directly mapped into memory, with a few informations like a MAC
address, the SoC ID, the serial number, some RSA keys for the device,
etc.

The thing is, some boards expose these informations in an external
EEPROM as well.

I started working and went quite far to create an "eeprom" framework
to handle these cases, with a dt representation similar to what you
were exposing.

https://github.com/mripard/linux/tree/eeprom-framework-at24

It was working quite well, I was about to send it, but was told that I
should all be moved to MTD, and given up on it.

Anyway, +1 for this :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/87e3b136/attachment.sig>

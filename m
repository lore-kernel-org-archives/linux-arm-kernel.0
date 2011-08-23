From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 23 Aug 2011 11:49:56 -0700
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <CACRpkdY=nVQYnznTU7=_D0n1V1U_xOKH2y75-jKp7k7NzwH8Zw@mail.gmail.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161509.17157.arnd@arndb.de>
	<CACRpkdaVx=6AJ5DFjVN1ZYQ++hu9pT6WxD9n+pqmYVaCf1xawg@mail.gmail.com>
	<201108161637.16620.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA25368@HQMAIL01.nvidia.com>
	<CACRpkdY=nVQYnznTU7=_D0n1V1U_xOKH2y75-jKp7k7NzwH8Zw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A38E6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Tuesday, August 23, 2011 6:51 AM:
> On Tue, Aug 16, 2011 at 7:12 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > One issue here: There isn't always a single gpio/pinmux parent; as a
> > concrete example, the ALSA/ASoC driver for Tegra+WM8903 uses GPIOs both
> > from Tegra itself, and from the WM8903 audio codec.
> 
> The Ux500 have pinmuxing on the DB8500 and AB8500 - the latter
> is a PMIC (&misc) connected to the DB8500 via I2C.
> 
> In the pincontrol subsystem I'm brewing, each of these will have
> their own pin controller instance and their own struct gpio_chip as
> well, so:
> 
> DB8500: pinctrl.0, gpio.0
> AB8500: pinctrl.1, gpio.1

Makes sense to far.

> Each GPIO chip may have it's respective pin controller as parent
> I guess, or they may simply be the same struct device * whatdoIknow.

I'm not clear on why the GPIO and pinmux would have any kind of parent
relationship. Perhaps that's how your HW is designed. In Tegra, GPIO
and pinmux are completely separate HW blocks without much of a defined
relationship.

I can certainly see both being implemented by the same code if it makes
sense to do so. On Tegra, I think I'd still lean towards keeping them
as separate devices, since they have separate register spaces and are
documented separately etc. However, I can certainly see that other HW
might have both sets of functionality in one HW block.

> I know this is vaporware, but does this reasoning hold also to
> the Tegra+WM8903 combo?

-- 
nvpublic

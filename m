From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 16:37:16 +0200
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <CACRpkdaVx=6AJ5DFjVN1ZYQ++hu9pT6WxD9n+pqmYVaCf1xawg@mail.gmail.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161509.17157.arnd@arndb.de>
	<CACRpkdaVx=6AJ5DFjVN1ZYQ++hu9pT6WxD9n+pqmYVaCf1xawg@mail.gmail.com>
Message-ID: <201108161637.16620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 August 2011, Linus Walleij wrote:
> One specific thing worries me: Grant asked me to make sure
> to NOT create a global pin number space for the pinmuxes (and thus
> pinctrl). This means that in order to proceed, mappings of pinmux
> groups or pincontrol (such as bias) groups, each device using such
> an entity need to reference the intended pincontroller/mux instance.
> 
> Say mmc instance 0 need pingroup foo on pincontroller bar
> means that there must be a specific reference from mmc.0:s
> struct device * to pinctrl bar:s struct device *. Maybe this is
> peanuts in DT, sorry not enough insight.

I think what you are looking for is the equivalent of the
interrupt-parent property for pinmux. The idea is that each
node in the device tree can point to a device managing the
pinmux, so reference would point to a local number in that
space. We have discussed this for the GPIO case already, and
I suspect that the two should be identical (gpio-controller
and pinmux-controller using the same device node and same
property to refer to them). Since the pinmux-parent
(gpio-parent, ...) property gets inherited by all child
devices, you only need to set it once at the root of the
device tree for the simple case where there is only one
controller.

	Arnd

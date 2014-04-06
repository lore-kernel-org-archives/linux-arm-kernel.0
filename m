From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 6 Apr 2014 20:04:54 +0800
Subject: [PATCH] ARM: i.MX6: update KSZ9031 phy fixup
In-Reply-To: <20140406112655.GP7528@n2100.arm.linux.org.uk>
References: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
 <20140402220125.4e203cd2@crub>
 <1396533947.25686.22.camel@EMBLYSD005.adetelgroup.com>
 <20140406110635.GA24260@dragon>
 <20140406112655.GP7528@n2100.arm.linux.org.uk>
Message-ID: <20140406120452.GD24260@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 12:26:55PM +0100, Russell King - ARM Linux wrote:
> Ergh.  So much for "DT describes the hardware, not the software
> implementation."
> 
> commit 954c396756e3d31985f7bc6a414a988a4736a7d0
> Author: Sean Cross <xobs@kosagi.com>
> Date:   Wed Aug 21 01:46:12 2013 +0000
> 
>     net/phy: micrel: Add OF configuration support for ksz9021
> 
>     Some boards require custom PHY configuration, for example due to trace
>     length differences.  Add the ability to configure these registers in
>     order to get the PHY to function on boards that need it.
> 
>     Because PHYs are auto-detected based on MDIO device IDs, allow PHY
>     configuration to be specified in the parent Ethernet device node if no
>     PHY device node is present.
> 
> If we were describing the hardware, we'd create a node for the phy and put
> the phy specific properties in there, and reference it from the ethernet
> driver, and have some way to look up the phy node when we automatically
> discover the phy.

This is exactly how new style devices work, like allwinner case below.

  arch/arm/boot/dts/sun4i-a10-a1000.dts
  drivers/net/ethernet/allwinner/sun4i-emac.c

> 
> Well, it's too late to do anything else now, we're stuck with this, and
> I guess everyone's going to be stuffing the phy chip's configuration into
> the ethernet device's node from now on. :(

Let's take a look at ksz9021_config_init().

	if (!of_node && dev->parent->of_node)
		of_node = dev->parent->of_node;

It's a stepping back in case that the phy device has no of_node
attached.  So for phy devices that are initiated from device tree like
allwinner case above, they will just work in the sane way.

Shawn
